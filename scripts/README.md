# Script di manutenzione

Questa cartella contiene script in **bash puro** per la manutenzione del repository.
Funzionano su qualsiasi sistema **Linux** o **macOS** con i comandi standard
(`find`, `sort`, `zip`), senza installare nulla di aggiuntivo.

## Prerequisiti

- Una shell **bash**
- Il comando **`zip`** (necessario solo per `crea_zip.sh`)
- La locale **`it_IT.UTF-8`** (necessaria solo per `genera_parole_uniche.sh`)

Su macOS la locale italiana è già installata. Su Linux, se manca, la installi con:

```bash
sudo locale-gen it_IT.UTF-8
```

Prima del primo utilizzo, rendi gli script eseguibili:

```bash
chmod +x scripts/*.sh
```

## Script disponibili

### 1. `genera_parole_uniche.sh`

Crea (o rigenera) il file `paroleitaliane/parole_uniche.txt`, che contiene
**tutte le parole** presenti nei file `.txt` della cartella `paroleitaliane`,
**senza duplicati** e ordinate alfabeticamente con la **collation italiana**
(`it_IT.UTF-8`): le lettere accentate stanno accanto alla lettera base, non in
fondo dopo la `z`.

I duplicati vengono rimossi con un confronto byte per byte e non con `sort -u`,
perché con la collation italiana due righe diverse possono risultare "uguali"
(es. `Ardigo` e `Ardigo’`) e una delle due andrebbe persa.

Il file di output stesso (`parole_uniche.txt`) viene escluso dalla lettura,
così da non reintrodurre dati vecchi ad ogni esecuzione.

```bash
./scripts/genera_parole_uniche.sh
```

Al termine viene mostrato il numero totale di parole uniche generate.

### 2. `crea_zip.sh`

Ricrea gli archivi ZIP delle due cartelle di dati, **cancellando prima**
quelli già esistenti:

- `bruteforce.zip`
- `paroleitaliane.zip`

Gli archivi vengono creati nella radice del repository ed escludono i file
`.DS_Store` di macOS.

```bash
./scripts/crea_zip.sh
```

## Ordine consigliato

Se vuoi che `paroleitaliane.zip` includa anche il file `parole_uniche.txt`
aggiornato, esegui prima la generazione e poi la creazione degli ZIP:

```bash
./scripts/genera_parole_uniche.sh
./scripts/crea_zip.sh
```
