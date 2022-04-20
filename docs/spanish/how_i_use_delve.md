# How I use Delve

Utilizo [Delve](https://github.com/go-delve/delve) como herramienta de depuracion al desarrollar en [Golang](https://go.dev/).

Instalacion:
```sh
go install github.com/go-delve/delve/cmd/dlv@latest
```

### Iniciar sesion de depuracion

```sh
dlv debug
```

### Iniciar sesion de depuracion en un proceso en ejecusion

```sh
dlv attach <PID>
```

### Iniciar sesion de depuracion en archivos de testing

```sh
dlv test
```

### Saber donde te encuentras

```sh
list
# alias: ls
```

### Ver un statement especifico

```sh
list main.main

# or
list ./main.go:10
```

### Crear un breakpoint

```sh
break main.main
# alias: b

# or specific line
break ./main.go:20

# or relative line based on a statement
break main.main:2

# or when you are already in a statement you can specify the line in the file
break 13
```

Solo puedes crear breakpoints en lineas del statement.

No puedes crear un breakpoint si:

* Es a una linea vacia
* Solo es una linea de cierre de estructura, por ejemplo `}`
* Es una linea de una funcion/metodo/statement que no forma parte de la ruta de ejecusion principal. (No puede llegarse a esa linea)

### Saber los breakpoints existentes

```sh
breakpoints
# alias: bp
```

### Limpiar un breakpoint

```sh
clear 1
```

### Limpiar todos los breakpoints

```sh
clearall
```

### Avanzar al siguiente breakpoint

```sh
continue
# alias: c
```

### Avanzar una linea en el breakpoint actual

```sh
next
# alias: n
```

### Ingresar a la ejecusion de una funcion en la linea actual

```sh
step
# alias: s
```

Puede usarse como `next`

### Salir de la ejecusion de una funcion

```sh
stepout
# alias: so
```

### Reiniciar la sesion de depuracion sin perder los breakpoints creados

```sh
restart
# alias: r
```

### Imprimir un valor

```sh
print
```

### Imprimir todas las variables locales

```sh
locals
```

### Examina el valor raw de una direccion de memoria

```sh
examinemem 0xc00007de28
# alias: x
```

### Establecer el valor a una variable

```sh
set x = 11
```

### Imprimir el tipo de datos de una variable

```sh
whatis x
```

### Ver el Assembly de la linea actual

```sh
disassemble
# alias: disass
```

## Operaciones entre Goroutines y Threads

### Ver las goroutines actuales

```
goroutines
# alias: grs
```

### Cambiarse a una goroutine en especifico

```
goroutine 6
# alias: gr
```

### Ver los threads actuales

```
threads
```

### Cambiarse a un thread en especifico

```
thread 6
# alias: tr
```
