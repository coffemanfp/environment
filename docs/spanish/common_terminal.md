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
grep -r -I -l \
	--exclude-dir="node_modules" \
	--exclude-dir="vendor" \
	--exclude-dir="dist" \
	--exclude-dir="testdata" \
	--exclude-dir=".git" \
	--exclude-dir=".github" \
	--exclude="package.json" \
	--exclude="package-lock.json" \
	--exclude="*.svg" \
	--exclude="*.map" \
	--exclude="*.sum" . \
	--exclude="*.lock" . \
	--exclude="*.log" . \
	--exclude="LICENSE" . \
	--exclude=".gitignore" . \
	| xargs wc -l
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

Obtener tu IP Publica:

```sh
curl -s ipinfo.io/ip
# alias "publicip"
```

Obtener la geolocalizacion de una IP Publica:

```sh
curl ipinfo.io/{PublicIP}
# example: curl ipinfo.io/1.0.0.1
```

Geolocalizar tu IP Publica:

```sh
curl ipinfo.io/"$(curl -s ipinfo.io/ip)"
# alias "geoip"
```

Crear un archivo pesado:
```sh
fallocate -l 2G big_file.txt

# or (takes a little longer)
dd if=/dev/zero bs=4k iflag=fullblock,count_bytes count=2G of=./big_file.txt

# or (without actually using up disk space)
truncate -s 2G big_file.txt
```
