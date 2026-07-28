=======================
Soluzioni Problematiche
=======================

Licenze
-------

Licenze valide per tutti
^^^^^^^^^^^^^^^^^^^^^^^^

Nei casi in cui abbiamo delle licenze valide per tutti, è sufficiente aggiornare il file di licenza presente sul cluster usando l'utenza propro01 (ad esempio con NAG).

- Si va sul cluster.
- Si fa un ``module av <nome_software>`` così da vedere tutte le versioni disponibili.
- Si va al percorso che contiene la licenza (di solito c'è un ``license`` nel percorso).
- Si rinomina il file vecchio seguendo la nomenclatura usata per i precedenti, per esempio ``cp license.lic license20240531``.
- Si copia nel file di licenza la licenza nuova.
- Si ripete per ogni versione mostrata da ``module av``.

Licenze tramite license manager
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Altre licenze sono gestite tramite License manager e in questi casi vanno messi in whitelist gli IP dei server su cui sono presenti le licenze degli utenti.

Se la licenza è installata su un license server di un'università, queste sono le informazioni di cui necessitiamo per effettuare il collegamento:

- indirizzo IP (pubblico) e porta dietro cui è in ascolto il license manager
- apertura del firewall del license server da parte dell'IT dell'università verso gli IP del nostro cluster Cineca
- firma di un documento di esonero da parte dell'intestatario della licenza

Per verificare la connessione con i server di licenza lanciare comandi di questo tipo:

- ``telnet IP porta``
- ``telnet pcdmavallonelic.polito.it 5053``
- ``rlmutil rlmstat -c 29000@pcdmavallonelic.polito.it -a``
- ``nmap pcdmavallonelic.polito.it -p 5053``

Caricare prima il modulo ``superc`` e nel caso lanciarli da VM hpcsupport.

La nuova connessione va anche registrata sulla tabella delle licenze.

Il ticket #48000 ha un esempio per Ansys, insieme alla issue in cui chiedo di mettere l'indirizzo in whitelist.

Propro01
--------

propro01 è l'utenza con cui si fanno modifiche che valgono per tutto il cluster.

Per accedere come propro01, una volta fatto l'accesso sul cluster, lanciare:

- ``sudo -i -u propro01``

Per Leonardo vale solo sulle VM.

Qualora non funzioni, provare con:

- ``su - propro01``

Modificare una qos
------------------

Accedere a una delle VM:

- sup01

Impersonare cinprod:

- ``sudo -i -u cinprod``

Lanciare il comando per la modifica desiderata:

- ``sacctmgr modify qos qos_slowprio set MaxTRES=node=256 MaxTRESPU=node=256 MaxWall=12:00:00``

Oppure:

- ``sacctmgr update qos qos_deste set GrpTRES=node=256,cpu=28672,mem=126464000 MaxTRESPA=node=256,cpu=28672,mem=126464000``

Attenzione: accertarsi che il numero di cpu e la memoria concordino con il numero di nodi indicato.

Con il comando ``scontrol show node <nodo_di_quella_partizione>`` si può vedere la RealMemory e la MemSpecLimit.

La loro differenza è la memoria disponibile per ogni nodo, per esempio:

- ``RealMemory=514000``
- ``MemSpecLimit=20000``
- ``514000-20000 = 494000``

E quindi:

- ``node=256``
- ``cpu=28672``
- ``mem=126464000``

Poi, associare la qos alla propria utenza con cin_staff:

- ``sacctmgr modify user amarcell where cluster=leonardo account=cin_staff set qos+=qos_deste``

e provare a lanciare un job:

- ``srun -N 256 ^^ntasks-per-node=112 ^^qos=qos_deste -p dcgp_usr_prod ^^pty bash``

Se è tutto ok, associare la qos all'account che lo dovrà utilizzare:

- ``sacctmgr modify account DestE_330_26_0 set qos+=qos_deste``

e impostare i limiti di associazione così da limitare il numero di nodi utilizzabili con lo stesso account:

- ``sacctmgr modify account where account=DestE_330_26_0 cluster=leonardo set MaxWall=24:00:00 MaxTRES=node=256 GrpTRES=node=256``

Comando Datamover tra due cluster
------------------

Qualora la copia tra due cluster non funzioni nella maniera più semplice, provare con questo comando:

- ``ssh -xt nchuluch@data.marconi.cineca.it rsync -PravzHS nchuluch@data.leonardo.cineca.it:/leonardo_scratch/large/userexternal/nchuluch/nchuluch/TAE/MAST_Feb/n3_orig_bump_tempscan/40/orb5_res.h5 /marconi/home/userexternal/nchuluch``

Contatti
--------

Chi contattare in caso di richieste:

- ISCRA ^^> Paola Alberigo.
- Eurofusion ^^> Richard Kamendje.
- Progetti chiusi da recuperare in extremis ^^> Marco Alberoni.
- Ticket in cui chiedono di pagare per risorse sui cluster ^^> Eric Pascolo e il suo capo Arlandini.
- Progetti vari (e.g. accademici, anche se chiedono di pagare) ^^> Maurizio Cremonesi.
- EUROHPC ^^> Tiziana.
- Corsi vari: Alle e Orlenys.
- ICSC: Davide Salomoni.
- CESMA: Ing. Vincenzo Moscato.
- Scuola Superiore Meridionale: Ing. Raffaele Cacciano.

Controllare responsabile di un software
--------------------------------------

- ``modmap -m <nome_software>``
- caricare profilo e modulo
- ``module show <nome_software>``
- fare ``ls`` sul percorso del modulefile (in alto) e aprirlo per leggerne il responsabile, oltre alle altre info riportate

Spack
--------

I programmi installati sulle macchine sono divisi in profili, librerie etc.

I moduli possono essere esclusivi o adattivi.

I profili global e base sono esclusivi, cioè può essere caricato solo uno di loro alla volta.

Gli altri profili sono additivi, cioè caricandoli si aggiungono a quelli già presenti.

- ``module av -a <nome_modulo>`` mostra tutti i moduli con quel nome, anche quelli nascosti.
- Per caricare un modulo nascosto è necessario indicarne il nome per intero, per esempio ``cuda/11.1.0^^gcc^^10.2.0``.
- ``module show <nome_modulo>`` mostra il percorso del file del modulo in cui sono presenti tutti i suoi settaggi.

Al percorso ``/cineca/prod/opt/helps/`` sono presenti varie cartelle per i vari software, con all'interno un modulefile nascosto ``.help`` in cui sono gli script utili per tutte le installazioni del software.

Al percorso ``/cineca/prod/opt/modulefiles/`` ci sono i modulefiles personalizzati dei vari programmi, creati appositamente e con il nome di quella installazione.

Quando si crea un modulo, questo va in global o base e può poi essere copiato in un profilo a scelta.

Copiare un modulo corrisponde a copiare una cartella; lo si può fare con ``ba_mpm`` o con spack.

Le ricette di spack sono gestite in una package repository al percorso ``/cineca/prod/opt/tools/spack/0.14.2-prod/none/var/spack/repos/builtin/packages/``.

Andando ad aprire le cartelle di uno dei pacchetti troviamo un file ``package.py`` e altri file necessari: questo ``package.py`` è la ricetta di quel pacchetto.

Il file ``repos.yaml`` contiene l'ordine dei percorsi in cui spack andrà a cercare il package da installare e la relativa ricetta.

Il valore di default è ``/var/spack/repos/builtin/packages/``.

Versioni diverse di spack consentono di installare software diversi.

Per controllare quale versione di un software può essere installata con una certa versione di spack, si va a controllare sul github di spack aggiungendo il nome del software al percorso del link.

Per aggiungere una versione alla ricetta, si va sulla pagina github relativa al software, dentro il file ``package.py``, si prende la riga della versione che ci interessa e la si incolla nella ricetta sul cluster, tramite comando ``spack edit``.

- ``spack list`` mostra tutti i software che possono essere installati con spack
- ``spack list <nome_software>`` mostra tutte le versioni di un software
- ``spack info <nome_software>`` mostra la ricetta di un software installato
- ``spack edit <nome_software>`` apre la ricetta in modalità modifica (con vim)
- ``spack spec -Il <nome_software>`` mostra un'anteprima di come verrà installato un programma
- ``spack find <nome_software>`` mostra tutti i software già installati con spack
- ``spack find ^^loaded`` mostra i pacchetti attualmente caricati
- ``spack diff /hash1 /hash2`` mostra le differenze tra due specifiche diverse

Simboli di spack:

- ``+`` imposta una variabile ad on
- ``-`` imposta una variabile ad off
- ``=`` definisce il valore di una variabile
- ``%`` definisce il compilatore
- ``^`` definisce la dipendenza
- ``@`` definisce la versione

Comandi ``spack find``:

- ``spack find -l`` mostra lista
- ``spack find -p <nome_software>`` mostra percorso di installazione
- ``spack find -v <nome_software>`` mostra le variabili
- ``spack find -d <nome_software>`` mostra le dipendenze

Per creare un modulo con spack:

- ``spack module tcl refresh <nome>``

File Slurm
---------

Rinnovo password
---------

Quando arriva un ticket relativo al rinnovo della password per tts, fare riferimento a Susana.

slurm.config
---------

Se c’è bisogno di controllare questo file per verificare le impostazioni di slurm sul cluster, lo si può trovare al percorso:

- ``/var/spool/slurmd/conf-cache/slurm.conf``

VASP
----

Quando un utente richiede di utilizzare VASP su un cluster, bisogna:

- chiedergli se ha una licenza VASP ed eventualmente di fornirne il numero
- chiedere a Lorenzo Varrassi di controllare che sia correttamente associato alla licenza, indicando l’email dell’utente e il numero della licenza
- se è tutto ok, seguire le istruzioni su questa pagina

Installazione da sorgente
------------------------

Quando si deve installare da file sorgente, conviene cercare le istruzioni in un qualche file README presente nella cartella.

In generale si tratta di file tar.gz o tar.bz2 che vanno estratti con comandi del tipo ``tar zxvf myapp.tar.gz`` oppure ``tar jxvf myapp.tar.bz2``.

Poi ``cd`` nella cartella creata e lanciare ``./configure`` e/o ``make`` a seconda dei casi.

Stale file handle
------------------

Quando gli utenti ci comunicano questo tipo di errore, è bene:

- controllare i nodi del job: ``sacct -j <jobid> -o nodelist%50``
- seguire le istruzioni riportate qui
- controllare i log, per esempio:
- ``sudo cat /var/log/slurm/slurm.lrdn0076.log``
- ``sudo cat /var/log/slurm/slurm.lrdn0076.log > job.log``
- vedere se c’è qualche errore esplicito agli orari indicati
- aprire ticket ai sistemisti
- rispondere poi all’utente con quello che dicono i sistemisti

Questo problema solitamente accade a causa di noti problemi puntuali della rete, che causano il temporaneo unmount del filesystem per i nodi coinvolti, risultando nell'errore osservato.

Help dei moduli
----------------

Sui cluster al percorso ``/cineca/prod/opt/helps`` si dovrebbe trovare la cartella di ogni modulo ed il file ``.help`` dove scrivere il testo proposto dall'help.

Rinomina cartelle
------------------

Quando un utente chiede di rinominare una cartella così da trasferire tutti i dati del vecchio progetto in quello nuovo, assicurarsi che:

- la cartella esista
- la cartella sia vuota
- il PI dei due progetti sia lo stesso
- quanto è il volume della vecchia cartella e quanti di questi siano occupati

Avvisare l'utente che al momento della rinomina la cartella deve essere vuota e non ci devono essere utenti che ci stanno lavorando, altrimenti i dati saranno eliminati.

Inviare poi una richiesta di questo tipo ai sys.

Conversione tra diverse espressioni delle ore
---------------------------------------------

- standard hours = core hours/FACTOR
- core hours = local hours
- node hours = core hours * num core per nodo
- core hours = node hours / num core per nodo
- node hour = GPU hour * num di GPU per nodo
- GPU hour = node hour / num di GPU per nodo
- core hours = GPU hour * num di GPU per nodo / num core per nodo
- GPU hour = core hours * num core per nodo / num di GPU per nodo

Attenzione: ci sono errori sul calcolo delle GPU/h, questa è l'unica equivalenza di cui sono sicuro:
