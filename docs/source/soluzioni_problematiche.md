Soluzioni problematiche
========================
## Licenze

### Licenze valide per tutti

Nei casi in cui abbiamo delle licenze valide per tutti, è sufficiente aggiornare il file di licenza presente sul cluster usando l'utenza `propro01` (ad esempio con NAG).

- Si va sul cluster.
- Si esegue `module av <nome_software>` per vedere tutte le le versioni disponibili.
- Si va al percorso che contiene la licenza (di solito c'è "license" nel percorso).
- Si rinomina il file vecchio seguendo la nomenclatura usata per i precedenti, ad esempio: `cp license.lic license20240531`.
- Si copia nel file di licenza la nuova licenza.
- Si ripete per ogni versione mostrata da `module av`.

### Licenze tramite license manager

Altre licenze sono gestite tramite license manager e in questi casi vanno messi in whitelist gli IP dei server su cui sono presenti le licenze degli utenti.  
Se la licenza è installata su un license server di un'università, queste sono le informazioni di cui necessitiamo per effettuare il collegamento:

- indirizzo IP (pubblico) e porta su cui è in ascolto il license manager
- apertura del firewall del license server da parte dell'IT dell’università verso gli IP del nostro cluster Cineca (una volta chiarito quale cluster, inviare la lista di IP)
- firma di un documento di esonero da parte dell'intestatario della licenza

Per verificare la connessione con i server di licenza lanciare comandi di questo tipo:

- `telnet IP porta`
- `telnet pcdmavallonelic.polito.it 5053`
- `rlmutil rlmstat -c 29000@pcdmavallonelic.polito.it -a`
- `nmap pcdmavallonelic.polito.it -p 5053`

Caricare prima il modulo **superc** e, se necessario, lanciare i comandi da VM hpcsupport.

La nuova connessione va anche registrata sulla [tabella delle licenze](https://wiki.u-gov.it/confluence/pages/viewpage.action?spaceKey=SCAIIN&title=Licenze%3A+gestione+operativa#Licenze:gestioneoperativa-2.2Licenze).

Il ticket [#48000](https://tts.hpc.cineca.it/Ticket/Display.html?id=48000) ha un esempio per Ansys, insieme alla [issue](https://jira.u-gov.it/jira/servicedesk/customer/portal/42/SDHPCSY-42107) in cui chiedo di mettere l'indirizzo in whitelist.

## Propro01

`propro01` è l’utenza con cui si fanno modifiche che valgono per tutto il cluster.  
Per accedere come `propro01`, una volta fatto l’accesso sul cluster, lanciare:

- `sudo -i -u propro01`

Per Leonardo vale solo sulle VM.

Qualora non funzioni, provare con:

- `su - propro01`

## Modificare una qos

Accedere a una delle VM:

- `sup01`

Impersonare `cinprod`:

- `sudo -i -u cinprod`

Lanciare il comando per la modifica desiderata:

- `sacctmgr modify qos qos_slowprio set MaxTRES=node=256 MaxTRESPU=node=256 MaxWall=12:00:00`

Oppure:

- `sacctmgr update qos qos_deste set GrpTRES=node=256,cpu=28672,mem=126464000 MaxTRESPA=node=256,cpu=28672,mem=126464000`

**Attenzione**: accertarsi che il numero di CPU e la memoria concordino con il numero di nodi indicato.

Con il comando:

```bash
scontrol show node <nodo_di_quella_partizione>
```

si possono vedere `RealMemory` e `MemSpecLimit`.  
La loro differenza è la memoria disponibile per ogni nodo, ad esempio:

- `RealMemory=514000`
- `MemSpecLimit=20000`
- `514000-20000 = 494000`

E quindi:

- `node=256`
- `cpu=28672`
- `mem=126464000`

Poi, associare la qos alla propria utenza con `cin_staff`:

- `sacctmgr modify user amarcell where cluster=leonardo account=cin_staff set qos+=qos_deste`

e provare a lanciare un job:

- `srun -N 256 --ntasks-per-node=112 --qos=qos_deste -p dcgp_usr_prod --pty bash`

Se è tutto ok, associare la qos all'account che la dovrà utilizzare:

- `sacctmgr modify account DestE_330_26_0 set qos+=qos_deste`

e impostare i limiti di associazione così da limitare il numero di nodi utilizzabili con lo stesso account:

- `sacctmgr modify account where account=DestE_330_26_0 cluster=leonardo set MaxWall=24:00:00 MaxTRES=node=256 GrpTRES=node=256`

## Comando Datamover tra due cluster

Qualora la copia tra due cluster non funzioni nella maniera più semplice, provare con questo comando:

```bash
ssh -xt nchuluch@data.marconi.cineca.it rsync -PravzHS \
  nchuluch@data.leonardo.cineca.it:/leonardo_scratch/large/userexternal/nchuluch/nchuluch/TAE/MAST_Feb/n3_orig_bump_tempscan/40/orb5_res.h5 \
  /marconi/home/userexternal/nchuluch
```

## Contatti

Chi contattare in caso di richieste:

- ISCRA --> Paola Alberigo (Paola gestisce il periodo di validità e i budget, a noi spettano le modifiche di quota WORK tramite UserDB.)
- Eurofusion --> Richard Kamendje (per aumenti di quota sotto i 20–30 TB non serve chiedergli nulla) [vedere qui](https://wiki.u-gov.it/confluence/pages/viewpage.action?spaceKey=SCAIIN&title=Quote+Work+richieste+nei+proposal+EUROFUSION)
- Progetti chiusi da recuperare in extremis --> Marco Alberoni (sistemisti in generale)
- Ticket in cui chiedono di pagare per risorse sui cluster --> Eric Pascolo e il suo capo Arlandini
- Progetti vari (ad esempio accademici, anche se chiedono di pagare) --> Maurizio Cremonesi
- EUROHPC --> Tiziana
- Corsi vari: Alle e Orlenys. Di solito dovrebbero scrivere a `corsi.hpc@cineca.it`, ma se ci becchiamo qualcosa, scrivere a uno dei due.
- ICSC: Davide Salomoni `davide@supercomputing-icsc.it`
- CESMA: Ing. Vincenzo Moscato `vmoscato@unina.it`
- Scuola Superiore Meridionale: Ing. Raffaele Cacciano `r.cacciano@ssmeridionale.it`

## Controllare responsabile di un software

- `modmap -m <nome_software>`
- caricare profilo e modulo
- `module show <nome_software>`
- eseguire `ls` sul percorso del modulefile (in alto) e aprirlo per leggerne il responsabile, oltre alle altre informazioni riportate

## Spack

I programmi installati sulle macchine sono divisi in profili, librerie, ecc.

I moduli possono essere esclusivi o additivi.

I profili `global` e `base` sono esclusivi, cioè può essere caricato solo uno di loro alla volta.

Gli altri profili sono additivi, cioè caricandoli si aggiungono a quelli già presenti.

- `module av -a <nome_modulo>` --> mostra tutti i moduli con quel nome, anche quelli nascosti
- Per caricare un modulo nascosto è necessario indicarne il nome per intero (ad esempio `cuda/11.1.0--gcc--10.2.0`).
- `module show <nome_modulo>` --> mostra il percorso del file del modulo (modulefile) in cui sono presenti tutti i suoi settaggi

Al percorso:

- `/cineca/prod/opt/helps/`

sono presenti varie cartelle per i vari software, con all'interno un modulefile nascosto (`.help`) in cui sono gli script utili per tutte le installazioni del software.

Al percorso:

- `/cineca/prod/opt/modulefiles/`

ci sono i modulefile personalizzati dei vari programmi, creati appositamente e con il nome di quella installazione (il numero della versione).

Quando si crea un modulo, questo va in `global` o `base` e può poi essere copiato in un profilo a scelta.

Copiare un modulo corrisponde a copiare una cartella; lo si può fare con `ba_mpm` o con `spack`.

Le ricette di spack sono gestite in una package repository (cartella creata da spack quando deve cercare un package per nome) al percorso:

- `/cineca/prod/opt/tools/spack/0.14.2-prod/none/var/spack/repos/builtin/packages/`

Dove si trovano anche le cartelle con tutti i package e il file `repo.yaml` che contiene i metadati per la configurazione dei pacchetti.

Aprendo le cartelle di uno dei package troviamo un file `package.py` e altri file necessari.  
Questo `package.py` è la ricetta di quel pacchetto.

Il file `repos.yaml` contiene l'ordine dei percorsi in cui spack andrà a cercare il package da installare e la relativa ricetta.  
Il valore di default è:

- `/var/spack/repos/builtin/packages/`

Versioni diverse di spack consentono di installare software diversi.

Per controllare quale versione di un software può essere installata con una certa versione di spack, si va a controllare sul [GitHub di Spack](https://github.com/spack/spack/tree/develop/var/spack/repos/builtin/packages) aggiungendo il nome del software al percorso del link.  
Per aggiungere una versione alla ricetta, si va sulla pagina GitHub relativa al software, dentro il file `package.py`, si prende la riga della versione che ci interessa e la si incolla nella ricetta sul cluster, tramite comando `spack edit`.

- `spack list` --> mostra tutti i software che possono essere installati con spack
- `spack list <nome_software>` --> mostra tutte le versioni di un software
- `spack info <nome_software>` --> mostra la ricetta di un software installato
- `spack edit <nome_software>` --> apre la ricetta in modalità modifica (con vim)
- `spack spec -Il <nome_software>` --> mostra un'anteprima di come verrà installato un programma, con le impostazioni di variabili e dipendenze
- `spack find <nome_software>` --> mostra tutti i software già installati con spack
- `spack find --loaded` --> mostra i pacchetti attualmente caricati
- `spack diff /hash1 /hash2` --> mostra le differenze tra due specifiche diverse (identificate da due hash diversi)

Simboli di spack:

- `+` --> imposta una variabile su on
- `-` --> imposta una variabile su off (indicata con `~`)
- `=` --> definisce il valore di una variabile
- `%` --> definisce il compilatore
- `^` --> definisce la dipendenza
- `@` --> definisce la versione

Comandi `spack find`:

- `spack find -l` --> mostra la lista
- `spack find -p <nome_software>` --> mostra il percorso di installazione
- `spack find -v <nome_software>` --> mostra le variabili
- `spack find -d <nome_software>` --> mostra le dipendenze

Per creare un modulo con spack:

- `spack module tcl refresh <nome>`

## File Slurm

## Rinnovo password `tts-hpc-usersupport@cineca.it`

Quando arriva un ticket relativo al rinnovo della password per TTS, fare riferimento a Susana.

## slurm.conf

Se c’è bisogno di controllare questo file per verificare le impostazioni di slurm sul cluster, lo si può trovare al percorso:

- `/var/spool/slurmd/conf-cache/slurm.conf`

## VASP

Quando un utente richiede di utilizzare VASP su un cluster, bisogna:

- chiedergli se ha una licenza VASP ed eventualmente di fornirne il numero
- chiedere a Lorenzo Varrassi ~~Mariella Ippolito~~ di controllare che sia correttamente associato alla licenza, indicando l’email dell’utente e il numero della licenza
- se è tutto ok, seguire le istruzioni su questa [pagina](https://wiki.u-gov.it/confluence/pages/viewpage.action?spaceKey=SCAIIN&title=Apps+with+restrict+use%3A+how+to+add+users)

## Installazione da sorgente

Quando si deve installare da file sorgente, conviene cercare le istruzioni in un qualche file `README` presente nella cartella.

In generale si tratta di file `.tar.gz` o `.tar.bz2` che vanno estratti con comandi del tipo:

- `tar zxvf myapp.tar.gz`
- `tar jxvf myapp.tar.bz2`

Poi `cd` nella cartella creata e lanciare `./configure` e/o `make` a seconda dei casi.

## Stale file handle

Quando gli utenti ci comunicano questo tipo di errore, è bene:

- controllare i nodi del job: `sacct -j <jobid> -o nodelist%50`
- seguire le istruzioni riportate qui: [link](https://wiki.u-gov.it/confluence/display/SCAIUS/FAQ#FAQ-CanIloginwithsshinsideacomputenode?) (il nome del nodo deve iniziare con `lrdn`)
- controllare i log, ad esempio:
  - `sudo cat /var/log/slurm/slurm.lrdn0076.log` (per vedere il file log)
  - `sudo cat /var/log/slurm/slurm.lrdn0076.log > job.log` (per salvare il file log)
- vedere se c’è qualche errore esplicito agli orari indicati
- aprire un ticket ai sistemisti del tipo:

> Ciao,  
> oggi è arrivata una segnalazione di stale file handle sulla scratch di Marconi.  
> L'utente e il jobid sono:  
> cnuehren 13233799  
> Saluti,  
> Attilio

Se magari trovo qualcosa nei log, indicarlo nella issue.  
Rispondere poi all’utente con quello che dicono i sistemisti.

Questo problema solitamente accade a causa di noti problemi puntuali della rete, che causano il temporaneo unmount del filesystem per i nodi coinvolti, risultando nell'errore osservato.  
Questo tipo di problemi è causato sostanzialmente dall'età del cluster (specialmente per Marconi) e, vista la prossima dismissione dello stesso e la sporadicità con cui si presentano queste problematiche, non possiamo fare altro che tentare di limitarle con interventi conservativi ove necessario.

> [It seems there has been a file system error with subsequent nodes unmount, which results in the error shown. Everything should be working correctly now.  
> This type of problems is caused essentially by the cluster's age (especially for Marconi) and, given its upcoming decommissioning and the sporadic nature of these problems, we can only try to limit them by conservative interventions where necessary.]

## Help dei moduli

Sui cluster al percorso:

- `/cineca/prod/opt/helps`

si dovrebbe trovare la cartella di ogni modulo e il file `.help` dove scrivere il testo proposto dall'help.

## Rinomina cartelle

Quando un utente chiede di rinominare una cartella così da trasferire tutti i dati del vecchio progetto in quello nuovo, assicurarsi che:

- la cartella esista
- la cartella sia vuota (non affidarsi a `cindata`)
- il PI dei due progetti sia lo stesso
- sia noto il volume della vecchia cartella e quanto di questo sia occupato

Avvisare l'utente che al momento della rinomina la cartella deve essere vuota e non ci devono essere utenti che ci stanno lavorando, altrimenti i dati saranno eliminati.

Inviare poi una richiesta di questo tipo ai sistemisti:

> Ciao,  
> vi chiedo di rinominare la cartella WORK `/marconi_work/FUA36_REDIS` in `/marconi_work/FUA37_REDIS`.  
> La nuova cartella esiste già e abbiamo verificato che al momento è vuota.  
> Ha inoltre lo stesso PI di quella vecchia.  
> La vecchia cartella ha un volume di 20 TB con 18 TB occupati.  
> Grazie,  
> Attilio

## Conversione tra diverse espressioni delle ore

- `standard hours = core hours / FACTOR`
- `core hours = local hours` (da verificare)
- `node hours = core hours * num core per nodo`
- `core hours = node hours / num core per nodo`
- `node hour = GPU hour * num di GPU per nodo`
- `GPU hour = node hour / num di GPU per nodo`
- `core hours = GPU hour * num di GPU per nodo / num core per nodo`
- `GPU hour = core hours * num core per nodo / num di GPU per nodo`

**ATTENZIONE**: ci sono errori sul calcolo delle GPU/h, questa è l'unica equivalenza di cui sono sicuro:

- `STD = GPUH * 8`

Vale per Leonardo Booster e viene fuori da:

- `std-h = GPU-h * num core / num GPU`

## Numero utenti attivi sui cluster

Con questo comando si ottiene il numero di **utenti di ogni tipo** presenti sul cluster:

- `cindata -U -a /home/ | wc -l`

Con questo comando si ottiene il numero di **utenti esterni** presenti sul cluster:

- `cindata -U -a /home/ | grep "userexternal" | wc -l`

## Chprj -l per utenti terzi

Per controllare dove punta la variabile `$WORK` di un utente, bisogna andare sulla sua home e controllare il contenuto del file `.projects`.  
Lì saranno indicati i progetti attivi e quelli non attivi (cioè scaduti e/o con budget finito) e quello su cui punta la variabile `$WORK` sarà indicato con `Default`.

## Info sulle qos

Per ricavare info sulle qos direttamente dai cluster si può lanciare il comando:

- `sacctmgr show qos <qos_name>`

che mostrerà tutte le caratteristiche della qos indicata.

Specificando il formato si ottiene la singola informazione richiesta:

- `sacctmgr show qos <qos_name> format=MaxWall`

## Progetti convenzioni e account avail

Quando viene chiesto di aumentare il budget di un account convenzionato e il progetto padre non ha abbastanza risorse da fornire, se tra gli account ce n’è uno che si chiama **avail** (o fake) va sottratto il budget di questo account, così da renderlo disponibile per quello che ci hanno richiesto di aumentare.  
In generale, prima di aumentare il budget al progetto padre, controllare se c’è un account `avail`, soprattutto se abbiamo a che fare con delle **convenzioni**.

## Errore: ORTE has lost communication with a remote daemon

**[probabilmente obsoleto]**

Questo tipo di errore è dovuto a un problema con l’Infiniband.

Rispondere con qualcosa del genere:

> Ci sono effettivamente problemi sulla network infiniband causati dal flapping di porte IB (disconnessioni puntuali di porte IB dei nodi) non ancora risolti e questi possono causare rallentamenti o fallimenti di job.  
> Si è ritenuta necessaria una sostituzione hardware per risolvere il problema, questa è però un'operazione molto lunga (tra attesa dei pezzi e lavorazione). Stiamo cercando di mitigare il più possibile il problema ma purtroppo non è possibile rimuoverlo totalmente. Avevamo trovato un buon metodo per mitigare ma evidentemente non è più efficace.
>
> Probabilmente anche i suoi job risentono di questo problema. Stiamo al momento facendo diversi test con script di utenti, avrebbe il path di una cartella di un suo use case con solo uno script, l'eseguibile e gli input richiesti, da poter mandare più volte in run brevi?

## Richiesta NON eliminazione WORK progetto Closed

Dopo 6 mesi dalla scadenza di un progetto, questo passa in stato `Closed` e la WORK viene cancellata.

Se un utente ci chiede altro tempo per recuperare i dati, scrivere subito ai sistemisti chiedendo di non eliminare la WORK e, se siamo ancora in tempo, procedere con l’aumento dell’`ExpirationDelay` di un ulteriore mese.

## Errori OOM

Quando si ha un errore OOM (Out Of Memory), vuol dire che non si richiedono abbastanza risorse per quel job.

Suggerire di indicare tra i parametri `sbatch` anche `cpus-per-task` e `ntasks-per-node`, in maniera tale che:

- `( --ntasks-per-node * --cpus-per-task ) = max CPU per nodo del cluster`

oppure esplicitare la memoria da utilizzare:

- `#SBATCH --mem=<max_mem_del_cluster>` (oppure `--mem=0`)

## Shared libraries

Se un utente ha un errore del tipo:

> error while loading shared libraries: libslurm_pmi.so: cannot open shared object file: No such file or directory

vuol dire che manca una libreria tra quelle necessarie a far girare il job.  
Nei casi più semplici si tratta di identificare il modulo da caricare e caricarlo, altrimenti c’è da fare un export del tipo:

```bash
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/slurm/current/lib/slurm"
```

andando in qualche modo a capire da dove prendere il percorso da indicare.

In genere i problemi con le librerie di **cuda** sono dovuti al fatto che sono disponibili solo sui nodi di calcolo (su cui però non c'è collegamento a internet) e non su quelli di login.

## Cercare utente su LDAP

[Sito LDAP](https://ldapadmin.cineca.it)

- Una volta sul sito, fare l'accesso premendo su "area autenticata" con le credenziali generali.
- Dal menu in alto a sinistra scegliere il server `ldap-hpc.cineca.it`.
- Fare login indicando come Login DN:

  ```text
  uid=amarcell,ou=NewInternal,ou=PersonalUsers,ou=Users,ou=HPC,o=cineca,c=it
  ```

  e come password quella HPC (HPC - Recovery Authentication Codes sul KeePass).

- Per la ricerca indicare nel campo Search Filter quello che si sta cercando; ad esempio, se si conosce il cognome:

  - `Search Filter: cn=*Marcelli`

## Aggiungere utente a progetto

In questi giorni di emergenza, potrebbe essere necessario aggiungere degli utenti ai propri progetti manualmente sul cluster.  
Il comando da usare è di questo tipo:

- `sacctmgr -i add user account=ai4al_llmft cluster=leonardo fairshare=parent name=lcavall1`

In questo modo l'utente può lanciare i job con quel progetto, ma non vedrà il progetto con saldo `-b` e nemmeno potrà accedere alla WORK poiché lo stiamo associando al DB di Slurm ma non a LDAP.  
Su Slurm possiamo agire anche noi, su LDAP servono i sistemisti.  
**ATTENZIONE**: questo comando va lanciato a ogni giro di procedure.

Esempi del comando sono presenti nel log di `ldap_to_slurmDB` che sta in `/cineca/var/log/`.

## Istruzioni installazione software

I build script dei software, dove sono indicate le istruzioni per installare un software, sono a percorsi del tipo:

- `/cineca/prod/build/applications/deepmd/2.2.11/intel-oneapi-compilers--2023.2.1/`

## Gaussian

Se un utente richiede di utilizzare Gaussian (o `g16`), è sufficiente aprire una issue e chiedere ai sistemisti di aggiungere l'utente nel gruppo `gaussian`.  
Controllare anche che non sia già associato al gruppo.

## Controllare errori su nodo

Quando ci sono errori e bisogna vedere i log dei nodi:

Per accedere bisogna avere la coppia di chiavi ssh sul cluster. Per averle bisogna lanciare `ssh-keygen`, che genera due chiavi `id_rsa`. Prendere quella pubblica e copiarla dentro `authorized_keys` (o rinominare `authorized_keys` e fare `cp id_rsa.pub authorized_keys`).

- controllare i nodi del job: `sacct -j <jobid> -o nodelist%50`
- accedere a uno dei nodi: `ssh <nodo>`, oppure `ssh <nodo>-hfi` su Marconi (richiede la password HPC) (il nome del nodo deve iniziare con `lrdn`)
- controllare i log, ad esempio:
  - `sudo cat /var/log/slurm/slurm.lrdn0076.log | grep <num_job>` (per vedere il file log)
  - `sudo cat /var/log/slurm/slurm.lrdn0076.log > job.log` (per salvare il file log)

## ISCRA istruzioni

Per tutte le richieste riguardanti gli Iscra ci si deve rivolgere a Paola Alberigo.  
Per quanto riguarda le operazioni su tali progetti, Paola gestisce il periodo di validità e i budget; a noi spettano le modifiche di quota WORK tramite UserDB.

Le risposte agli Iscra C arrivano entro 45 giorni dalla chiusura della call (ad esempio call che chiude il 15/11, notifichiamo entro il 31/12 più qualche giorno dovuto alle feste).

Le risposte degli Iscra B arrivano circa dopo 6 mesi dalla domanda.  
Ad esempio, per una domanda presentata a giugno 2025, comunicheremo la valutazione verso i primi di dicembre.

## Librerie CUDA

Se un utente sta provando a compilare qualcosa con CUDA, ma ottiene un errore del tipo `cannot find libcuda library`, vuol dire semplicemente che la libreria di cui necessita non è presente nel modulo.  
Di solito questo è dovuto al fatto che sono librerie per GPU e stanno compilando su nodi di login (alias frontend), quindi per ovviare al problema possono compilare il software sui nodi di calcolo.  
Al massimo si può provare a cercare il percorso della libreria partendo dal `LD_LIBRARY_PATH` del modulo, che poi l'utente potrà impostare con un comando del tipo:

```bash
export LD_LIBRARY_PATH=/leonardo/prod/opt/compilers/cuda/12.3/none/lib64/stubs/:$LD_LIBRARY_PATH
```

## Istruzioni BA

Impersonare `propro`:

```bash
ml profile/global ba

ba create
```

Riscrivi un build instruction come sopra, e lanci i vari comandi (non `ba`, ma proprio riga di comando). Fatto questo:

```bash
ba postprocess -i ba.config
```

(ti crea il MODULEFILE).

Lo editi ispirandoti a quelli di g100.

Poi:

```bash
ba module -i ba.config
```

poi `ba_mpm` per metterlo in `eng`.

## Cambio email utente

Quando un utente deve cambiare l'email e non può farlo autonomamente (tramite portale SSO), è possibile richiedere ai sistemisti di cambiare l'email direttamente da LDAP.

Questi sono i passaggi:

- **sospendere l'utenza** (se è in stato `Closed` se ne può fare a meno, ma se l'utente perde tempo è meglio sospenderlo) da Users permissions
- chiedere ai sistemisti di cambiare l'email
- l'utente effettua l'accesso a UserDB dove carica un documento d'identità (ricordarsi di marcare **UploadDocID**)
- verificare l'identità ed eventualmente inviare un link 2FA
- cancellare il documento

## Cancellare documenti su UserDB

Per cancellare il documento di una persona dopo averne verificata l'identità:

- Development --> Users permissions
- cercare l'utente
- mettere la spunta a sinistra
- selezionare "Cancella documento identità"
- cliccare su Execute

## Email nuovo utente

Quando un utente si iscrive su UserDB e richiede accesso ai cluster, viene controllato e accettato.  
Username e link 2FA non gli vengono comunicati finché non girano i processi di LDAP che creano l'utenza e la associano ai progetti (controllare nella cartella "Procedure (LDAP)").  
Solo a quel punto gli vengono inviate le email.

## Porta occupata

Per capire quale programma sta occupando una determinata porta, lanciare il comando:

```bash
netstat -tulpn | grep :<porta>
```

## Tunnel

Installare il pacchetto `pysocks`.

Sottomettere un job interattivo del tipo:

```bash
srun -p <partizione> -N 1 -n 1 -c 1 -A <account> -t 12:00:00 --pty bash
```

Aprire un'altra shell e fare accesso sullo stesso cluster; da qui verrà aperto un tunnel ssh verso il nodo di calcolo:

```bash
ssh-keygen
# battere Invio finché non viene restituito il prompt
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

Questo va fatto solo la prima volta per abilitare il login ssh sui nodi.

Aprire il tunnel vero e proprio:

```bash
ssh -R 8080 <nodo_allocato> -N
```

(con `-N` rimane sospeso in foreground)

Tornare sulla prima shell (quella sul nodo di calcolo) e fare questi due `export`:

```bash
export HTTP_PROXY=socks5://localhost:8080
export HTTPS_PROXY=socks5://localhost:8080
```

Infine eseguire lo script che si vuole utilizzare:

```bash
./<script>
```

**Attenzione**: il job è interattivo, questo vuol dire che rimarrà aperto anche una volta finito il download, continuando a consumare risorse.

## Job multipli

Questo è un esempio di script per lanciare job multipli:

```bash
#SBATCH -N 2
#SBATCH -n 2
#SBATCH -c 1

node_names=(compute-0-4 compute-0-6)
parameter=(parte__00 parte__01)

srun -n1 -N1 -w ${node_names} file.sh ${parameter} &
srun -n1 -N1 -w ${node_names} file.sh ${parameter}[1]
```

Esempi (bozze):

```bash
# N=1 exclusive n=16 &
# srun -n 8 ...
```

## Copiare chiavi step e trasferire dati da Leo a Pita

Quando si deve fare questa operazione, in genere per collegarsi a un cluster da un altro cluster, bisogna generare le chiavi con step ssh certificate:

```bash
step ssh certificate 'your email address' --provisioner cineca-hpc id_ecdsa
```

e copiare poi le chiavi nella cartella `.ssh` del cluster da cui collegarsi:

```bash
scp id_ecdsa* '<username>'@login.leonardo.cineca.it:/leonardo/home/userinternal/amarcell/.ssh/
```

Sarà poi possibile collegarsi da un cluster all'altro, ad esempio per copiare dei file:

```bash
rsync -PravzHS /leonardo/home/userinternal/amarcell/test_job.sh \
  amarcell@login05-ext.pitagora.cineca.it:/pitagora/home/userinternal/amarcell/
```

---

Istruzioni di Isabella:

1. On your laptop you download the ssh certificates with:

   ```bash
   step ssh certificate 'your email address' --provisioner cineca-hpc my_key
   ```

   You'll be asked to enter the password to encrypt the private key (an arbitrary password).

2. Transfer the obtained keys from your laptop to Leonardo (all the three generated keys: public, private, and the certificate key).

3. Launch from Leonardo the `rsync` command specifying the key:

   ```bash
   rsync -e "ssh -i PATH/somekey" /from/dir username@hostname:/to/dir/
   ```

## Warning Spack

Quando si carica un modulo spack, messaggi di errore del tipo:

```text
pcesar00@login07 test]$ spack env activate /leonardo/home/userexternal/pcesar00/test

-bash: export: `{name}_INC=/leonardo/home/userexternal/pcesar00/test/.spack-env/view/include:.': not a valid identifier

-bash: export: `{name}_INCLUDE=/leonardo/home/userexternal/pcesar00/test/.spack-env/view/include:.': not a valid identifier

-bash: export: `{name}_LIB=/leonardo/home/userexternal/pcesar00/test/.spack-env/view/lib64:/leonardo/home/userexternal/pcesar00/test/.spack-env/view/lib:.': not a valid identifier
```

dovrebbero essere solo dei warning.  
Rispondere:

> quel messaggio dovrebbe essere solo un warning e arpack dovrebbe essere stato comunque caricato.  
>  
> Puoi verificarlo lanciando il comando:  
> `spack find --loaded`  
>  
> che mostra tutti i pacchetti caricati con spack.  
>  
> Saluti,  
> Attilio

## Gitlab

L'accesso a Gitlab dovrebbe essere automatico una volta ottenuto un progetto attivo e configurata la 2FA.  
In caso di problemi, chiedere a Mirko di controllare se l'utente ha qualche anomalia (ad esempio se ha due account su Gitlab).  
Ticket di esempio: 53458.

## qos_special

Riferimento: <https://tts.hpc.cineca.it/Ticket/Display.html?id=48328>

La `qos_special` è una richiesta che può essere garantita se ben motivata e non ci sono alternative, e può arrivare fino a un massimo di 7 giorni. Inoltre, può essere accordata per un numero di job concordato con il supporto utenti e rimossa subito dopo l'utilizzo.

Fare questo genere di domande:

1. Su che cluster servirebbe?
2. In che modo è stato stimato che il walltime attuale non sia sufficiente?
3. Molti codici permettono di ripartire la simulazione in più job prevedendo ad esempio una funzionalità di restart per cui il job successivo può ripartire da dove si era interrotto il precedente. Nel suo caso non c'è proprio nulla che possa fare allo scopo?

## Indirizzi IP

Per vedere gli indirizzi IP dei datamover, ma anche dei login dei cluster e altro, usare il comando:

```bash
nslookup data.leonardo.cineca.it
```

## Matlab

Se un utente richiede di usare Matlab, basta aprire una issue ai sistemisti chiedendo di aggiungerlo ai gruppi `matlab` e `cinmat`.

Oggetto:

> Aggiunta utente a gruppi matlab e cinmat

Corpo:

> Ciao,  
> vi chiedo di aggiungere l’utente  
> XXX  
> ai gruppi matlab e cinmat.  
>  
> Grazie,  
> Attilio

## Aggiunta qos a utenti o account

Il comando generale per aggiungere una qos a un account è:

- `sacctmgr modify account <account_name> where cluster=<cluster_name> set qos+=qos_lowprio`

Tutti i comandi analoghi si trovano nella wiki interna a questa [pagina](https://wiki.u-gov.it/confluence/pages/viewpage.action?pageId=366347794).

## Comandi verifica certificato 2FA

```bash
ssh-add -L
step ssh list
step ssh list --raw '<user_email>' | step ssh inspect
```

## Progetti Frozen

C'è un nuovo stato per i progetti (sia HPC che Cloud): lo stato **Frozen**.  
Lo stato si inserisce tra gli stati **Expired** e **Closed** e dura un paio di mesi.

L'idea è che, terminato il periodo di expiration delay, l'area WORK del progetto non venga subito cancellata ma venga bloccato l'accesso agli utenti, ad esempio mettendo owner e gruppo a `root`. Non potendo improvvisamente accedere ai propri dati, si spera che anche gli utenti sprovveduti (che non hanno prestato attenzione alle tante mail che gli abbiamo inviato) si sveglino e ci scrivano prima di perdere definitivamente i loro dati.  
Una volta trascorsi i due mesi nello stato Frozen, passando allo stato Closed la cartella WORK viene cancellata definitivamente come prima.

Quando un utente ci chiede di accedere ai dati del proprio progetto in stato Frozen, lo estendiamo di 1 mese (**estensione in questo caso = aumento dell'expiration delay**) e gli diciamo che non ci saranno ulteriori estensioni.

## Installazione con BA

Entrare con `propro01`:

```bash
sudo -i -u propro01
```

Caricare `ba`:

```bash
module load autoload profile/global ba
```

Avviare la creazione con:

```bash
ba create
```

e inserire le impostazioni che servono (di solito `applications`, `binary`, `single` e `false`).

[esempio per ams 2025.104]

Mettere il `.tar.gz` nella cartella `BA_WORK` e unzippare:

```bash
tar xvzf ams2023.104.pc64_linux.intelmpi+StaticMKL.bin.tgz
```

Creare la cartella:

```bash
mkdir -p /cineca/prod/opt/applications/ams/2023.104/binary/
```

e copiare il file unzippato in:

```bash
cp -r * /cineca/prod/opt/applications/ams/2023.104/binary/
```

Lanciare:

```bash
ba postprocess -i ba.config
ba module -i ba.config
```

inserendo le informazioni che vengono richieste.

A questo punto il modulo dovrebbe essere disponibile in `global` ma va esplicitato per essere caricato.  
Se lo si vuole mettere in `base`, lanciare:

```bash
ba_mpm
```

Se lo si vuole mettere in un altro profilo, lanciare:

```bash
ba_mpm <profilo>
```

Selezionare il modulo mettendo una X con la barra spaziatrice e salvare.

Ora dovrebbe essere nel profilo desiderato.

Nel caso, controllare la [guida](https://wiki.u-gov.it/confluence/pages/viewpage.action?spaceKey=SCAIAR&title=BA0.4+-+come+creare+i+moduli).

## Crontab

Se viene chiesto l'accesso a `crontab` per un'utenza di catena, basta aprire una issue ai sistemisti per farla abilitare.  
Non servono altre azioni particolari. I cron per gli utenti di catena li abilitiamo noi.

## Classificazione Pitagora

- Pitagora B --> Pitagora Booster
- Pitagora AMD --> Pitagora DCGP

## SSH su un nodo

Per accedere a un nodo è necessario disporre di chiave pubblica/privata.

Per farlo:

- andare sul nodo di login
- eseguire `ssh-keygen` (tenere a mente il nome del file!)
- `cat .ssh/file_chiave.pub >> .ssh/authorized_keys`

Per accedere sarà poi sufficiente lanciare:

- `ssh lrdnxxxx`

N.B. gli utenti esterni possono accedere solo ai nodi dei propri job in esecuzione.

## Getfacl / setfacl

Per impostare dei permessi speciali per un utente/gruppo, la struttura del comando è:

```bash
setfacl -m u:<username>:rwx cartella/file
```

Per dare i permessi anche alle sottocartelle:

```bash
setfacl -R -m u:ladamsk1:rwx /g100_scratch/userinternal/amarcell/
```

Per annullare le impostazioni di `setfacl` ci sono 2 opzioni:

```bash
setfacl -x u:ladamsk1:rwx /g100_scratch/userinternal/amarcell/
```

- rimuove i permessi dati a quell'utente

```bash
setfacl -b /g100_scratch/userinternal/amarcell/
```

- rimuove **tutti** i permessi speciali concessi (anche ad altri utenti) e resetta la cartella ai permessi originali

## Accedere a un nodo tramite tunnel ssh

Copio le istruzioni inviate nel ticket [68860](https://tts.hpc.cineca.it/Ticket/Display.html?id=68860).

Ti spiego la procedura (da fare solo una prima volta):

- Se devi accedere con ssh da login a compute:

  ```bash
  ssh leonardo-login
  ssh-keygen  # batti invio 3 volte fino a quando ti ritorna il prompt
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
  ```

- Se devi accedere con `ProxyJump`:

  - dalla tua workstation in locale, lancia `ssh-keygen` se non hai già una coppia di chiavi (non userei `my_key` perché questa va rigenerata ogni 12 ore).
  - copia il contenuto della chiave `.pub` e mettilo su `~/.ssh/authorized_keys` di Leonardo.

Dopo aver richiesto il nodo con `srun`, prendi nota del nodo a cui ti colleghi, ad esempio `lrdn4941`, e nel file `.ssh/config` aggiungi:

```text
Host *
  ServerAliveInterval 240

Host login.leonardo.cineca.it
  HostName login01-ext.leonardo.cineca.it
  User mtagliaz
  ServerAliveInterval 60

Host leonardo-compute
  User mtagliaz
  HostName lrdn4941
  ProxyJump login.leonardo.cineca.it
  ForwardAgent yes
```

A questo punto, per fare login da terminale puoi lanciare:

```bash
ssh leonardo-compute
```

Ti chiederà la tua password HPC.

## Interactive Computing

Se qualcuno ha problemi a utilizzare l'IC, controllare per prima cosa se la `$HOME` dell'utente è piena.  
Se il problema non è quello, controllare se abbia abbastanza risorse per lanciare il job con le impostazioni richieste.

## Verifica installazioni

Dunque, ho controllato solo i due pacchetti compilati con gcc (li trovi tutti così, in realtà):

```bash
ml spack
spack find -lvp lammps
```

Dentro il file (e analogamente per l'altra versione che ha una hash diversa nel path):

```text
/pitagora/prod/spack/6.1/install/0.22/linux-rhel9-zen4/gcc-12.3.0/lammps-20230802.3-oshrlzukkcn5eilewtwknp6trbocza4t/.spack/spack-build-out.txt.gz
```

vedo:

- `-DPKG_MISC:BOOL=OFF`

(side note: `grep` non funziona perché il file è compresso, dio solo sa perché)

## FairShare

```text
[ladamsk1@login01 ~]$ sshare -A IscrC_O2CuCO2R
Account User RawShares NormShares RawUsage EffectvUsage FairShare
-------------------- ---------- ---------- ----------- ----------- ------------- ----------
iscrc_o2cuco2r 2777 0.000408 39273 0.000151 0.774251

[ladamsk1@login01 ~]$ sshare -A IscrC_ZinCuNO3
Account User RawShares NormShares RawUsage EffectvUsage FairShare
-------------------- ---------- ---------- ----------- ----------- ------------- ----------
iscrc_zincuno3 3703 0.000545 3021621 0.000878 0.326898
```

Alle says that if you suddenly use a lot of hours, then for 4 days you're penalized by lower priority.

FairShare near 0 = low priority.

## Verificare presenza utenti EFGW

Se arriva una richiesta di 2FA da un utente EFGW (o altro per cui conviene controllare l'esistenza dell'utenza), per farlo si può andare al percorso:

- `/afs/eufus.eu/user/g/`

e controllare che ci sia l'utenza in questione.

## Collegarsi a nodo compute da VSCode

Dal nodo di login di Leonardo lancia un interactive job con le risorse che ti servono, ad esempio: 
``` 
srun -N1 -n1 --ntasks-per-node=1 -A IscrB_MMFM --time=0:30:00 --partition=boost_usr_prod --qos=bost_qos_dbg --pty /bin/bash
```

e prendi nota del nodo a cui ti colleghi, in questo caso il lrdn3456.

nel file **.ssh/config** aggiungi
```
Host leonardo-login
    HostName login.leonardo.cineca.it
    User amarcell
Host leonardo-compute
    User amarcell
    HostName lrdn3456
    ProxyJump leonardo-login
```

A questo punto per fare login da terminale si può lanciare  
ssh leonardo-compute  
che chiederà la password HPC

Da VSCode  
- premere il tasto F1
- scrivere "Remote-SSH: Connect to Host"
- selezionare la connessione leonardo-compute
