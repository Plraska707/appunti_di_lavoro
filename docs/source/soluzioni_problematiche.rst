#######################
Soluzioni Problematiche
#######################

Licenze
=======

Licenze valide per tutti
------------------------

Nei casi in cui abbiamo delle licenze valide per tutti, è sufficiente
aggiornare il file di licenza presente sul cluster usando l’utenza
propro01 (ad esempio con NAG). - Si va sul cluster - si fa un module av
così da vedere tutte le versioni disponibili - si va al percorso che
contiene la licenza (di solito c’è un “license” nel percorso) - si
rinomina il file vecchio seguendo la nomenclatura usata per i
precedenti, e.g: cp license.lic license20240531 - si copia nel file di
licenza la licenza nuova - si ripete per ogni versione mostrata da
module av

Licenze tramite license manager
-------------------------------

Altre licenze sono gestite tramite License manager e in questi casi
vanno messi in whitelist gli IP dei server su cui sono presenti le
licenze degli utenti. Se la licenza è installata su un license server di
un’università, queste sono le informazioni di cui necessitiamo per
effettuare il collegamento:

-  indirizzo IP (pubblico) e porta dietro cui è in ascolto il license
   manager
-  apertura del firewall del license server da parte dell’IT
   dell’università verso gli IP del nostro cluster Cineca (una volta
   chiarito quale cluster, inviare la lista di IP)
-  firma di un documento di esonero da parte dell’intestatario della
   licenza.

Per verificare la connessione con i server di licenza lanciare comandi
di questo tipo: - telnet IP porta - telnet pcdmavallonelic.polito.it
5053 - rlmutil rlmstat -c 29000@pcdmavallonelic.polito.it -a - nmap
pcdmavallonelic.polito.it -p 5053

Caricare prima il modulo **superc** e nel caso lanciarli da VM
hpcsupport.

La nuova connessione va anche registrata sulla `tabella delle
licenze <https://wiki.u-gov.it/confluence/pages/viewpage.action?spaceKey=SCAIIN&title=Licenze%3A+gestione+operativa#Licenze:gestioneoperativa-2.2Licenze>`__

Il ticket
`#48000 <https://tts.hpc.cineca.it/Ticket/Display.html?id=48000>`__ ha
un esempio per Ansys, insieme alla
`issue <https://jira.u-gov.it/jira/servicedesk/customer/portal/42/SDHPCSY-42107>`__
in cui chiedo di mettere l’indirizzo in whitelist.

Propro01
========

propro01 è l’utenza con cui si fanno modifiche che valgono per tutto il
cluster. Per accedere come propro01, una volta fatto l’accesso sul
cluster, lanciare - sudo -i -u propro01

per Leonardo vale solo sulle VM.

Qualora non funzioni, provare con - su - propro01

Modificare una qos
==================

Accedere a una delle VM - sup01

Impersonare cinprod: - sudo -i -u cinprod

Lanciare il comando per la modifica desiderata: - sacctmgr modify qos
qos_slowprio set MaxTRES=node=256 MaxTRESPU=node=256 MaxWall=12:00:00

Oppure: - sacctmgr update qos qos_deste set
GrpTRES=node=256,cpu=28672,mem=126464000
MaxTRESPA=node=256,cpu=28672,mem=126464000

**Attenzione** accertarsi che il num di cpu e la memoria concordino con
il numero di nodi indicato

Con il comando scontrol show node si può vedere la RealMemory e la
MemSpecLimit. La loro differenza è la memoria disponibile per ogni nodo,
e.g.: RealMemory=514000 MemSpecLimit=20000 514000-20000 = 494000

E quindi: - node=256 - cpu=28672 - mem=126464000

Poi, associare la qos alla propria utenza con cin_staff: - sacctmgr
modify user amarcell where cluster=leonardo account=cin_staff set
qos+=qos_deste

e provare a lanciare un job - srun -N 256 –ntasks-per-node=112
–qos=qos_deste -p dcgp_usr_prod–pty bash

Se è tutto ok, associare la qos all’account che lo dovrà utilizzare: -
sacctmgr modify account DestE_330_26_0 set qos+=qos_deste

eimpostare i limiti di associazione così da limitare il numero di nodi
utilizzabili con lo stesso account: - sacctmgr modify account where
account=DestE_330_26_0 cluster=leonardo set MaxWall=24:00:00
MaxTRES=node=256 GrpTRES=node=256

Comando Datamover tra due cluster
=================================

Qualora la copia tra due cluster non funzioni nella maniera più
semplice, provare con questo comando: - ssh -xt
nchuluch@data.marconi.cineca.it rsync -PravzHS
nchuluch@data.leonardo.cineca.it:/leonardo_scratch/large/userexternal/nchuluch/nchuluch/TAE/MAST_Feb/n3_orig_bump_tempscan/40/orb5_res.h5
/marconi/home/userexternal/nchuluch

Contatti
========

