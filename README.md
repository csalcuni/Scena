# Scena

**Il pianificatore della tua serata cinematografica.**

Scena non è un catalogo da sfogliare all'infinito: parte dai film e dalle serie
che hai già salvato, chiede com'è la serata e propone **al massimo tre titoli**,
spiegando perché ognuno è adatto a te. Funziona su Android, iOS e Web, con
persistenza locale e un'interfaccia in italiano che si adatta a smartphone,
tablet e desktop.

> This product uses the TMDB API but is not endorsed or certified by TMDB.

---

## Indice

- [Funzionalità](#funzionalità)
- [Stack](#stack)
- [Avvio rapido: modalità demo](#avvio-rapido-modalità-demo)
- [TMDB reale](#tmdb-reale)
- [Configurazione](#configurazione)
- [Comandi](#comandi)
- [Architettura](#architettura)
- [Come funzionano le proposte](#come-funzionano-le-proposte)
- [Persistenza e backup](#persistenza-e-backup)
- [Deep link e PWA](#deep-link-e-pwa)
- [Test](#test)
- [Sicurezza e limiti](#sicurezza-e-limiti)

---

## Funzionalità

- **Onboarding in 3 passaggi**: generi preferiti, generi da evitare, servizi e
  abitudini di visione. Si completa una sola volta.
- **Stasera**: richiesta della serata con tempo disponibile, compagnia, umore e
  vincoli (`niente horror`, `niente romance`, `solo famiglia`). La home mostra
  fino a tre proposte motivate, con stato, durata stimata e possibilità di
  scartarle o ripristinarle.
- **Riprendi**: mette in evidenza film iniziati e serie con il prossimo episodio
  da guardare.
- **Sorprendimi**: estrae un titolo eleggibile dalla libreria, evitando quelli
  appena scartati.
- **Libreria**: stati `Da vedere`, `In corso`, `In pausa`, `Visto`,
  `Abbandonato`; voto personale 1–10; note; tag; avanzamento episodi per le
  serie; ricerca e filtri locali.
- **Ricerca TMDB**: film e serie, paginazione, dettaglio con trama, cast, regia e
  metadati; aggiunta alla libreria con lo stato scelto.
- **Scheda titolo**: azioni di libreria, modifica, cambio stato, segna episodio o
  visto, rimozione. Se TMDB non è raggiungibile usa i metadati salvati e lo
  segnala.
- **Impostazioni**: tema sistema/chiaro/scuro, generi preferiti ed evitati,
  esclusioni assolute per parola chiave, genere e tipo, durata tipica, servizi
  dichiarati. Export/import JSON e cancellazione completa dei dati.
- **Responsive**: bottom navigation su schermi stretti, navigation rail su
  tablet, rail estesa su desktop. Scorciatoia `Ctrl/⌘ + K` per la ricerca.
- **PWA installabile**: manifest, icone, splash screen, `theme-color`, deep link
  e libreria utilizzabile offline. L'installazione richiede un build web servito
  in HTTPS (o `localhost`).

Non ci sono account, social, recensioni pubbliche, trailer né disponibilità
streaming inventate.

## Stack

| Ambito | Scelta |
| --- | --- |
| Framework | Flutter 3.50 / Dart 3.14 |
| UI | Material 3 tramite `material_ui`, tema chiaro/scuro, font locali |
| Stato | `flutter_riverpod` |
| Navigazione | `go_router` con `StatefulShellRoute` |
| Persistenza | Drift + SQLite; WebAssembly/IndexedDB sul Web |
| Rete | `dio` |
| Modelli | `freezed` + `json_serializable` |
| Qualità | `flutter_lints`, test unitari, data e widget |

## Avvio rapido: modalità demo

Serve solo Flutter: nessuna chiave TMDB e nessuna rete.

```bash
flutter pub get
flutter run -d chrome --dart-define=USE_MOCK_TMDB=true
```

Il catalogo mock permette di provare ricerca, dettaglio, aggiunta alla libreria,
proposte, episodi, backup e persistenza. Per Android, iOS o desktop usare lo
stesso `--dart-define` con il device desiderato.

I file generati da Drift, freezed e json_serializable sono già presenti. Dopo
modifiche a tabelle, entità o modelli:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## TMDB reale

### Web: proxy obbligatorio

La chiave **non viene mai inclusa nel bundle Web**. L'import condizionale in
`lib/core/config/` impedisce di leggere la chiave quando `kIsWeb` è vero; il Web
può parlare solo con un proxy che inietta la credenziale lato server.

1. Copia la configurazione di esempio e inserisci una credenziale TMDB:

   ```bash
   cp .env.example .env
   # modifica .env: TMDB_BEARER_TOKEN (consigliato) oppure TMDB_API_KEY
   ```

   `.env` è ignorato da git. Non committare mai credenziali.

2. Avvia il proxy (Node 18+, nessuna dipendenza npm):

   ```bash
   node tool/tmdb_proxy.js
   ```

   Il proxy ascolta su `http://127.0.0.1:8787`, espone solo le rotte usate
   dall'app, abilita CORS e applica un timeout. Se una credenziale manca
   risponde con un errore esplicito.

3. Avvia Flutter Web puntando al proxy:

   ```bash
   flutter run -d chrome \
     --dart-define=TMDB_PROXY_BASE_URL=http://localhost:8787
   ```

In produzione servire il proxy in HTTPS, impostare `ALLOWED_ORIGIN` sull'origine
esatta di Scena e aggiungere autenticazione/rate limiting prima di esporlo
pubblicamente. Il proxy fornito è volutamente minimale.

### Se la ricerca Web dà errore

Il file `.env` **non viene letto direttamente da Flutter**. È letto solo dal
proxy all'avvio. Quindi, sul Web:

- il proxy deve essere in esecuzione (`node tool/tmdb_proxy.js`);
- l'app deve essere compilata o avviata con
  `--dart-define=TMDB_PROXY_BASE_URL=...`;
- se il proxy è in ascolto su un'altra macchina, l'URL non può essere
  `localhost`: usare un indirizzo raggiungibile dal browser e HTTPS;
- dopo aver modificato `.env` bisogna riavviare il proxy;
- passare `TMDB_API_KEY` a Flutter Web non serve: per progetto la chiave viene
  ignorata sul Web e la richiesta deve passare dal proxy.

Per verificare il proxy senza aprire l'app:

```bash
curl "http://localhost:8787/search/movie?query=Dune&language=it-IT&page=1"
```

Una risposta JSON con `results` conferma che credenziale, rete e proxy
funzionano. Un `500` indica che il proxy non ha caricato la credenziale; un
`401`/`403` indica una credenziale rifiutata da TMDB.

### Mobile/desktop: chiave diretta o proxy

Per lo sviluppo su mobile si può usare direttamente una API key v3:

```bash
flutter run --dart-define=TMDB_API_KEY=la_tua_api_key_v3
```

In questo caso la chiave è compilata nel binario: va bene solo per sviluppo
locale. Per una build distribuita usare un proxy remoto:

```bash
flutter run \
  --dart-define=TMDB_PROXY_BASE_URL=https://tmdb-proxy.example.com
```

Il client mobile accetta entrambe le modalità; il proxy ha precedenza sulla
chiave diretta.

## Configurazione

Tutti i parametri si passano con `--dart-define`.

| Variabile | Default | Descrizione |
| --- | --- | --- |
| `USE_MOCK_TMDB` | `false` | Usa il catalogo mock locale, senza rete. |
| `TMDB_PROXY_BASE_URL` | vuoto | Base URL del proxy. Obbligatorio sul Web per dati reali. |
| `TMDB_API_KEY` | vuoto | API key v3 per chiamate dirette da mobile/desktop. Ignorata sul Web. |
| `TMDB_API_BASE_URL` | `https://api.themoviedb.org/3` | Upstream per la modalità diretta. |
| `TMDB_LANGUAGE` | `it-IT` | Lingua delle risposte TMDB. |
| `EPISODE_FALLBACK_MINUTES` | `45` | Durata stimata di un episodio quando TMDB non la fornisce. |

Precedenza: mock → proxy → chiave diretta. Senza nessuna configurazione la
ricerca mostra un errore di configurazione, mentre la libreria continua a
funzionare con i dati già salvati.

## Comandi

```bash
# Dipendenze
flutter pub get

# Codice generato
dart run build_runner build --delete-conflicting-outputs

# Analisi statica e test
dart analyze
flutter test

# Build Web demo (nessuna chiave)
flutter build web --dart-define=USE_MOCK_TMDB=true

# Build Web con proxy
flutter build web \
  --dart-define=TMDB_PROXY_BASE_URL=https://tmdb-proxy.example.com

# Build Android debug (richiede JDK 17)
flutter build apk --debug

# Esecuzione
flutter run -d chrome --dart-define=USE_MOCK_TMDB=true
flutter run -d android --dart-define=USE_MOCK_TMDB=true
```

Il risultato Web è in `build/web/`. Poiché il routing usa URL reali
(`usePathUrlStrategy`), il server deve reindirizzare le rotte sconosciute a
`index.html`. Esempio nginx:

```nginx
location / {
  try_files $uri $uri/ /index.html;
}
```

Per una build Android con più JDK installati:

```bash
JAVA_HOME=/percorso/a/jdk-17 flutter build apk --debug
```

## Architettura

Organizzazione feature-first, con dominio indipendente da Flutter, HTTP e Drift.

```text
lib/
├── app/                 # MaterialApp, router, grafo Riverpod
├── core/                # configurazione, tema, errori, utility, breakpoint
├── domain/
│   ├── entities/        # modelli puri: media, libreria, serata, preferenze
│   ├── repositories/    # interfacce dei repository
│   └── usecases/        # raccomandazioni, sorpresa, operazioni di libreria
├── data/
│   ├── local/drift/     # database, tabelle, connessioni native/Web, repository
│   └── tmdb/            # client dio, modelli, mapper, cache, mock
├── features/            # onboarding, home, libreria, ricerca, dettaglio, settings
└── widgets/             # componenti condivisi
test/
├── domain/              # motore, sorpresa, use case
├── data/                # repository Drift e persistenza su file
├── widget/              # flussi UI, responsive, deep link
└── support/             # fake repository, DB in memoria, harness
tool/tmdb_proxy.js       # proxy TMDB senza dipendenze npm
web/                     # PWA: manifest, icone, splash, bootstrap
```

Flusso delle dipendenze:

```text
Widget → provider Riverpod → use case → repository → Drift / TMDB
```

- Il **dominio** non importa Flutter: il motore delle proposte è una funzione
  pura e deterministica, testabile senza database o rete.
- I **repository Drift** implementano le interfacce di dominio; il database Web
  usa `WasmDatabase.open`, `web/sqlite3.wasm` e `web/drift_worker.js`, con i dati
  in IndexedDB. Su mobile/desktop il database è un file locale.
- La **cache TMDB** (`cached_entries`, schema v2) riusa le risposte e permette
  al dettaglio di mostrare i metadati salvati quando la rete non è disponibile.
- Le **immagini** usano `cached_network_image`; senza rete la libreria resta
  consultabile anche se le copertine non ancora in cache possono mancare.

La cartella non è attualmente un repository git: non vengono creati commit.

## Come funzionano le proposte

Il motore considera **solo la libreria locale**. Non inventa titoli, non
interroga TMDB per suggerimenti e non dichiara dove un contenuto sia
disponibile.

1. Esclude i titoli `Visto` e `Abbandonato`, quelli bloccati dalle esclusioni
   assolute e quelli che non rispettano i vincoli della serata.
2. Assegna un punteggio in base a:
   - compatibilità con il tempo disponibile (o durata episodica per le serie);
   - affinità con umore, compagnia e contesto;
   - generi preferiti ed evitati;
   - voto medio TMDB come segnale di qualità, non come recensione personale;
   - stato in libreria, inattività e novità del salvataggio;
   - scarti recenti, che abbassano il punteggio.
3. Ordina in modo deterministico (punteggio, titolo, ID) e mostra al massimo
   **tre** proposte.
4. Se i titoli nel tempo disponibile sono meno di tre, può includerne di più
   lunghi **solo in questo caso**, segnalandoli come «troppo lungo per stasera»
   e spiegando l'allentamento. Le durate sconosciute non vengono escluse a
   priori e sono indicate come tali.
5. Ogni proposta espone una motivazione leggibile costruita dagli stessi fattori
   usati per il punteggio.

`Sorprendimi` è separato: usa un seed casuale, esclude i titoli non eleggibili e
le chiavi già scartate, e restituisce un risultato riproducibile nei test.

## Persistenza e backup

Il database Drift contiene:

- `media_items` — metadati TMDB o mock;
- `library_entries` — stato, voto, note, tag, episodio corrente, date;
- `viewing_events` — cronologia delle azioni di visione;
- `user_preferences` — onboarding, tema, generi, esclusioni;
- `dismissed_suggestions` — scarti usati nelle proposte;
- `cached_entries` — cache delle risposte TMDB (schema v2).

La migrazione da v1 a v2 crea la cache senza perdere i dati utente. Su Web la
persistenza è in IndexedDB e sopravvive al refresh della pagina; su
mobile/desktop è un file SQLite nella directory dei documenti dell'app.

L'export produce un JSON versionato (`format: "scena-backup"`, `version: 1`) con
libreria, metadati, eventi, preferenze e scarti. Sul Web il download avviene dal
browser; su native il file viene salvato nella directory dei documenti. L'import
legge il JSON incollato nell'app, valida formato e versione, e sostituisce i dati
utente in una transazione. La cancellazione completa rimuove tutti i dati locali
e richiede conferma esplicita.

## Deep link e PWA

Rotte principali:

| Percorso | Schermata |
| --- | --- |
| `/` | Stasera |
| `/library` | Libreria |
| `/search?q=...&type=movie\|tv` | Ricerca precompilata |
| `/media/movie/:tmdbId` | Dettaglio film |
| `/media/tv/:tmdbId` | Dettaglio serie |
| `/settings` | Impostazioni |
| `/onboarding` | Onboarding |

Il redirect del router forza l'onboarding finché non è completato e riporta alla
home chi apre `/onboarding` dopo averlo già completato. I deep link funzionano su
Web con URL reali e su mobile quando l'app è registrata per i link appropriati.

La PWA include `web/manifest.json`, icone normali e maskable, favicon,
apple-touch-icon, splash HTML con fallback e chiusura su `flutter-first-frame`, e
meta per tema chiaro/scuro. Flutter genera il service worker nel build web; per
l'installazione servire il sito in HTTPS. I dati della libreria restano
disponibili offline; la ricerca TMDB richiede rete.

## Test

La suite copre dominio, dati e interfaccia:

```bash
flutter test
```

Sono presenti 65 test:

- **Dominio**: vincoli della serata, generi, durate, scarti, determinismo,
  episodi, esclusioni assolute, use case di libreria, sorpresa.
- **Dati**: CRUD della libreria, preferenze, eventi, scarti, backup, cache e
  riapertura del database su file.
- **Widget**: onboarding, shell compatta/espansa, home e azioni sulle proposte,
  filtri e ricerca in libreria, editor, ricerca TMDB, impostazioni e deep link.

I test non richiedono rete né chiavi TMDB: usano un catalogo finto e un database
in memoria. Per lo sviluppo manuale offline usare `USE_MOCK_TMDB=true`.

## Sicurezza e limiti

- Nessuna API key è hardcoded nel repository o inclusa nel bundle Web. La chiave
  diretta mobile è comunque estraibile dal binario: è una modalità di sviluppo.
- Il proxy è un esempio minimale, senza autenticazione, quota o rate limiting.
  Non esporlo pubblicamente senza aver aggiunto questi controlli e HTTPS.
- Non viene verificata la disponibilità reale dei contenuti sui servizi
  streaming; i servizi selezionati restano preferenze dichiarate dall'utente.
- Non ci sono account, sincronizzazione tra dispositivi, social, recensioni
  pubbliche, trailer o riassunti generati.
- Le proposte sono euristiche spiegabili, non un modello di machine learning.
- Le copertine remote possono non essere disponibili offline se non sono già in
  cache; i dati e i metadati della libreria restano accessibili.
- Il progetto non è un repository git e non contiene commit.
