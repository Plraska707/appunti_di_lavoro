Varie ed eventuali
========================

Comando per trovare tutte le cartelle vuote:
```
find . -type d -empty -print [-delete]
```

Comando per eliminare tutti i file con un certo pattern, escluse le sottocartelle, esclusi i file indicati: 
```
find . -maxdepth 1 -type f -name 'dcgp*' ! -name 'dcgp-env-20261016T1510.csv' -print [-delete]
```

Comando per cercare i file non vuoti, con pattern, in ordine temporale
```
find -maxdepth 1 -type f -name 'boost*' -size +0 -print | sort -n
```

## Collegarsi ai DB


| DB        | IP             |
| --------- | -------------- |
|database_0 | 192.168.253.77 |
|database_1 | 192.168.253.69 |
|database_2 | 192.168.253.72 |

- Accesso a graphs con utente graphs:  
psql -h 192.168.253.77 -U graphs -d graphs

Accesso a graphs con utente airflow:  
- psql -h 192.168.253.77 -U airflow -d graphs

- Accesso a test_db con utente airflow:  
psql -h 192.168.253.77 -p 5433 -U airflow -d testdb  

password in graphs_db.yml

- Accesso a service_db:  
psql -h 192.168.253.77 -p 5434 -U airflow -d airflow  

password in service_db.yml 

Comando per vedere le password:
```
ansible-vault edit playbooks/vars/service_db.yml --vault-password-file playbooks/password.txt
```