Chi contattare in caso di richieste

-  ISCRA –> Paola Alberigo (Paola gestisce il periodo di validità e i
   budget, a noi spettano le modifiche di quota WORK tramite UserDB.)
-  Eurofusion –> Richard Kamendje (per aumenti di quota sotto i 20-30TB
   non serve chiedergli nulla) `vedere
   qui <https://wiki.u-gov.it/confluence/pages/viewpage.action?spaceKey=SCAIIN&title=Quote+Work+richieste+nei+proposal+EUROFUSION>`__
-  Progetti Chiusi da recuperare in extremis –> Marco Alberoni
   (sistemisti in generale)
-  Ticket in cui chiedono di pagare per risorse sui cluster –> Eric
   Pascolo e il suo capo Arlandini
-  Progetti vari (e.g. accademici, anche se chiedono di pagare)–>
   Maurizio Cremonesi
-  EUROHPC –> Tiziana
-  corsi vari: Alle e Orlenys. Di solito dovrebbero scrivere a
   corsi.hpc@cineca.it, ma se ci becchiamo qualcosa, scrivere ad uno dei
   due
-  ICSC: Davide Salomoni davide@supercomputing-icsc.it
-  CESMA: Ing. Vincenzo Moscato vmoscato@unina.it
-  Scuola Superiore Meridionale: Ing. Raffaele Cacciano
   (r.cacciano@ssmeridionale.it)

Controllare responsabile di un software
=======================================

-  modmap -m
-  caricare profilo e modulo
-  module show
-  ls sul percorso del modulefile (in alto) e aprirlo per leggerne il
   responsabile, oltre alle altre info riportate

Spack
=====

I programmi installati sulle macchine sono divisi in profili, librerie
etc.

I moduli possono essere esclusivi o adattivi

I profili global e base sono esclusivi, cioè può essere caricato solo
uno di loro alla volta.

Gli altri profili sono additivi, cioè caricandoli si aggiungono a quelli
già presenti

module av -a –> mostra tutti i moduli con quel nome, anche quelli
nascosti

Per caricare un modulo nascosto è necessario indicarne il nome per
intero (e.g. cuda/11.1.0–gcc–10.2.0)

module show –> mostra il percorso del file del modulo (modulefile) in
cui sono presenti tutti i suoi settaggi

Al percorso - /cineca/prod/opt/helps/

sono presenti varie cartelle per i vari software, con all’interno un
modulefile nascosto (.help) in cui sono gli script utili per tutte le
installazioni del software.

Al percorso - /cineca/prod/opt/modulefiles/

ci sono i modulefiles persoanlizzati dei vari programmi, creati
appositamente e con il nome di quella installazione (il numero della
versione)

Quando si crea un modulo, questo va in global o base e può poi essere
copiato in un profilo a scelta.

Copiare un modulo corrisponde a copiare una cartella, lo si può fare con
ba_mpm o con spack.

Le ricette di spack sono gestite in una package repository (cartella
creata da spack quando deve cercare un package per nome) al percorso -
/cineca/prod/opt/tools/spack/0.14.2-prod/none/var/spack/repos/builtin/packages/

Dove si trovano anche le cartelle con tutti i packages e il file
repo.yaml che contiene i metadata per la configurazione dei pacchetti.

Andando ad aprire le cartelle di uno dei pacchetti troviamo un file
package.py e altri file necessari. Questo package.py è la ricetta di
quel pacchetto

Il file repos.yaml contiene l’ordine dei percorsi in cui spack andrà a
cercare il package da installare e la relativa ricetta. Il valore di
default è - /var/spack/repos/builtin/packages/

Versioni diverse di spack consentono di installare software diversi.

Per controllare quale versione di un software può essere installata con
una certa versione di spack, si va a controllare sul `github di
spack <https://github.com/spack/spack/tree/develop/var/spack/repos/builtin/packages>`__
aggiungengo il nome del software al percorso del link. Per aggiungere
una versione alla ricetta, si va sulla pagina github relativa al
software, dentro il file package.py, si prende la riga della versione
che ci interessa e la si incolla nella ricetta sul cluster, tramite
comando spack edit.

-  spack list –> mostra tutti i software che possono essere installati
   con spack
-  spack list –> mostra tutte le versioni di un software
-  spack info –> mostra la ricetta di un software installato
-  spack edit –> apre la ricetta in modalita modifica (con vim)
-  spack spec -Il –> mostra un’anteprima di come verrà installato un
   programma, con le impostazioni di - variabili e dipendenze
-  spack find –> mostra tutti i software già installati con speck
-  spack find –loaded –> mostra i pacchetti attualmente caricati
-  spack diff /hash1 /hash2 mostra le differenze tra due specifiche
   diverse (identificate da due hash diversi)

