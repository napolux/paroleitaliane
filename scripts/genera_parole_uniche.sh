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
#   3. unisce tutte le righe, ordina alfabeticamente e rimuove i duplicati
#      con "sort -u";
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

# Forziamo un ordinamento deterministico e coerente su tutte le macchine.
# LC_ALL=C ordina byte-per-byte: stesso risultato ovunque venga eseguito.
export LC_ALL=C

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

# 1) find  -> elenca tutti i .txt della cartella (solo primo livello),
#             escludendo il file di output stesso;
# 2) -exec cat -> concatena il contenuto di tutti questi file;
# 3) sort -u   -> ordina alfabeticamente e rimuove le righe duplicate.
find "$CARTELLA_PAROLE" -maxdepth 1 -type f -name '*.txt' \
  ! -name "$(basename "$FILE_OUTPUT")" \
  -exec cat {} + \
  | sort -u > "$FILE_TEMP"

# Spostiamo il file temporaneo sul file di output definitivo.
mv "$FILE_TEMP" "$FILE_OUTPUT"

# Contiamo quante parole uniche sono state generate, come conferma finale.
NUM_PAROLE="$(wc -l < "$FILE_OUTPUT" | tr -d ' ')"
echo "Fatto: creato $FILE_OUTPUT con $NUM_PAROLE parole uniche."
