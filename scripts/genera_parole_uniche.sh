#!/usr/bin/env bash
#
# genera_parole_uniche.sh
# -----------------------
# Crea (o rigenera) il file "paroleitaliane/parole_uniche.txt" contenente
# TUTTE le parole presenti nei file .txt della cartella "paroleitaliane",
# eliminando i duplicati.
#
# Come funziona, passo per passo:
#   1. si posiziona nella cartella "paroleitaliane" del repository;
#   2. legge tutti i file .txt della cartella, ESCLUDENDO il file di output
#      stesso (parole_uniche.txt) per non reintrodurre dati vecchi;
#   3. unisce tutte le righe, rimuove i duplicati esatti e ordina il
#      risultato con la collation italiana (it_IT.UTF-8);
#   4. scrive il risultato in "paroleitaliane/parole_uniche.txt".
#
# Lo script è in bash puro: funziona su qualsiasi Linux/macOS senza dipendenze
# esterne oltre ai comandi POSIX standard (find, sort).
#
# Uso:
#   ./scripts/genera_parole_uniche.sh
#

# "set -euo pipefail" rende lo script sicuro:
#   -e  : esce subito se un comando fallisce
#   -u  : errore se si usa una variabile non definita
#   -o pipefail : una pipe fallisce se fallisce un qualsiasi comando della pipe
set -euo pipefail

# Tutti i file del repository sono ordinati con la collation italiana, cioè
# quella in cui le lettere accentate stanno accanto alla lettera base
# ("abbaccherà" vicino ad "abbaccherai", non in fondo dopo la "z").
# Per ottenerla serve la locale it_IT.UTF-8.
LOCALE_ORDINAMENTO="it_IT.UTF-8"

# "locale -a" scrive la locale in modi diversi a seconda del sistema
# (it_IT.UTF-8 su macOS, it_IT.utf8 su Linux): normalizziamo prima di cercarla.
if ! locale -a 2>/dev/null | tr 'A-Z' 'a-z' | tr -d '-' | grep -qx 'it_it.utf8'; then
  echo "Errore: la locale $LOCALE_ORDINAMENTO non è disponibile su questo sistema." >&2
  echo "Installala (su Debian/Ubuntu: 'sudo locale-gen it_IT.UTF-8') e riprova." >&2
  exit 1
fi

export LC_ALL="$LOCALE_ORDINAMENTO"

# Ricaviamo il percorso assoluto della cartella che contiene questo script,
# così lo script funziona indipendentemente dalla cartella da cui lo lanci.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# La radice del repository è la cartella "genitrice" di "scripts".
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Cartella con i file delle parole e nome del file di output.
CARTELLA_PAROLE="$REPO_ROOT/paroleitaliane"
FILE_OUTPUT="$CARTELLA_PAROLE/parole_uniche.txt"

# Verifica di sicurezza: la cartella deve esistere.
if [ ! -d "$CARTELLA_PAROLE" ]; then
  echo "Errore: cartella non trovata: $CARTELLA_PAROLE" >&2
  exit 1
fi

echo "Genero il file delle parole uniche da: $CARTELLA_PAROLE"

# Scriviamo prima su un file temporaneo e poi lo spostiamo al posto giusto:
# così, se qualcosa va storto, il file di output esistente non viene corrotto.
FILE_TEMP="$(mktemp)"

# 1) find    -> elenca tutti i .txt della cartella (solo primo livello),
#               escludendo il file di output stesso;
# 2) -exec cat-> concatena il contenuto di tutti questi file;
# 3) grep -v  -> scarta le eventuali righe vuote;
# 4) awk      -> rimuove i duplicati confrontando le righe byte per byte.
#               NON usiamo "sort -u": con la collation italiana due righe
#               diverse possono risultare "uguali" (es. "Ardigo" e "Ardigo’",
#               perché l'apostrofo tipografico viene ignorato) e una delle due
#               andrebbe persa;
# 5) sort     -> ordina il risultato con la collation italiana.
find "$CARTELLA_PAROLE" -maxdepth 1 -type f -name '*.txt' \
  ! -name "$(basename "$FILE_OUTPUT")" \
  -exec cat {} + \
  | grep -v '^[[:space:]]*$' \
  | awk '!visto[$0]++' \
  | sort > "$FILE_TEMP"

# Spostiamo il file temporaneo sul file di output definitivo.
mv "$FILE_TEMP" "$FILE_OUTPUT"

# Contiamo quante parole uniche sono state generate, come conferma finale.
NUM_PAROLE="$(wc -l < "$FILE_OUTPUT" | tr -d ' ')"
echo "Fatto: creato $FILE_OUTPUT con $NUM_PAROLE parole uniche."
