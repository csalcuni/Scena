#!/usr/bin/env bash
# Avvia Scena Web su una porta fissa (default 8080).
#
# Sul Web Drift salva il database in IndexedDB, che il browser partiziona per
# origin (schema://host:porta). `flutter run -d chrome` sceglie una porta
# casuale a ogni avvio: senza porta fissa ogni esecuzione usa un database
# diverso e la libreria sembra sparita. Questo script mantiene l'origin
# stabile, quindi i dati salvati restano disponibili tra un avvio e l'altro.
#
# Uso:
#   tool/run_web.sh                                        # demo (mock)
#   tool/run_web.sh --dart-define=TMDB_PROXY_BASE_URL=http://localhost:8787
#   SCENA_WEB_PORT=9000 tool/run_web.sh                    # porta alternativa
#
# Gli argomenti aggiuntivi vengono passati a `flutter run`.
set -euo pipefail

cd "$(dirname "$0")/.."

PORT="${SCENA_WEB_PORT:-8080}"
HOST="${SCENA_WEB_HOST:-localhost}"

exec flutter run -d chrome \
  --web-hostname "$HOST" \
  --web-port "$PORT" \
  "$@"
