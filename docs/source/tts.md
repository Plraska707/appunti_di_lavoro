# TS

## RT5 - Ricezione e Invio email

### README.md
Il README.md è presente al percorso:  
/root/ms365-application-permissions/README.md

### Impostazioni

**RT_SiteConfig.pm**

nel file /mnt/workdir/request-tracker/rt5/etc/RT_SiteConfig.pm viene impostata la variabie **SendMailPath**:
```
Set(\$SendmailPath, \'/usr/local/bin/sendmail-msmtp\');
```
dove  
**/usr/local/bin/sendmail-msmtp**  
è il wrapper di msmtp, con permessi 0755, che al suo interno richiama il programma  
**/usr/bin/msmtp**:
```
#!/bin/sh
exec /usr/bin/msmtp "$@"
```

msmtp usa come file di configuraione **/etc/msmtprc**
<details>
<summary>msmtprc</summary>
<br>

defaults

auth            on
tls             on
tls_starttls    on
timeout         60

tls_trust_file  /etc/ssl/certs/ca-certificates.crt

logfile         /var/log/msmtp.log

account m365

host smtp.office365.com
port 587

from tts-micro-devel@cineca.it
user tts-micro-devel@cineca.it

auth xoauth2

passwordeval "/usr/local/bin/get-ms365-token.py"

account default : m365

</details>


per il quale vanno impostati i permessi 0600 e proprietario root:root, mentre per il file di log indicato al suo interno (**/var/log/msmtp.log**) vanno impostati i permessi 0640 e proprietario root:root

**Password evaluation:**  
dentro msmtprc viene indicato  
**/usr/local/bin/get-ms365-token.py**  
per la verifica della password (o token).  
Questo script ha permessi 0755 usa il file di configurazione **/etc/rt/ms365.json**

### Crontab

In crontab va aggiunta la seguente riga per trasferire le email arrivate
alla casella **tts-micro-devel@cineca.it** a RT: :

    */2 * * * * /usr/local/bin/wsgetmail --config /mnt/workdir/request-tracker/rt5/etc/wsgetmail.json


### File e permessi

| File                          | Permessi | Proprietario |
|-------------------------------|----------|--------------|
| /usr/local/bin/sendmail-msmtp | 0755     |              |
| /etc/msmtprc                  | 0600     | root:root    |
| /var/log/msmtp.log            | 0640     | root:root    |