simboli di spack: - ``+`` –> imposta una variabile ad on - ``-`` –>
imposta una variabile ad off (indicata con ~) - ``=`` –> definisce il
valore di una variabile - ``%`` –> definisce il compilatore - ``^`` –>
definisce la dipendenza - ``@`` –> definisce la versione

comandi spack find: - spack find -l –> mostra lista - spack find -p –>
mostra percorso di installazione - spack find -v –> mostra le variabili
- spack find -v –> mostra le variabili - spack find -d –> mostra le
dipendenze

per creare un modulo con spack: - spack module tcl refresh ``<nome>``

File Slurm
==========

Rinnovo password tts-hpc-usersupport@cineca.it
==============================================

Quando arriva un ticket relativo al rinnovo della password per tts, fare
riferimento a Susana

slurm.config
============

se c’è bisogno di controllare questo file per verificare le impostazioni
di slurm sul cluster, lo si può trovare al percorso: -
/var/spool/slurmd/conf-cache/slurm.conf

VASP
====

Quando un utente richiede di utilizzare VASP su un cluster, bisogna: -
chiedergli se ha una licenza VASP ed eventualmente di fornirne il numero
- chiedere a Lorenzo Varrassi [STRIKEOUT:Mariella Ippolito] di
controllare che sia correttamente associato alla licenza, indicando
l’email dell’utente e il numero della licenza - se è tutto ok, seguire
le istruzioni su questa
`pagina <https://wiki.u-gov.it/confluence/pages/viewpage.action?spaceKey=SCAIIN&title=Apps+with+restrict+use%3A+how+to+add+users>`__

Installazione da sorgente
=========================

Quando si deve installare da file sorgente, conviene cercare le
istruzioni in un qualche file README presente nella cartella.

In generale si tratta di file tar.gz o tar.bz2 che vanno estratti con
comandi del tipo tar zxvf myapp.tar.gz oppure tar jxvf myapp.tar.bz2.

Poi cd nella cartella creata e lanciare ./configure e/o make a seconda
dei casi.

Stale file handle
=================

Quando gli utenti ci comunicano questo tipo di errore, è bene: -
controllare i nodi del job: sacct -j -o nodelist%50 - seguire le
istruzioni riportate qui:
`link <https://wiki.u-gov.it/confluence/display/SCAIUS/FAQ#FAQ-CanIloginwithsshinsideacomputenode?>`__
(il nome del nodo deve iniziare con lrdn) - controllare i log, e.g.: -
sudo cat /var/log/slurm/slurm.lrdn0076.log (per vedere il file log) -
sudo cat /var/log/slurm/slurm.lrdn0076.log > job.log (per salvare il
file log) - vedere se c’è qualche errore esplicito agli orari indicati -
aprire ticket ai sistemisti del tipo: Ciao, oggi è arrivata una
segnalazione di stale file handle sulla scratch di Marconi. L’utente e
il jobid sono: cnuehren 13233799 Saluti, Attilio

se magari trovo qualcosa nei log indicarlo nella issue. Rispondere poi
all’utente con quello che dicono i sistemisti.

Questo problema solitamente accade a causa di noti problemi puntuali
della rete, che causano il temporaneo unmount del filesystem per i nodi
coinvolti, risultando nell’errore osservato. Questo tipo di problemi è
causato sostanzialmente dall’età del cluster (specialmente per Marconi)
e, vista la prossima dismissione dello stesso e la sporadicità con cui
si presentano queste problematiche, non possiamo fare altro che tentare
di limitarle con interventi conservativi ove necessario.

[It seems there has been a file system error with subsequent nodes
unmount, which results in the error shown. Everything should be working
correctly now. This type of problems is caused essentially by the
cluster’s age (especially for Marconi) and, given its upcoming
decommissioning and the sporadic nature of these problems, we can only
try to limit them by conservative interventions where necessary.]

Help dei moduli
===============

Sui cluster al percorso - /cineca/prod/opt/helps

si dovrebbe trovare la cartella di ogni modulo ed il file .help dove
scrivere il testo proposto dall’help.

Rinomina cartelle
=================

Quando un utente chiede di rinominare una cartella così da trasferire
tutti i dati del vecchio progetto in quello nuovo, assicurarsi che: - la
cartella esista - la cartella sia vuota (non affidarsi a cindata) - il
PI dei due progetti sia lo stesso - quanto è il volume della vecchia
cartella e quanti di questi siano occupati

Avvisare l’utente che al momento della rinomina la cartella deve essere
vuota e non ci devono essere utenti che ci stanno lavorando, altrimenti
i dati saranno eliminati.

Inviare poi una richiesta di questo tipo ai sys:

Ciao, vi chiedo di rinominare la cartella WORK /marconi_work/FUA36_REDIS
in /marconi_work/FUA37_REDIS. La nuova cartella esiste già e abbiamo
verificato che al momento è vuota. Ha inoltre lo stesso PI di quella
vecchia. La vecchia cartella ha un volume di 20 TB con 18 TB occupati.
Grazie, Attilio

