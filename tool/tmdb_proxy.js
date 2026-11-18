#!/usr/bin/env node
'use strict';

/**
 * Proxy TMDB minimale per Scena.
 *
 * - Inietta il token lato server: la chiave non finisce mai nel bundle web.
 * - Consente solo le rotte TMDB usate dall'app (search, dettagli, generi,
 *   configurazione immagini).
 * - Abilita CORS per l'app Flutter Web in sviluppo.
 *
 * Non è pensato per essere esposto pubblicamente così com'è: aggiungi
 * autenticazione, rate limiting e HTTPS prima di un deploy reale.
 */

const fs = require('node:fs');
const http = require('node:http');
const https = require('node:https');
const path = require('node:path');
const { URL } = require('node:url');

loadDotEnv(path.join(__dirname, '..', '.env'));

const PORT = Number.parseInt(process.env.PORT ?? '8787', 10);
const HOST = (process.env.HOST ?? '127.0.0.1').trim();
const BEARER_TOKEN = (process.env.TMDB_BEARER_TOKEN ?? '').trim();
const API_KEY = (process.env.TMDB_API_KEY ?? '').trim();
const ALLOWED_ORIGIN = (process.env.ALLOWED_ORIGIN ?? '*').trim() || '*';
const UPSTREAM_HOST = 'api.themoviedb.org';
const UPSTREAM_PREFIX = '/3';
const REQUEST_TIMEOUT_MS = 12000;

const ROUTES = [
  /^\/search\/movie\/?$/,
  /^\/search\/tv\/?$/,
  /^\/movie\/\d+\/?$/,
  /^\/tv\/\d+\/?$/,
  /^\/genre\/(movie|tv)\/list\/?$/,
  /^\/configuration\/?$/,
];

const ALLOWED_QUERY = new Set([
  'query',
  'page',
  'language',
  'include_adult',
  'append_to_response',
]);

const server = http.createServer((request, response) => {
  applyCors(response);

  if (request.method === 'OPTIONS') {
    response.writeHead(204);
    response.end();
    return;
  }

  if (request.method !== 'GET') {
    sendJson(response, 405, {error: 'Metodo non consentito. Usa GET.'});
    return;
  }

  let incoming;
  try {
    incoming = new URL(request.url ?? '/', `http://${request.headers.host ?? 'localhost'}`);
  } catch {
    sendJson(response, 400, {error: 'URL non valido.'});
    return;
  }

  const pathname = decodeURIComponent(incoming.pathname).replace(/^\/+/, '/');
  if (!ROUTES.some((route) => route.test(pathname))) {
    sendJson(response, 404, {
      error: 'Rotta non consentita.',
      hint: 'Il proxy espone solo le rotte TMDB usate da Scena.',
    });
    return;
  }

  if (!BEARER_TOKEN && !API_KEY) {
    sendJson(response, 500, {
      error:
        'Proxy non configurato: imposta TMDB_BEARER_TOKEN oppure TMDB_API_KEY.',
    });
    return;
  }

  const query = new URLSearchParams();
  for (const key of ALLOWED_QUERY) {
    const values = incoming.searchParams.getAll(key);
    for (const value of values) query.append(key, value);
  }
  if (API_KEY && !BEARER_TOKEN) {
    query.set('api_key', API_KEY);
  }

  const upstreamPath = `${UPSTREAM_PREFIX}${pathname}${query.size > 0 ? `?${query}` : ''}`;
  const headers = {
    Accept: 'application/json',
    'User-Agent': 'Scena-TMDB-Proxy/1.0',
  };
  if (BEARER_TOKEN) {
    headers.Authorization = `Bearer ${BEARER_TOKEN}`;
  }

  const upstream = https.request(
    {
      host: UPSTREAM_HOST,
      port: 443,
      method: 'GET',
      path: upstreamPath,
      headers,
    },
    (upstreamResponse) => {
      response.writeHead(upstreamResponse.statusCode ?? 502, {
        'Content-Type':
          upstreamResponse.headers['content-type'] ?? 'application/json; charset=utf-8',
        'Cache-Control': 'no-store',
        'X-Upstream-Status': String(upstreamResponse.statusCode ?? ''),
      });
      upstreamResponse.pipe(response);
    },
  );

  upstream.setTimeout(REQUEST_TIMEOUT_MS, () => {
    upstream.destroy(new Error('Timeout della richiesta a TMDB.'));
  });

  upstream.on('error', (error) => {
    if (response.headersSent) {
      response.destroy();
      return;
    }
    sendJson(response, 502, {
      error: 'TMDB non raggiungibile.',
      detail: error.message,
    });
  });

  upstream.end();
});

server.listen(PORT, HOST, () => {
  const credential = BEARER_TOKEN
    ? 'bearer token'
    : API_KEY
      ? 'api key'
      : 'NESSUNO';
  console.log(`Scena TMDB proxy in ascolto su http://${HOST}:${PORT}`);
  console.log(`Credenziale: ${credential} · CORS: ${ALLOWED_ORIGIN}`);
  console.log(
    'Flutter web: flutter run -d chrome --dart-define=TMDB_PROXY_BASE_URL=http://localhost:' +
      PORT,
  );
});

function applyCors(response) {
  response.setHeader('Access-Control-Allow-Origin', ALLOWED_ORIGIN);
  response.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  response.setHeader('Access-Control-Allow-Headers', 'Accept, Content-Type');
  response.setHeader('Access-Control-Max-Age', '600');
  response.setHeader('Vary', 'Origin');
}

function sendJson(response, status, payload) {
  if (response.headersSent) {
    response.destroy();
    return;
  }
  const body = JSON.stringify(payload);
  response.writeHead(status, {
    'Content-Type': 'application/json; charset=utf-8',
    'Content-Length': Buffer.byteLength(body),
    'Cache-Control': 'no-store',
  });
  response.end(body);
}

/**
 * Caricamento minimale di `.env` senza dipendenze npm.
 * Le variabili già presenti nell'ambiente hanno la precedenza.
 */
function loadDotEnv(file) {
  if (!fs.existsSync(file)) return;
  const content = fs.readFileSync(file, 'utf8');
  for (const rawLine of content.split(/\r?\n/)) {
    const line = rawLine.trim();
    if (!line || line.startsWith('#')) continue;
    const separator = line.indexOf('=');
    if (separator <= 0) continue;
    const key = line.slice(0, separator).trim();
    if (!/^[A-Za-z_][A-Za-z0-9_]*$/.test(key)) continue;
    if (Object.prototype.hasOwnProperty.call(process.env, key)) continue;
    let value = line.slice(separator + 1).trim();
    if (
      (value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))
    ) {
      value = value.slice(1, -1);
    }
    process.env[key] = value;
  }
}
