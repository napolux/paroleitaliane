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
4. Verifica che i file siano in **UTF-8 senza BOM** e con terminazioni di riga **LF** (`\n`)
5. Apri una Pull Request con una descrizione chiara

### Regole per i file

- **Encoding**: UTF-8 senza BOM
- **Terminazioni di riga**: LF (`\n`), non CRLF
- **Ordinamento**: mantieni l'ordine alfabetico dove possibile
- **Accenti**: le parole italiane devono includere gli accenti corretti (es. `perché`, non `perche`)
- **Duplicati**: evita duplicati all'interno dello stesso file
- **Una parola per riga**

### Tipi di contributo benvenuti

- Correzione di parole senza accenti
- Aggiunta di parole mancanti
- Rimozione di duplicati
- Nuovi file tematici (es. termini tecnici, regionalismi)
- Miglioramenti alla documentazione

## Codice di condotta

Sii rispettoso e costruttivo. Ogni contributo è apprezzato.