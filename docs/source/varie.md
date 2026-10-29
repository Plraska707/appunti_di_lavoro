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