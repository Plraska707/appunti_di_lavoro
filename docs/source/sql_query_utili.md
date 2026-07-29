SQL Query utili
========================
## Stampa lista colonne:  
```
SELECT COLUMN_NAME   
FROM INFORMATION_SCHEMA.COLUMNS   
WHERE TABLE_NAME = 'nome_tabella'  
ORDER BY ORDINAL_POSITION;
```

## Query classifica dimensione tabelle relazionali:
```
select
  table_name,
  pg_size_pretty(pg_total_relation_size(quote_ident(table_name))),
  pg_total_relation_size(quote_ident(table_name))
from information_schema.tables
where table_schema = 'public'
order by 3 desc;
```

## Query dimensione dimensioni chunk hypertable:
```
SELECT * FROM chunks_detailed_size('dist_table')
  ORDER BY chunk_name, node_name;
```

## Query dimensione singola hypertable:
```
SELECT hypertable_size('slurm_jobs');
```

In unità di misura umane:
```
SELECT
  chunk_schema,
  chunk_name,
  pg_size_pretty(table_bytes)  AS table_size,
  pg_size_pretty(index_bytes)  AS index_size,
  pg_size_pretty(toast_bytes)  AS toast_size,
  pg_size_pretty(total_bytes)  AS total_size,
  node_name
FROM chunks_detailed_size('slurm_jobs')
ORDER BY chunk_name, node_name;
```

## Query dimensione di tutte le hypertable:
```
SELECT hypertable_name, hypertable_size(format('%I.%I', hypertable_schema, hypertable_name)::regclass)
  FROM timescaledb_information.hypertables;
```
 
Risultato in MB:
```
 SELECT
  hypertable_name,
  pg_size_pretty(
    hypertable_size(format('%I.%I', hypertable_schema, hypertable_name)::regclass)
  ) AS size_pretty
FROM timescaledb_information.hypertables;
```

### Query info varie hypertable:
```
SELECT * FROM timescaledb_information.chunks;
```