Conversione tra diverse espressioni delle ore
=============================================

-  standard hours = core hours/FACTOR

-  core hours = local hours (verificarlo)

-  node hours = core hours \* num core per nodo

-  core hours = node hours / num core per nodo

-  node hour = GPU hour \* num di GPU per nodo

-  GPU hour = node hour / num di GPU per nodo

-  core hours = GPU hour \* num di GPU per nodo / num core per nodo

-  GPU hour = core hours \* num core per nodo / num di GPU per nodo

*ATTENZIONE* ci sono errori sul calcolo delle GPU/h, questa è l’unica
equivalenza di cui sono sicuro STD=GPUH\ *8 vale per Leonrado Booster e
viene fuori da std-h = GPU-h* num core / num GPU

Numero utenti attivi sui cluster
================================

Con questo comando si ottiene il numero di **utenti di ogni tipo**
presenti sul cluster: - cindata -U -a /home/ \| wc -l

Con questo comando si ottiene il numero di **utenti esterni** presenti
sul cluster: - cindata -U -a /home/ \| grep “userexternal” \| wc -l

Chprj -l per utenti terzi
=========================

Per controllare dove punta la variabile $WORK di un utente, bisogna
andare sulla sua home e controllare il contenuto del file .projects Lì
saranno indicati i progetti attivi e quelli non attivi (cioè scaduti e/o
con budget finito) e quello su cui punta la variabile $WORK sarà
indicato con Default.

Info sulle qos
==============

Per ricavare info sulle qos direttamente dai cluster si può lanciare il
comando: - sacctmgr show qos

che mostrerà tutte le caratteristiche della qos indicata.

Specificando il formato si ottiene la singola informazione richiesta: -
sacctmgr show qos format=MaxWall

Progetti convenzioni e account avail
====================================

Quando viene chiesto di aumentare il budget di un account convenzionato
e il progetto padre non ha abbastanza risorse da fornire, se tra gli
account ce n’è uno che si chiama **avail** (o fake) va sottratto del
budget di questo account, così da renderlo disponibile per quello che ci
hanno richiesto di aumentare. In generale, prima di aumentare il budget
al progetto padre, controllare se c’è un account avail, soprattutto se
abbiamo a che fare con delle **convenzioni**.

Errore: ORTE has lost communication with a remote daemon
========================================================

**[probabilmente obsoleto]**

Questo tipo di errore è dovuto ad un problema con l’Infiniband.

Rispondere con qualcosa del genere: Ci sono effettivamente problemi
sulla network infiniband causati dal flapping di porte IB
(disconnessioni puntuali di porte IB dei nodi) non ancora risolti e
questi possono causare rallentamenti o fallimenti di job. Si è ritenuta
necessaria una sostituzione hardware per risolvere il problema, questa è
però un’operazione molto lunga (tra attesa dei pezzi e lavorazione).
Stiamo cercando di mitigare il più possibile il problema ma purtroppo
non è possibile rimuoverlo totalmente. Avevamo trovato un buon metodo
per mitigare ma evidentemente non è più efficace.

Probabilmente anche i suoi job risentono di questo problema. Stiamo al
momento facendo diversi test con script di utenti, avrebbe il path di
una cartella di un suo use case con solo uno script, l’eseguibile, e
input richiesti, da poter mandare più volte in run brevi?

Richiesta NON eliminazione WORK progetto Closed
===============================================

Dopo 6 mesi dalla scadenza di un progetto, questo passa in stato Closed
e la WORK viene cancellata.

Se un utente ci chiede altro tempo per recuperare i dati, scrivere
subito ai sistemisti chiedendo di non eliminare la WORK e, se siamo
ancora in tempo, procedere con l’aumento dell’ExpirationDelay di un
ulteriore mese.

Errori OOM
==========

Quando si ha un errore OOM (Out Of Memory), vuol dire che non si
richiedono abbastanza risorse per quel job.

Suggerire di indicare tra i parametri sbatch anche cpus-per-task e
ntasks-per-node, in maniera tale che: - (–ntasks-per-node \*
–cpus-per-task )= max cpu per nodo del cluster

oppure esplicita la memoria da utilizzare: - #SBATCH –mem=max mem del
cluster (oppure –mem=0)

Shared libraries
================

Se un utente ha un errore del tipo: error while loading shared
libraries: libslurm_pmi.so: cannot open shared object file: No such file
or directory

Vuol dire che manca una libreria tra quelle necessarie a far girare il
job. Nei casi più semplici si tratta di identificare il modulo da
caricare e caricarlo, altrimenti c’è da fare un export del tipo: export
LD_LIBRARY_PATH=“$LD_LIBRARY_PATH:/opt/slurm/current/lib/slurm”

andando in qualche modo a capire dove prendere il percorso da indicare.

In genere i problemi con le librerie di **cuda** sono dovute al fatto
che sono disponibili solo sui nodi di calcolo (su cui però non c’è
collegamento a internet) e non su quelli di login.

