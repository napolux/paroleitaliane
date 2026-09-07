# Come contribuire a paroleitaliane

Grazie per il tuo interesse! Ecco come puoi aiutare.

## Segnalare problemi

Apri una [issue](https://github.com/napolux/paroleitaliane/issues) descrivendo:
- Il file interessato
- La parola o le parole da correggere/aggiungere
- La fonte, se disponibile

## Aggiungere o correggere parole

1. **Fai un fork** del repository
2. Crea un branch descrittivo: `git checkout -b fix/parole-mancanti`
3. Modifica i file nella cartella `paroleitaliane/`
4. Verifica che i file rispettino le [regole per i file](#regole-per-i-file):
   UTF-8 senza BOM, terminazioni di riga LF, ordinamento con collation italiana
5. **Prima di aprire la PR**, rigenera i file derivati con gli script della
   cartella [`scripts/`](scripts/README.md):

   ```bash
   ./scripts/genera_parole_uniche.sh   # rigenera paroleitaliane/parole_uniche.txt
   ./scripts/crea_zip.sh               # ricrea bruteforce.zip e paroleitaliane.zip
   ```

   In questo modo `parole_uniche.txt` e gli archivi ZIP restano allineati alle
   tue modifiche. Consulta [`scripts/README.md`](scripts/README.md) per i dettagli.
6. Apri una Pull Request con una descrizione chiara

### Regole per i file

- **Encoding**: UTF-8 senza BOM
- **Terminazioni di riga**: LF (`\n`), non CRLF, con newline finale
- **Una parola per riga**, senza righe vuote
- **Ordinamento**: alfabetico con **collation italiana** (`it_IT.UTF-8`), in modo che le
  lettere accentate stiano accanto alla lettera base e non in fondo dopo la `z`.
  Per riordinare un file:

  ```bash
  LC_ALL=it_IT.UTF-8 sort -o file.txt file.txt
  ```

- **Accenti**: le parole italiane devono includere gli accenti corretti (es. `perché`, non `perche`)
- **Duplicati**: evita duplicati all'interno dello stesso file. Per rimuoverli usa
  un confronto byte per byte, **non** `sort -u`: con la collation italiana due righe
  diverse possono risultare "uguali" (es. `Ardigo` e `Ardigo’`) e una delle due
  andrebbe persa.

  ```bash
  awk '!visto[$0]++' file.txt | LC_ALL=it_IT.UTF-8 sort -o file.txt
  ```

### Tipi di contributo benvenuti

- Correzione di parole senza accenti
- Aggiunta di parole mancanti
- Rimozione di duplicati
- Nuovi file tematici (es. termini tecnici, regionalismi)
- Miglioramenti alla documentazione

## Codice di condotta

Sii rispettoso e costruttivo. Ogni contributo è apprezzato.