Guida Installazione Miniconda
========================
1) Ripulisca la propria sessione da eventuali moduli già caricati con il comando module purge; ignori tranquillamente l'errore "Unloading profile/base ERROR: Module evaluation aborted"

2) Rimuova dalla propria $HOME le modifiche apportate dall'utilizzo del modulo di Anaconda3:
- Rimuova il file $HOME/.condarc
- Rimuova la cartella $HOME/.conda
- Rimuova dal proprio bashrc ($HOME/.bashrc) tutte le righe relative al setup di Anaconda3; queste si trovano solitamente alla fine del file racchiuse tra due righe commentate "# >>> conda initialize >>>" e "# <<< conda initialize <<<"

3) Nella sua $HOME, scarichi lo script di installazione di Miniconda3 tramite il comando "curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh";; e lo esegua con il comando "bash $HOME/Miniconda3-latest-Linux-x86_64.sh"; proceda rispondendo "yes" a tutte le domande che le verranno fatte, in particolare l'ultima.

4) Terminata l'installazione ricarichi la sessione di bash eseguendo "exec bash" in modo tale che le modifiche al suo .bashrc apportate da Miniconda vengano applicate: a seguito di questo comando verrà catapultato su una nuova sessione di bash nella medesima finestra di terminale all'interno dell'envirnoment base.

5) Configuri conda in modo tale che funzioni correttamente su Leonardo:
- esegua "conda config --set auto_activate_base false"
- ricarichi nuovamente la sessione di bash con "exec bash": questo dovrebbe automaticamente disattivare anche l'environment base
- esegua "conda config --set channel_priority strict"
- esegua "conda config --add channels conda-forge"
- commenti le linee contenenti "- https://repo.anaconda.com/pkgs/main";; e "- https://repo.anaconda.com/pkgs/r";; sia nel file $HOME/.condarc che nel file $HOME/miniconda3/.condarc
Questi passaggi disabiliteranno i canali di Anaconda3 che, a causa recenti modifiche dei Terms of Service di Anaconda stesso, non è permesso utilizzare sui cluster Cineca.