Cercare utente su LDAP
======================

`Sito LDAP <https://ldapadmin.cineca.it>`__

-  Una volta sul sito fare l’accesso premendo su “area autenticata” con
   le Credenziali generali
-  Dal menu in alto a sinistra scegliere il server “ldap-hpc.cineca.it”
-  Fare login indicando come Login DN
   uid=amarcell,ou=NewInternal,ou=PersonalUsers,ou=Users,ou=HPC,o=cineca,c=it
   e password quella HPC (HPC - Recovery Authentication Codes sul
   KeePass)
-  Per la ricerca indicare nel campo Search Filter quello che si sta
   cercando ad esempio se si conosce il cognome: Search
   Filter:cn=*Marcelli

Aggiungere utente a progetto
============================

In questi giorni di emergenza, potrebbe essere necessario aggiungere
degli utenti ai propri progetti manualmente sul cluster. Il comando da
usare è di questo tipo: - sacctmgr -i add user account=ai4al_llmft
cluster=leonardo fairshare=parent name=lcavall1

In questo modo l’utente può lanciare i job con quel progetto, ma non
vedrai il progetto con saldo -b e nemmeno potrà accedere alla WORK
poiché lo stiamo associando al DB di SLURM ma non a LDAP. Su Slurm
possiamo agire anche noi, su LDPA servono i sys. **ATTENZIONE**: questo
comando va lanciato ad ogni giro di procedure.

￼ Esempi del comando sono presenti nel log di ldap_to_slurmDB che sta in
/cineca/var/log/

Istruzioni installazione software
=================================

I build script dei software, dove sono indicate le istruzioni per
installare un software, sono a percorsi del tipo
/cineca/prod/build/applications/deepmd/2.2.11/intel-oneapi-compilers–2023.2.1/

Gaussian
========

Se un utente richiede di utilizzare Gaussian (o g16), è sufficiente
aprire una issue e chiedere ai sistemisti di aggiungere l’utente nel
gruppo gaussian. Controllare anche che non sia già associato al gruppo.

Controllare errori su nodo
==========================

Quando ci sono errori e bisgona vedere i log dei nodi:

Per accedere bisogna avere la coppia di chiavi ssh sul cluster. Per
averle bisogna lanciare ssh-keygen, che genera due chiavi id_rsa.
Prendere quella pubblica e copiarla dentro authorized_keys (o rinominare
authorized_keys e fare “cp id_rsa.pub authorized_keys”).

-  controllare i nodi del job: sacct -j -o nodelist%50
-  accedere ad uno dei nodi: ssh , oppure ssh -hfi su Marconi (richiede
   la password HPC) (il nome del nodo deve iniziare con lrdn)
-  controllare i log, e.g.:
-  sudo cat /var/log/slurm/slurm.lrdn0076.log \| grep (per vedere il
   file log)
-  sudo cat /var/log/slurm/slurm.lrdn0076.log > job.log (per salvare il
   file log)

ISCRA istruzioni
================

Per tutte le richieste riguardanti gli Iscra ci si deve rivolgerea Paola
Alberigo. Per quanto riguarda le operazioni su tali progetti, Paola
gestisce il periodo di validità e i budget, a noi spettano le modifiche
di quota WORK tramite UserDB.

Le risposte agli Iscra C arrivano entro 45 gg dalla chiusura della call.
(ed esempio call che chiude 15/11, notifichiamo entro il 31/12+quache gg
dovuto alle feste)

Le risposte degli Iscra B arrivano circa dopo 6 mesi dalla domanda. Ad
esempio per una domanda presentata a giugno 2025, comunicheremo la
valutazione verso i primi di dicembre .

Librerie CUDA
=============

Se un utente sta provando a compilare qualcosa con cuda, ma ottiene un
errore del tipo “cannot find libcuda library”, vuol dire semplicemente
che la libreria di cui necessita non è presente nel modulo. Di solito
questo è dovuto al fatto che sono librerie per GPU e stanno compilando
su nodi di login (alias frontend), quindi per ovviare al problema
possono compilare il software sui nodi di calcolo. Al massimo si può
proare a cercare il percorso della libreria partendo dal LD_LIBRARY_PATH
del modulo, che poi l’utente potrà impostare con un comando del tipo:
export
LD_LIBRARY_PATH=/leonardo/prod/opt/compilers/cuda/12.3/none/lib64/stubs/:$LD_LIBRARY_PATH

Istruzioni BA
=============

impersonare propro:

ml profile/global ba

ba create

segui le istruzioni a schermo, ispirandoti a nomi e numeri che vedi in
questo path
(￼/cineca/prod/build/applications/ansys/232/binary/BUILD_INSTRUCTIONS)

riscrivi un build instruction come sopra, e lanci i vari comandi (non
ba, ma proprio riga di comando).fatto questo,

ba postprocess -i ba.config

