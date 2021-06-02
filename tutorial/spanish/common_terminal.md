# Common personal terminal commands

### Search or replacement
Cambiar permiso a todos los archivos desde un lugar :
```sh
find . -type f -exec chmod 644 {} \;
```

Cambiar texto en todos los archivos desde un lugar:
```sh
find . -type f -exec sed -i 's/text/other/g' {} \
```

Buscar texto en todos los archivos desde un lugar:
```sh
grep -rni 'text' .
```

### Monitoring / System administration
Ver todos los archivos abiertos por un proceso:
```sh
lsof -c <processName>
# or
lsof -p <PID>
```

Ejecutar un comando cada 1 segundo (`-n 1`) resaltando diferencias (`-d`):
```sh
watch -n 1 -d "<command>"
```

### Others
Contar todas las linea de un proyecto (considerar excluir binarios y carpetas de dependencias como `node_modules/`):
```sh
find | xargs cat 2>/dev/null | wc -l
```
