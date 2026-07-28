Comandi cluster  
========================
# Comandi generali

- squeue - view information about jobs located in the Slurm scheduling queue.	
- sinfo - View information about Slurm nodes and partitions. 	
- sacct - displays accounting data for all jobs and job steps in the Slurm job accounting log or Slurm database	
- scontrol - view or modify Slurm configuration and state.	
- sacctmgr - Used to view and modify Slurm account information. 

sacct -e JobID,JobName,Partition,Account,AllocCPUS,State,ExitCode

# Saldo
- saldo -b	mostra lo stato nel proprio account  
- saldo -bu <username>	mostra lo stato dell’utente  
- saldo -bc mostra il saldo con le ore convertite da local a std
- saldo -ba <account>	mostra le info dell’account  
- saldo -ra <account>	info giorno per giorno delle risorse consumate da ogni   utente su ogni account  

# Sacct	
- sacct  
info sui propri job del giorno
- sacct -u <nome utente>  
info sui job del giorno dell’utente
- sacct -A <nome account> -Xa -S <YYYY-MM-DD> --format=jobid,account%20,user,start,end,alloccpus,nnodes	
- sacct -e  
mostra le possibili flag per il format
- sacct -XN <nome_nodo1>,<nome_nodo2>,…  
verifica stato nodi
- sacct -Xu <username> -S 2023-04-01 -E 2023-05-01 --format=jobid,state,submit,start,end,elapsed,elapsedraw > job_list.txt  
salva nel file "job_list.txt" la lista dei job sottomessi dall'utente con quelle caratteristiche
- sacct -j <num_job> -o jobid,jobname,state,exitcode,derivedexitcode,Flags,NNodes,NodeList,partition,nnodes,ncpus,ntask  
info sul job indicato  
- sacct -Xu dpassiat -S 2025-07-01 -o jobid,jobname,CPUTimeRAW | grep prometeo | awk '{ sum += $3 } END { print sum }'  
estrazione e somma dei valori della colonna 3
- sacct -j <jobid> -o submitline%100  
in caso di job interattivi lanciati con srun e che non hanno uno sbatch

# Sacctmgr 
- sacctmgr show qos6/29/26 <nome_qos> (il nome è opzionale)  
mostra tutte le info sulla qos indicata
- sacctmgr show user <nome_utente> -P  
mostra l'account di default di un utente
- sacctmgr show qos format=Name%19,MaxJobs,MaxSubmitJobs,MaxTRESPU%50  
mostra le informazioni richieste riguardo la qos indicata
- sacctmgr show assoc where account=EUHPC_E01_022 format=cluster,account%15,user,qos%100
- sacctmgr show assoc where user=pdamico0 format=cluster,account%15,user,qos%100
- sacctmgr show qos g100_qos_eiri2 format=Name%14,Flags%50,MaxTRES,MaxTRESPU%50,GrpTRES%50,MaxWall
- sacctmgr show account EIRI_E_POLITO withassoc format=qos%100  
mostra a quali qos è associato un dato progetto (in questo caso EIRI_E_POLITO)


# Sinfo
Mostra tutte le partizioni disponibili:  
- sinfo -o %P  

lista nodi situazione attuale (num tot nodi, num nodi in ogni stato, partizione)
- sinfo -o "%10D %20F %P"  

# Scontrol
- scontrol show job 15046810  
informazioni dettagliate su un job NON completato
- scontrol show reservation  
per controllare le reservation attive  
- scontrol show partition <nome>
mostra i dettagli di una partizione

# Sprio
lista dei job in ordine di priorità  
- sprio -l | sort -n -k4  
 
lista job in ordine di priorità (il più alto in cima)
- sprio -l -S -y  
 
lista job in ordine di priorità (il più alto in fondo)
- sprio -l -S +y

# Cindata
- cindata	mostra le proprie risorse occupate
- cindata -u <username>	mostra le risorse occupate da un utente

# Comandi SLURM

