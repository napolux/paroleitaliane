# Liste di parole italiane

In questo repository trovi diverse liste di parole italiane — alcune di provenienza ignota,
recuperate da un vecchio hard disk, altre con la "fonte" indicata ove possibile — utili per:

- Dizionari
- Giochi di parole
- Generazione di testo casuale
- "Istruzione" di sistemi di intelligenza artificiale
- Varie ed eventuali

## I file

Tutti i file sono in **UTF-8 senza BOM**, con **una parola per riga** e terminatori di riga **LF**.
Salvo dove indicato, le parole sono in minuscolo. L'ordinamento varia da file a file:
alcuni sono ordinati alfabeticamente, altri conservano l'ordine originale della fonte.

| File | Righe | Dim. | Contenuto |
| --- | ---: | ---: | --- |
| [`400_parole_composte.txt`](paroleitaliane/400_parole_composte.txt) | 419 | 8 KB | Parole composte con trattino (`abat-jour`, `baby-sitter`) |
| [`lista_badwords.txt`](paroleitaliane/lista_badwords.txt) | 453 | 8 KB | Parolacce e termini volgari, NSFW :D |
| [`1000_parole_italiane_comuni.txt`](paroleitaliane/1000_parole_italiane_comuni.txt) | 1.159 | 12 KB | Le parole di uso più comune |
| [`9000_nomi_propri.txt`](paroleitaliane/9000_nomi_propri.txt) | 8.912 | 72 KB | Nomi propri di persona |
| [`lista_38000_cognomi.txt`](paroleitaliane/lista_38000_cognomi.txt) | 38.487 | 324 KB | Cognomi italiani (**con iniziale maiuscola**) |
| [`60000_parole_italiane.txt`](paroleitaliane/60000_parole_italiane.txt) | 60.454 | 556 KB | Parole italiane comuni |
| [`95000_parole_italiane_con_nomi_propri.txt`](paroleitaliane/95000_parole_italiane_con_nomi_propri.txt) | 95.192 | 1,0 MB | Parole italiane, più nomi propri e località |
| [`110000_parole_italiane_con_nomi_propri.txt`](paroleitaliane/110000_parole_italiane_con_nomi_propri.txt) | 116.877 | 1,2 MB | Parole italiane, nomi propri (persone e città) e termini stranieri di uso comune, anche informatico |
| [`lista_cognomi.txt`](paroleitaliane/lista_cognomi.txt) | 175.239 | 1,4 MB | Cognomi italiani e stranieri |
| [`280000_parole_italiane.txt`](paroleitaliane/280000_parole_italiane.txt) | 279.894 | 2,9 MB | Parole italiane, incluse le forme flesse |
| [`coniugazione_verbi.txt`](paroleitaliane/coniugazione_verbi.txt) | 334.953 | 3,8 MB | Coniugazioni di verbi italiani — estratto da [verb-data](https://github.com/ian-hamlin/verb-data), licenza [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/) |
| [`660000_parole_italiane.txt`](paroleitaliane/660000_parole_italiane.txt) | 661.569 | 7,3 MB | La lista più ampia di sole parole italiane — grazie a [scalaWords](https://github.com/pazqo/scalaWords) |
| [`parole_uniche.txt`](paroleitaliane/parole_uniche.txt) | 969.763 | 11 MB | **Generato**: tutte le parole di tutti i file qui sopra, senza duplicati |
| [`bruteforce.txt`](bruteforce/bruteforce.txt) | 1.072.988 | 7,3 MB | Wordlist per brute force (vedi sotto) |

### `bruteforce.txt`

Distribuito in una cartella e in un archivio ZIP separati. Contiene:

- tutte le possibili date di nascita in 6 caratteri (es. `100188` = 10 gennaio 1988);
- un dizionario italiano;
- tutte le combinazioni di 6 caratteri composte dalle cifre da 0 a 9;
- parolacce;
- parte dei termini inglesi usati in Italia;
- parte delle password più comuni, come `qwertyuio`.

### Archivi ZIP

Nella radice del repository trovi anche [`paroleitaliane.zip`](paroleitaliane.zip) e
[`bruteforce.zip`](bruteforce.zip), comodi se ti serve scaricare tutto in un colpo solo.

<details>
<summary><b>Estratti dai file</b></summary>

`400_parole_composte.txt`

```
baby-dolls
baby-sitter
baby-sitters
```

`lista_badwords.txt`

```
baldracca
baldraccacce
baldraccaccia
```

`1000_parole_italiane_comuni.txt`

```
spazio
speciale
specie
```

`9000_nomi_propri.txt`

```
fernando
fernella
fernero
```

`lista_38000_cognomi.txt`

```
Agnelli
Agnellini
Agnello
```

`60000_parole_italiane.txt`

```
stanerai
staneranno
stanerebbe
```

`95000_parole_italiane_con_nomi_propri.txt`

```
volsero
volse
volt
```

`110000_parole_italiane_con_nomi_propri.txt`

```
eva
faq
fsf
```

`lista_cognomi.txt`

```
vinacciuoli
vinadia
vinagli
```

`280000_parole_italiane.txt`

```
roderebbe
roderebbero
roderei
```

`coniugazione_verbi.txt`

```
vira
virai
virammo
virando
virano
virante
virare
virarono
```

`660000_parole_italiane.txt`

```
zurlavamo
zurlavano
zurlavate
```

`bruteforce.txt`

```
111105
111106
111107
```

</details>

## Script di manutenzione

Nella cartella [`scripts/`](scripts/) trovi due script in bash puro per rigenerare i file derivati:

```bash
./scripts/genera_parole_uniche.sh   # rigenera parole_uniche.txt
./scripts/crea_zip.sh               # ricrea i due archivi ZIP
```

Dettagli e prerequisiti nel [README degli script](scripts/README.md).

## Come posso contribuire?

Puoi contribuire aggiungendo:

- Correzioni / Variazioni
- Nuovi file

Se aggiungi o modifichi delle parole, ricordati di rigenerare i file derivati con gli script
qui sopra. Le linee guida complete sono in [CONTRIBUTING.md](CONTRIBUTING.md).

## Licenza

Il repository è distribuito con licenza [MIT](LICENSE). Fa eccezione
`coniugazione_verbi.txt`, derivato da [verb-data](https://github.com/ian-hamlin/verb-data)
e distribuito con licenza [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/).

### LEGAL STUFF

THE FILES (FROM NOW, "THE SOFTWARE") ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