(ti crea il MODULEFILE).

lo editi ispirandoti a quelli di g100.

poi

ba module -i ba.config

poi ba_mpm per metterlo in eng

Cambio email utente
===================

Quando un utente deve cambaire l’email e non può farlo autonomamente
(tramite portale SSO), è possibile richiedere ai sistemisti di cambiare
l’email direttamente da LDAP.

Questi sono i passaggi:

-  **sospendere l’utenza** (se è in stato Closed se ne può fare a meno,
   ma se l’utente perde tempo è meglio sospenderlo) da Users permissions
-  chiedere ai sistemisti di cambiare l’email
-  l’utente effettua l’accesso a UserDB dove carica un documento
   d’identità (ricordarsi di marcare **UploadDocID**)
-  verificare l’identità ed (eventualmente) inviare un link 2FA
-  cancellare il documento

Cancellare documenti su UserDB
==============================

Per cancellare il documento di una persona dopo averne verificata
l’identità: - Development –> Users permissions - cercare l’utente -
mettere la spunta a sinistra - selezionare “Cancella documento identita”
- cliccare su Execute

Email nuovo utente
==================

Quando un utente si sicrive su UserDB e richiede accesso ai cluster,
viene controllato e accettato. Username e link 2FA non gli vengono
comunicati finché non girano i processi di LDAP che creano l’utenza e la
associano ai progetti (controllare nella cartella “Procedure (LDAP)”).
Solo a quel punto gli vengono inviate le email.

Porta occupata
==============

Per capire quale programma sta occupando una determinata porta, lanciare
il comando: netstat -tulpn \| grep :

Tunnel
======

Installare il pacchetto pysocks

Sottomettere un job interattivo del tipo: srun -p -N 1 -n 1 -c 1 -A -t
12:00:00 –pty bash

Aprire un’altra shell e fare accesso sullo stesso cluster, da qui verrà
aperto un tunnel ssh verso il nodo di calcolo: ssh-keygen battti Invio
finché non viene restituito il prompt cut ~/.ssh/id_rsa.pub >>
~/.ssh/authorized_keys

questo va fatto solo la prima volta per abilitare il login ssh sui nodi.

Aprire il tunnel vero e proprio: ssh -R 8080 -N (con -N rimane hanging)

tornare sulla prima shell (quella sul nodo di calcolo) e fare questi due
export: export HTTP_PROXY=socks5//localhost:8080 export
HTTPS_PROXY=socks5//localhost:8080

infine esegui lo script che si vuole utilizzare ./

.. raw:: html

   <script>

**Attenzione**, il job è in interattivo, questo vuol dire che rimarrà
aperto anche una volta finito il download, continuando a consumare
risorse.

Job multipli
============

Questo è un esempio di script per lanciare job multipli:

#SBATCH -N 2 #SBATCH -n 2 #SBATCH -c 1

node_names=(compute-0-4 compute-0-6) parameter=(parte\__00 parte\__01)

srun -n1 -N1 -w $node_names[0] file.sh $parameter[0] & srun -n1 -N1 -w
$node_names[1] file.sh $parameter[1]

N=1 exclusive n=16 &

srun n=8

Copiare chiavi step e trasferire dati da Leo a Pita
===================================================

Quando si deve fare questa operazione, in genere per collegarsi ad un
cluster da un altro cluster, bisogna generare le chiavi con step ssh
certificate: - step ssh certificate ‘your email address’ –provisioner
cineca-hpc id_ecdsa

e copiare poi le chiavi nella cartella .ssh del cluster da cui
collegarsi: - scp id_ecdsa\*
<‘username’>@login.leonardo.cineca.it:/leonardo/home/userinternal/amarcell/.ssh/

Sarà poi possibile collegarsi da un cluster all’altro ad esempio per
copiare dei file:

rsync -PravzHS /leonardo/home/userinternal/amarcell/test_job.sh
amarcell@login05-ext.pitagora.cineca.it:/pitagora/home/userinternal/amarcell/

--------------

Istruzioni di Isabella:

1) on your laptop you download the ssh certificates with:

step ssh certificate ‘your email address’ –provisioner cineca-hpc my_key

You’ll be asked to enter the password to encrypt the private key (an
arbitrary password)

2) transfer the obtained keys from your laptop to Leonardo (all the
   three generated keys: public, private, and the certificate key)

3) launch from Leonardo the rsync command specifying the key:

rsync -e “ssh -i PATH/somekey” /from/dir username@hostname:/to/dir/

Warning Spack
=============

Quando si carica un modulo spack, messaggi di errore del tipo:

pcesar00@login07 test]$ spack env activate
/leonardo/home/userexternal/pcesar00/test

-bash: export:
``{name}_INC=/leonardo/home/userexternal/pcesar00/test/.spack-env/view/include:.': not a valid identifier``

-bash: export:
``{name}_INCLUDE=/leonardo/home/userexternal/pcesar00/test/.spack-env/view/include:.': not a valid identifier``