- sinfo -R -O timestamp,nodelist:50,reason:100  
lista nodi attualmente non disponibili
- sinfo -o "%10D %20F %P"  
lista nodi situazione attuale (num tot nodi, num nodi in ogni stato, partizione)
- squeue -u `<nome_utente>`  
mostra i job in coda per l’utente indicato
- scontrol show job `<jobid>`  
mostra I dettagli del job indicato: job in esecuzione
- sacct -Xna .... > <nome_file>`  
salva come file il risultato di una ricerca fatta in qualsiasi modo
- sprio -p `<partizione>` --long --sort="-y" | egrep --color=always '`<nome_utente>`$' | less -R  
lista di tutti i job di una partizione in ordine di priorità con evidenziati i job di un utente
- scontrol update job `<jobid>` nice=-100000  
aumentare la priorità del job e farlo girare subito
- sacct -Bj `<jobid>`  
vedere il file sbatch del job
	
/etc/grid-security/cineca/grid-mapfile	file dove controllare i certificati degli utenti

# Gestione cartelle	
**!!!CARICARE MODULO SUPERC!!!**
### G100 e Pitagora (hpcsupport) 
Su questi cluster non abbiamo i permessi sudo e dobbiamo quindi usare una virtual machine.  

Da G100 si accede all vm
con 
ssh hpcsupport01  

Su Pitagora con
ssh hpcsupport  

Poi i comandi vanno lanciati con "sudo" davanti  
- sudo ls /percorso_cartella/  
si accede alla cartella
- sudo ls -l /percorso_cartella/  
visualizza contenuto cartella
- sudo cat /percorso_file/  
mostra contenuto file

### Leonardo (sup01/sup02)``
- sudo -u `<user>` ls `<dest>`    

## Copia cartelle
### G100  e Pitagora (hpcsupport) 
- sudo cat `<src>` > `<dest>`  
copia file
- catcopy.sh `<src> <dest>`  
copia intera cartella
- supercopy `<src> <dest>`  
per le directory aggiungere -r o --recursive
- supercopy --sudocat  `<src> <dest>`  
per le directory aggiungere -r o --recursive

### Leonardo (hpcsupport)
- supercopy -u `<user>` --sudocat `<src> <dest>`  
per le directory aggiungere -r o --recursive

### scp
- `scp amarcell@login.g100.cineca.it:<src> <dest>`  
copiare file da cluster (-r per le cartelle intere)
- `scp <src> amarcell@login.g100.cineca.it:/g100/home/userinternal/amarcell`  
copiare file dal mio pc alla cartella nel cluster (-r per copiare cartelle)
	
# Controllare attività nodo
- Accedere al cluster
- ssh <nodo>
- htop

## Accedere ad un nodo su Marconi:
- ssh `<nodo>`-hfi	

# Modificare una qos	
Accedere ad una delle VM  
impersonare cinprod  
lanciare il comando per la modifica desiderata

- sup01  
- sudo -i -u cinprod  
- sacctmgr modify qos qos_slowprio set MaxTRES=node=256 MaxTRESPU=node=256 MaxWall=12:00:00

# Finger - whois
se finger non va si può usare la sua nuova alternativa: **whois**
Per lanciarlo:
- ml superc
- whois <Nome e/o Cognome> --cache
- whois <Nome e/o Cognome>

la prima volta che viene lanciato, il comando non funziona. Poi la cache si popola e viene trovato l'utente (a volte è necessario lanciarlo due volte).

# Varie
- modmap -m `<nome software>	`  
mostra i software con quel nome
- finger `<nome o cognome>`  
- whois <nome o cognome> --cache  
cerca persona
- lastlog -u `<nome utente>`  
mostra I dettagli del login
- chprj -l  
mostra la lista di tutti gli account associati
- chprj -d `<nome_account>`  
cambia l’account di riferimento e di conseguenza la $WORK
- cindata -U -a /scr/ -f 2  
verifica utilizzo scratch da parte degli utenti
- grep -Rnw '/path/to/somewhere/' -e 'pattern'  
trovare file contente una determinata stringa a partire da un certo percorso
- sudo -u `<username>` cat ~`<username>`/.bash_history | less  
cerca tra la history di un utente  
- sacctmgr show user <`utente`>withassoc  
mostra tutto ciò a cui è associato un utente sul cluster

# Accesso nodo
Quando ci sono errori e bisgona vedere i log dei nodi:  

- controllare i nodi del job: sacct -j <jobid> -o nodelist%50
- seguire le istruzioni riportate qui: [link](https://wiki.u-gov.it/confluence/display/SCAIUS/FAQ#FAQ-CanIloginwithsshinsideacomputenode?)
(il nome del nodo deve iniziare con lrdn)
- controllare i log, e.g.:
    - sudo cat /var/log/slurm/slurm.lrdn0076.log | grep <num_job> (per vedere il file log)
    - sudo cat /var/log/slurm/slurm.lrdn0076.log > job.log (per salvare il file log)
