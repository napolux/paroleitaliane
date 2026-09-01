#!/usr/bin/env bash
#
# crea_zip.sh
# -----------
# Ricrea gli archivi ZIP delle cartelle "bruteforce" e "paroleitaliane".
#
# Come funziona, passo per passo:
#   1. per ciascuna delle due cartelle, CANCELLA lo ZIP esistente (se c'è);
#   2. crea da zero un nuovo ZIP aggiornato con il contenuto della cartella;
#   3. esclude i file "spazzatura" di macOS (.DS_Store) dagli archivi.
#
# Gli ZIP vengono creati nella radice del repository:
#   - bruteforce.zip
#   - paroleitaliane.zip
#
# Suggerimento: se vuoi che "paroleitaliane.zip" contenga anche il file
# "parole_uniche.txt" aggiornato, lancia PRIMA lo script
# "genera_parole_uniche.sh" e POI questo.
#
# Lo script è in bash puro: richiede solo il comando standard "zip".
#
# Uso:
#   ./scripts/crea_zip.sh
#

# Modalità sicura: esci al primo errore, segnala variabili non definite,
# fai fallire le pipe se fallisce un comando interno.
set -euo pipefail

# Percorso assoluto della cartella dello script e radice del repository.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Verifica che il comando "zip" sia disponibile sul sistema.
if ! command -v zip >/dev/null 2>&1; then
  echo "Errore: comando 'zip' non trovato. Installalo e riprova." >&2
  exit 1
fi

# Funzione che (ri)crea lo ZIP di una singola cartella.
# Parametro $1 = nome della cartella da comprimere (es. "bruteforce").
crea_zip_cartella() {
  local nome_cartella="$1"
  local percorso_cartella="$REPO_ROOT/$nome_cartella"
  local file_zip="$REPO_ROOT/$nome_cartella.zip"

  # La cartella da comprimere deve esistere.
  if [ ! -d "$percorso_cartella" ]; then
    echo "Errore: cartella non trovata: $percorso_cartella" >&2
    exit 1
  fi

  # 1) Cancelliamo lo ZIP esistente, se presente.
  if [ -f "$file_zip" ]; then
    echo "Cancello lo ZIP esistente: $file_zip"
    rm -f "$file_zip"
  fi

  # 2) Creiamo il nuovo ZIP.
  #    Ci spostiamo nella radice del repository così che dentro l'archivio
  #    i percorsi partano dalla cartella (es. "bruteforce/...") e non
  #    contengano percorsi assoluti della tua macchina.
  #    Opzioni usate:
  #      -r  : comprime ricorsivamente tutta la cartella
  #      -q  : modalità silenziosa (meno output a schermo)
  #      -x  : esclude i file indicati (qui i .DS_Store di macOS)
  echo "Creo l'archivio: $file_zip"
  ( cd "$REPO_ROOT" && zip -r -q "$nome_cartella.zip" "$nome_cartella" -x '*.DS_Store' )

  echo "Fatto: $file_zip"
}

# Ricreiamo gli ZIP delle due cartelle richieste.
crea_zip_cartella "bruteforce"
crea_zip_cartella "paroleitaliane"

echo "Tutti gli archivi ZIP sono stati ricreati con successo."