-bash: export:
``{name}_LIB=/leonardo/home/userexternal/pcesar00/test/.spack-env/view/lib64:/leonardo/home/userexternal/pcesar00/test/.spack-env/view/lib:.': not a valid identifier``

dovrebbero essere solo dei warning. Rispondere: quel messaggio dovrebbe
essere solo un warning e arpack dovrebbe essere stato comunque caricato.

Puoi verificarlo lanciando il comando: spack find –loaded

che mostra tutti i pacchetti caricati con spack.

Saluti,

Attilio

Gitlab
======

L’accesso a Gitlab dovrebbe essere automatico una volta ottenuto un
progetto attivo e configurata la 2FA. In caso di problemi chiedere a
Mirko di controllare se l’utente ha qualche anomalia (ad esempio se ha
due account su gitlab). Ticket di esempio: 53458

Qos_special
===========

Riferimento: https://tts.hpc.cineca.it/Ticket/Display.html?id=48328

la qos_special è una richiesta che può essere garantita se ben motivata
e non ci sono alternative, e può arrivare fino ad un massimo di 7
giorni. Inoltre, può essere accordata per un numero di job concordato
con il supporto utenti e rimossa subito dopo l’utilizzo.

Fare questo genere di domande 1) Su che cluster servirebbe? 2) In che
modo è stato stimato che il walltime attuale non sia sufficiente? 3)
Molti codici permettono di ripartire la simulazione in più job
prevedendo ad esempio una funzionalità di restart per cui il job
successivo può ripartire da dove si era interrotto il precedente. Nel
suo caso non c’è proprio nulla che possa fare allo scopo?

Indirizzi IP
============

Per vedere gli indirizzi IP dei datamover, ma anche login dei cluster e
altro, usare il comando: - nslookup data.leonardo.cineca.it

Matlab
======

Se un utente richiede di usare Matlab, basta aprire una issue ai
sistemisti chiedendo di aggiungerlo ai gruppi matlab e cinmat

Oggetto: Aggiunta utente a gruppi matlab e cinmat

Corpo: Ciao, vi chiedo di aggiungere l’utente XXX ai gruppi matlab e
cinmat.

Grazie, Attilio

Aggiunta qos a utenti o account
===============================

Il comando generale per aggiungere una qos ad un account è: - sacctmgr
modify account where cluster= set qos+=qos_lowprio

Tutti i comandi analoghi si trovano nella wiki interna a questa
`pagina <https://wiki.u-gov.it/confluence/pages/viewpage.action?pageId=366347794>`__.

Comandi verifica certificato 2FA
================================

ssh-add -L

step ssh list

step ssh list –raw’’ \| step ssh inspect

Progetti Frozen
===============

C’è un nuovo stato per i progetti (sia HPC che Cloud): lo stato
“Frozen”. Lo stato si inserisce tra gli stati Expired e Closed e dura un
paio di mesi. L’idea è che, terminato il periodo di expiration delay,
l’area WORK del progetto non venga subito cancellata ma venga bloccato
l’accesso agli utenti ad esempio mettendo owner e gruppo a root. Non
potendo improvvisamente accedere ai propri dati, si spera che anche gli
utenti sprovveduti (che non hanno prestato attenzione alle tante mail
che gli abbiamo inviato) si sveglino e ci scrivano prima di perdere
definitivamente i loro dati. Una volta trascorsi i due mesi nello stato
Frozen, passando allo stato Closed la cartella WORK viene cancellata
definitivamente come prima.

Quando un utente ci chiede di accedere ai dati del proprio progetto in
stato Frozen, lo estendiamo di 1 mese (**estensione in questo caso =
aumenta l’expiration delay**) e gli diciamo che non ci saranno ulteriori
estensioni.

Installazione con BA
====================

entrare con propro01: sudo -i -u propro01

caricare ba: module load autoload profile/global ba

Avviare la creazione con ba create

e inserire le impostazioni che servono (di solito applications, binary,
single e false)

[esempio per ams 2025.104]

mettere il tar.gz nella cartella BA_WORK e unzippare: tar xvzf
ams2023.104.pc64_linux.intelmpi+StaticMKL.bin.tgz

Creare la cartella mkdir -p
/cineca/prod/opt/applications/ams/2023.104/binary/ e copiare il file
unzippato in cp -r \* /cineca/prod/opt/applications/ams/2023.104/binary/

Lanciare ba postprocess -i ba.config e ba module -i ba.config

inserendo le info che vengono richieste

A questo punto il modulo dovrebbe essere disponibile in global ma va
esplicitato per essere caricato. Se lo si vuole mettere in base,
lanciare ba_mpm se lo si vuole mettere in un altro profilo, lanciare
ba_mpm

selezionare il modulo mettendo una X con la barra spaziatrice e salvare.

Ora dovrebbe essere nel profilo desiderato.

