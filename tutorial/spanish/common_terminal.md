# Common personal terminal commands

### Search or replacement

Cambiar permiso a todos los archivos desde un lugar :

```sh
find . -type f -exec chmod 644 {} \;
```

Cambiar texto en todos los archivos desde un lugar:

```sh
find . -type f -exec sed -i 's/text/other/g' {} \;
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

Copiar el path actual al portapapeles:

```sh
pwd | xclip - selection clipboard:
# alias "cpath"
```

Actual totalmente el sistema:

```sh
sudo apt -y update && sudo apt -y upgrade && sudo apt -y dist-upgrade && sudo apt -y full-upgrade && sudo snap refresh && sudo apt autoremove && sudo apt autoclean
# alias "updateall"
```

Limpiar swap:

```sh
sudo su -c "sync; echo 3 > /proc/sys/vm/drop_caches ; swapoff -a && swapon -a"
# alias "cacheclear"
```

Limpiar cache de DNS:

```sh
sudo systemd-resolve --flush-caches
# alias "flushdns"
```

Calcular fechas:

```sh
date -d "13 Sep 2021 + 180 days"
```
