Comandi Docker e Postgres
========================
## Docker
**avvia shell all'interno del docker**  
docker exec -it <nome_docker> /bin/bash

**costruzione docker**  
sudo docker compose up -d  

**visualizzare log docker**  
sudo docker logs --tail=100 -f <nome_docker>  

**visualizza container attivi**  
sudo docker ps

**visualizza tutti i container**  
sudo docker ps -a

**Fermare più container con nomi simili:**  
docker stop $(docker container ls -q --filter name=prod-dp*)

## Postgres
**accesso al container di airflow:**  
docker exec -it dev310-airflow-apiserver-1 /bin/bash

**accesso al DB una volta entrati nel container:**  
psql -d "postgres://admin:password@localhost:5433/postgres"  

**vedere tutti i DB:**  
\l

**per vedere le dimensioni di un db (o di tutti):**  
\l+ <nome_db>

**accedere ad un DB:**  
\c <nome_db>

**lista delle tabelle del db:**  
\dt

**database schema:**  
\dn

**uscire:**  
\q

### Postgres su PDL

**DB relazionale:**  
docker exec -it postgres_db psql -U appuser -d appdb

**DB timeseries:**  
docker exec -it timescaledb psql -U appuser -d appdb