Nel caso, controllare sulla
`guida <https://wiki.u-gov.it/confluence/pages/viewpage.action?spaceKey=SCAIAR&title=BA0.4+-+come+creare+i+moduli>`__

Crontab
=======

Se viene chiesto l’accesso a crontab per un’utenza di catena, basta
aprire una issue ai sistemistiper farla abilitare. Non servono altre
azioni particolari. I cron per gli utenti di catena li abilitiamo

Classificazione Pitagora
========================

Pitagora B –> Pitagora Booster Pitagora AMD –> Pitagora DCGP

SSH su un nodo
==============

Per accedere ad un nodo è necessario disporre di chiave
pubblica/privata.

Per farlo: - andare sul nodo di login - ssh-keygen (tenere a mente il
nome del file!) - cat .ssh/file_chiave.pub >> .ssh/authorized_keys

per accedere sarà poi sufficiente lanciare: - ssh lrdnxxxx

N.B. gli utenti esterni possono accedere solo ai nodi dei propri job
running.

Getfacl setfacl
===============

Per impostare dei permessi speciali per un utente/gruppo, la struttura
del comando è: setfacl -m u::rwx cartella/file

per dare i permessi anche alle sottocartelle: setfacl -R -m
u:ladamsk1:rwx /g100_scratch/userinternal/amarcell/

To reverse the setfacl settings there are 2 options:

setfacl -x u:ladamsk1:rwx /g100_scratch/userinternal/amarcell/ would
remove the permissions I gave you on my scratch folder

setfacl -b /g100_scratch/userinternal/amarcell/ would remove ALL the
special permission granted, also the ones given to other users, and
reset the folder to the original permissions

Accedere ad un nodo tramite tunnel ssh
======================================

Copio le istruzioni inviate nel ticket
`68860 <https://tts.hpc.cineca.it/Ticket/Display.html?id=68860>`__

Ti spiego la procedura (da fare solo una prima volta)

-  Se devi accedere con ssh da login a compute: ssh leonardo-login
   ssh-keygen # batti invio 3 volte fino a quando ti ritorna il prompt
   cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

-  Se devi accedere con proxyjump: dalla tua workstation in locale,
   lancia ssh-keygen se non hai già una coppia di chiavi (non userei
   my_key perché questa va rigenerata ogni 12 ore). copia il contenuto
   della chiave .pub e mettilo su ~/.ssh/authorized_keys di Leonardo

Dopo aver richiesto il nodo con srun, prendi nota del nodo a cui ti
colleghi, ad esempio il lrdn4941, e nel file .ssh/config aggiungi

Host \* ServerAliveInterval 240

Host login.leonardo.cineca.it HostName login01-ext.leonardo.cineca.it
User mtagliaz ServerAliveInterval 60

Host leonardo-compute User mtagliaz HostName lrdn4941 ProxyJump
login.leonardo.cineca.it ForwardAgent yes

A questo punto per fare login da terminale puoi lanciare ssh
leonardo-compute ti chiederà la tua password HPC

Interactive Computing
=====================

Se qualcuno ha problemi ad utilizzare l’IC, controllare per prima cosa
se la $HOME dell’utente è piena. Se il problema non è quello,
controllare se abbia abbastanza risorse per lanciare il job con le
impostazioni richieste.

Verifica installazioni
======================

dunque, ho controllato solo i due pacchetti compilati con gcc (li trovi
tutti così in realtà: ml spack spack find -lvp lammps ).dentro il file
(e analogamente per l’altra versione che ha una hash diversa nel path)
/pitagora/prod/spack/6.1/install/0.22/linux-rhel9-zen4/gcc-12.3.0/lammps-20230802.3-oshrlzukkcn5eilewtwknp6trbocza4t/.spack/spack-build-out.txt.gz
vedo -DPKG_MISC:BOOL=OFF (side note:grep non funziona perché il file è
compresso, dio solo sa perché)

FairShare
=========

[ladamsk1@login01 ~]$ sshare -A IscrC_O2CuCO2R
AccountUserRawSharesNormSharesRawUsageEffectvUsageFairShare ——————– ———-
———- ———– ———– ————- ———- iscrc_o2cuco2r27770.000408 392730.000151
0.774251 [ladamsk1@login01 ~]$ sshare -A IscrC_ZinCuNO3
AccountUserRawSharesNormSharesRawUsageEffectvUsageFairShare ——————– ———-
———- ———– ———– ————- ———- iscrc_zincuno337030.000545 30216210.000878
0.326898

Alle says that if you suddenly use a lot of hours, then for 4 days
your’re penalized by lower priority.

FairShare if near 0=low priority.

Verificare presenza utenti EFGW
===============================

Se arriva una richiesta di 2FA da un utente EFGW (o altro per cui
conviene controllare l’esistenza dell’utenza), per farlo si può andare
al percorso: /afs/eufus.eu/user/g/ e controllare che ci sia l’utenza in
questione.