# How do I use VIM?
Cuando empece en VIM sin conocimientos para moverme rapidamente en el editor no lo pense mucho, dejaba presionado `j` o `k` para moverme arriba o abajo en mi archivo, `h` y `j` para moverme en la linea... con el tiempo esto se hizo demasiado molesto asi que busque alternativas, empece a buscar como moverme rapidamente en VIM... esta en mi forma actual: 

### Disclaimer
En este articulo se da por hecho de que se tiene un conocimiento minimo de VIM, entendimiento del modo `NORMAL`, `INSERT`, `VISUAL`, `V-LINE` e `(INSERT)`, la key leader, y una nocion de los 'objetos' en VIM, en caso contrario se recomienda ver la documentacion y tours de VIM con `:h`.

La distribucion de mi teclado es 'English (US)', es desde donde mas facilidad he sentido para acceder a los simbolos que utilizo con frecuencia intentando seguir las reglas de la mecanografia.

No soy un experto en este editor, me considero ignorante de la gran mayoria de cosas que lo componen, esta es solo una recopilacion de mi utilizacion actual que me a servido para ser mas productivo al desarrollar software, tengo mucho que aprender, recomiendaciones y consejos que adoptar.

## Key leader
He configurado la key leader de mi VIM para utilizarla con `<Space>` (tecla de espacio), de esta forma tengo un acceso mas facil y rapido con ambas manos al tener una posicion de mecanografia.

## Fast moving, in the file
Al abrir un archivo en VIM, utilizo `Ctrl-f` para bajar y `Ctrl-b` para subir en el archivo, avanzando y retrocediendo 'pagina entera' hasta encontrar lo que me interesa... si requiero desplazarme por un bloque de codigo cuidadosamente para visualizar a detalle lo que va sucediendo me muevo con `Ctrl-d` para bajar y `Ctrl-u` para subir 'media pagina'... si se necesita un scroll mas preciso utilizo `Ctrl-e` para bajar suavemente el scroll y `Ctrl-y` para subirlo, `zz` para centrar la pantalla con el cursor.

Una vez visualizo lo que necesito editar, paso a observar el numero de linea relativo (si, la configuracion de este repositorio utiliza lineas relativas), pulso el numero y pulso `j` o `k` dependiendo en que direccion esta la linea. Ejemplo:

 _La linea objetivo esta 17 lineas debajo de donde estoy_ : `17j`

 _La linea objetivo esta 13 lineas debajo de donde estoy_ : `13k`

_Nota mental: el punto es dejar de moverse por el archivo solo dejando presionado `j` para bajar y `k` para subir, la idea es no hacer ningun movimiento innecesario, no necesitas pasar linea por linea para subir o bajar en un archivo, no necesitas esperar que el cursor llegue al borde de la pantalla para apenas entonces empezar a hacer scroll._

#### Actions
* Ir al inicio del archivo: `gg`

* Ir al final del archivo: `G`

* Ir a una linea: `{numeroLinea}G` | ejemplo: `32G`

* Ir a un porcentaje del archivo: `{porcentaje}%` | ejemplo: `50%`

* Buscar hacia delante: `/text`

* Buscar hacia atras: `?text`

* Ir al siguiente resultado buscado: `n`

* Ir al anterior resultado buscado: `N`

* Ir al ultimo lugar donde se uso el modo `INSERT`: `'[`

* Ir al ultimo lugar donde se uso el modo `VISUAL`: `'<`

* Marcar un lugar: `m{a-zA-Z}` (ejemplo: `mk`, crea la marca `k`)

* Ir a una marca: `'{a-zA-Z}` (ejemplo: `'k`, va a la marca `k`, las marcas en mayuscula pueden ir a otros archivos)

## Fast moving, in the line
Una vez que estoy en la linea en la que necesito moverme, utilizo `f` para buscar un caracter hacia delante o `F` para buscar un caracter hacia atras del cursor. Normalmente la primera busqueda por caracter no me lleva hasta donde necesito asi que solo repito la busqueda con `;` hasta ver el cursor en donde quiero llegar, por ejemplo :

    Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                                                 ^
Si quisiera llegar a esa 'i' en esa linea pulgaria `fi;;;` rapidamente.

    Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                                                                 ^
Si quisiera llegar a esa 'i' podria pulgar `fi;;;;` o `$Fi;` (ir al final de la linea y hace una busqueda hacia la izquierda).

Si necesito repetir la busqueda pero en la direccion puedo usar `,`... por ejemplo:

    Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                    2                         1
Podria pulgar `fi;;` para ir al punto 1 y luego `,` para ir al punto 2.

De resto usar `w` para avanzar una palabra o `b` para retroceder una palabra.

#### Actions
* Inicio de la linea: `0`

* Ir al primer caracter non-blank de la linea: `^`

* Fin de la linea: `$`

* Columna del medio: `gm`

* Ir a caracter hacia la derecha: `f{caracter}` | ejemplo: `fg`, va a la 'g' hacia la derecha

* ir a caracter hacia la izquierda: `F{caracter}` | ejemplo: `Fg`, va a la 'g' hacia la izquierda

* Ir a caracter antes a la derecha: `t{caracter}` | ejemplo: `ta`, va a un caracter antes de la 'a' a la derecha

* Ir a caracter antes a la izquierda: `T{caracter}` | ejemplo: `Ta`, va a un caracter antes de la 'a' a la izquierda

* Repetir busqueda de caracter: `;`

* Repetir busqueda de caracter en la direccion opuesta: `,`

* Ir al final de la siguiente palabra: `e`

* Ir al final de la palabra anterior: `ge`

## Other common actions
Utilizo `"+` para usar el "registro" del portapapeles del sistema operativo, por ejemplo, si quiero copiar una linea al portapapeles pulso `"+yy`, o solo `"+y` para copiar lo seleccionado en modo `VISUAL`.

Utilizo `u` para retrocer un cambio, es el "`<Ctrl-z>`" de VIM. Con `U` rehaces el ultimo cambio retrocedido.

Utilizo `%` para ir hacia el opuesto del caracter en el que este el cursor (ejemplo: `()`, `{}`, `[]`), por ejemplo para ir al final de una funcion usaria `f{` para ir al `{` de apertura y luego uso `%` para ir rapidamente al `}` de cierre.

Cuando utilizo alguna un "Ir a la definicion", o en general hago un "jump" que me lleva hacia otro lado... Regreso a donde estaba anterior con `<Ctrl-o>` y vuelvo a donde estaba antes de regresar con `<Ctrl-i>`

Utilizo `.` para repetir alguna edicion que hice en modo `INSERT`.

Utilizo `~` para alternar de Uppercase a Lowercase un caracter, puede usarse en modo `VISUAL` para alternar mas de un caracter rapidamente.

Utilizo `ci"` o `ci(` para cambiar todo el contenido interno de las comillas (`""`) o parentesis (`()`) en las que me encuentro y editar, esto aplica para tambien para cualquier caracter con caracter de cierre, la `c` puede ser sustituida con un `d` para borrar o `y` para copiar... Por ejemplo `yi"`.

Utilizo `*` para buscar la palabra en donde esta el cursor hacia delante, y `#` para buscar hacia atras, sin tener que escribirla en un busqueda con `/` o `?`.

Utilizo `:r <file>` para insertar el contenido de un archivo en la posicion del cursor.

Utilizo `<Ctrl-g>` para visualizar el nombre completo del archivo actual.

Utilizo `:cc` para ir al primer error de la "quickfix list"

Utilizo `:cn` para ir al siguiente error de la "quickfix list"

Utilizo `:cp` para ir al error anterior de la "quickfix list" 

Utilizo `o` para alternar la posicion del cursos en lo resaltado en modo `VISUAL`

Utilizo `:Bo` para ejecutar un script que cierra todos los archivos del buffer y tabs, menos el archivo actual. Esto optimiza mucho el rendimiento si he abierto varios archivos.

## File navigation
Para trabajar con varios archivos uso principalmente tabs y splits, para crear un split vertical pulso `:vsplit` y `:split` para un split horizontal, entre los splits me muevo con `<Ctrl>w{direction}`, la "`direction`" es la tecla de movimiendo hacia donde esta el split... `h`, `j`, `k`, `l`.

Para moverme entre archivos utilizo el paquete `NERDTree`:

* Abrir y cerrar `NERDTree`: `<Space>n`

* Abrir `NERDTree` posicionado en el archivo actual: `<Space>m`

* Toggle Zoom en `NERDTree`: `A`

* Abrir y cerrar una carpeta en `NERDTree` estando en la carpeta: `<Enter>`

* Cerrar una carpeta en `NERDTree`: `x`

* Menu de `NERDTree`: `m`

* Actualizar arbol: `R`

* Abrir un archivo en una tab: `t`

* Abrir un archivo en una tab sin ir a ella: `T`

* Ir a la siguiente tab: `gt`

* Ir a la anterior tab: `gT`

* Abrir un archivo en split vertical: `s`

* Abrir un archivo en split horizontal: `i`

---

Para hacer una busqueda de archivo utilizo el paquete `Denite`:

* Abrir `Denite`: `<Space>f`

* Ver el buffer con `Denite`: `<Space>b`

* Buscar texto en archivos con `Denite`: `<Space>h`

En la lista de `Denite`:

* Cerrar `Denite`: `q`

* Ver preview del archivo: `p`

* Filtrar archivos: `f`

* Abrir en nueva tab: `t`

* Abrir en split: `i`

* Abrir en vsplit: `s`

* Seleccionar archivos: `<Space>`

* Borrar del buffer: `d`

#### Tricks with tabs and splits
Con `<Ctrl-w>r` puedes rotar splits.

Con `<Ctrl-w>{H,J,K,L}` puedes mover un split.

Con `<Ctrl-w>=` haces que todos los splits tengan el mismo tamaño.

Con `<Ctrl-w>-` puedes decrementar el alto del split, con `<Ctrl-w>+` puedes incrementar el alto del split.

Con `<Ctrl-w><` puedes decrementar ancho del split, con `<Ctrl-w>>` puedes incrementar el ancho del split.

Con `<Ctrl-w>_` puedes darle todo el alto al split, con `<Ctrl-w>|` puedes darle todo el ancho al split.

Con `20<Ctrl-w>_` puedes darle 20 de alto al split.
Con `20<Ctrl-w>|` puedes darle 20 de ancho al split.

Con `:tabm 2` puedes mover la tab a la posicion 3.

## Replace text
En VIM utilizamos `:s` para reemplazar texto, este comando acepta expresiones regulares.

La sintaxis basica seria : `:{range}s/text/other/{options}`

Por ejemplo... con `:s/hello/world` reemplazaria la primera coincidencia de "`hello`" con "`world`" en la linea.

Si quisiera cambiar todas la coincidencia de la linea utilizaria a `option` "`g`", por ejemplo... `:s/hello/world`, asi reemplazaria todas las coincidencias de "`hello`" con "`world`" en la linea.

Para ejecutar estos reemplazos en todo el archivo se utilizaria el `range` "`%`" y la `option` "`g`", por ejemplo... `:%s/hello/world/g`.

Para repetir un reemplazo pero con un distinto rango y opciones... basta con ponerlo sin la sentencia de busqueda ni la sentencia de reemplazo, por ejemplo: `:%sgc`, eso repetiria el ultimo reemplazo que hice pero en todo el archivo y confirmando cada cambio.

Hay mas `options` y `ranges` con los que se puede jugar de manera muy interesante... dejare algunas combinaciones frecuentes que uso.

#### Common replacement combinations

* Reemplazar todas las coincidencias pero confirmando cada cambio: `option: gc` | ejemplo: `:%s/text/other/gc`

* Reemplazar usando un rango de lineas absolutas: `:{line},{line}s/text/other/g` | ejemplo: `:15,20s/text/other/g`

* Reemplazar usando un rango de lineas relativas a la actual: `:.,.{+/-}{lines}s/text/other/g` | ejemplo: `:.,.+3s/text/other/g`

* Repetir el ultimo reemplazo pero sin las opciones: `&` o `:s`

* Repetir el ultimo reemplazo pero con opciones: `:s{options}` | ejemplo: `:sgc`

* Repetir el ultimo reemplazo en todo el archivo pero con opciones: `:%s{options}` | ejemplo: `:%sgc`

## Macros
Las macros en VIM son un superpoder fantanstico que no se aprovechar del todo pero en algun momento le he sacado algo de provecho.

En VIM la cosa va de repeticiones, y las macro son un metodo de hacerlo a gran escala, con el `.` podemos repetir el ultimo realizado en modo `INSERT`... pero aveces necesitamos mas que eso. Primero recordemos como grabajar y ejecutar macros:

Empezamos a grabar una macro en algun registro con `q{a-z}`... por ejemplo: `qq`, una vez realizamos las acciones que queramos repetir detenemos la "grabacion" pulsando `q` de nuevo.

Podemos ejecutar nuestra macro con `@{a-z}`... por ejemplo: `@q`.

Y con `@@` podemos ejecutar rapidamente la ultima macro ejecutada!

#### Small example of use
Pasando de esto:

    Lorem Ipsum is simply dummy text of the printing
    Lorem Ipsum has been the industry's
    It was popularised in the 1960s
    Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical
    majority have suffered alteration in some form, by
    like readable English. Many desktop
    This book is a treatise on the theory of ethics, very popular during the Renaissance
    All the Lorem Ipsum generators on the Internet tend
    The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested
    like readable English. Many desktop
    This book is a treatise on the theory of ethics, very popular during the Renaissance
    All the Lorem Ipsum generators on the Internet tend
    Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical

A esto, usando macros:

    "Lorem" : "Ipsum is simply dummy text of the printing",
    "Lorem" : "Ipsum has been the industry's",
    "It" : "was popularised in the 1960s",
    "Contrary" : "to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical",
    "majority" : "have suffered alteration in some form, by",
    "like" : "readable English. Many desktop",
    "This" : "book is a treatise on the theory of ethics, very popular during the Renaissance",
    "All" : "the Lorem Ipsum generators on the Internet tend",
    "The" : "standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested",
    "like" : "readable English. Many desktop",
    "This" : "book is a treatise on the theory of ethics, very popular during the Renaissance",
    "All" : "the Lorem Ipsum generators on the Internet tend",
    "Contrary" : "to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical",

Macro usada: `qqI"<Esc>f<Space>i"<Space>:<Esc>la"<Esc>A"<Esc>jq` (recuerde que en mi configuracion el `<Esc>` puede realizarse presionando `jk` o `kj`)

Basicamente fue... empezar a grabar la macro, hacer la modificacion deseada lo mas repetible posible en donde sea que se ejecute, y finalizar moviendose hacia algun lugar para solo ejecutar la macro una vez y luego seguir ejecutando con `@@` (o el numero de veces que quieres repetir la ultima macro, por ejemplo... `12@@`)

Las macros son increiblemente utilices pero complicadas de "pensar" al inicio, pueden usarse para cualquier accion repetitiva, este ejemplo que utilice fue un caso util al momento de usar JSON (por ejemplo), imagina que en vez de ser solo 12 lineas que debes modificar de esa manera, son 30 o mas, aun siendo 'veloz' en VIM o 'pecar' usando el mouse tomaria mucho mas tiempo que hacer una macro.

## Records
Puedes usar registros en VIM usando `"` y el nombre del registro, por ejemplo `"j` accede al registro `j`, de esta manera puedes guardar texto como si tuvieras muchos portapapeles, por ejemplo... `"jyy` copia una linea al registro `j` y con `"jp` pegarias el contenido del registro `j`, en modo `INSERT` puedes pulgar `<Ctrl-r>{record}` para insertar el contenido de un registro directamente, por ejemplo... en modo `INSERT` : `<Ctrl-r>j` insertaria el registro `j` en donde estemos. (El registro del portapapeles del sistema operativo es `+`)

Podemos asignar un registro con cualquier letra desde a-zA-Z, en VIM hay registros especiales como el `=` el cual nos permite hacer operaciones matematicas, podemos usarlo con `<Ctrl-r>` mientras estamos en modo `INSERT`.

Por ejemplo, podriamos estar escribiendo y pulgar `<Ctrl-r>=10+25<Enter>` y se insertaria el resultado, podemos tambien jugar con las variables y otros registros, por ejemplo... 
En modo `NORMAL`: `:let i=10<Enter>`, con eso creamos una variable `i` con valor `10`, y en modo `INSERT` podriamos pulgar `<Ctrl-r>=i+15<Enter>`.

Se pueden hacer muchas cosas productivas con esto y Macros.

## Indent lines
Programando suelo necesitar indentar lineas, en VIM puedo hacerlo con `<<` y `>>` para cada direccion, tambien puede usarse en modo `VISUAL` para aplicar a varias lineas.

Se puede recurrir al indentado automatico por defecto que VIM considere correcto con `=`, puede usarse en un `range` y en modo `VISUAL`, por ejemplo... `gg=G` indentaria todo el archivo.

## Suspender VIM
Con `<Ctrl-z>` puedes suspender el estado actual de VIM y volver a la terminal, esto lo dejara como proceso de background... al igual que con otros procesos en background puedes volver a el ejecutando `%` en la terminal

---

# Programming in VIM
Mi lenguaje de programacion principal es Golang, esta configuracion esta adaptada para ese lenguaje de programacion.
El autocompletado y la integracion con LSP (Language Server Protocol) la realizo con [coc.nvim](https://github.com/neoclide/coc.nvim), las extensiones que utilizo actualmente son :

* `coc-omni`
* `coc-html`
* `coc-css`
* `coc-emmet`
* `coc-json`
* `coc-highlight`
* `coc-syntax`
* `coc-tag`
* `coc-tsserver`
* `coc-prettier`
* `coc-eslint`
* `coc-protobuf`

El unico LSP que integro es el de Golang, `gopls` en el `coc-settings.json` (accesible mediante `:CocConfig`) :

```json
{
    "languageserver": {
        "golang": {
            "command": "gopls",
            "rootPatterns": ["go.mod", ".vim/", ".git/", ".hg/"],
            "filetypes": ["go"],
            "initializationOptions": {
                "usePlaceholders": true,
                "static_check": true
            }
        }
    },
}
```

Con esta configuracion puedo trabajar con Golang, JavaScript + TypeScript + React con `ESLint` y `Prettier`, HTML + CSS con Emmet y SASS.

Utilizo el paquete `vim-go` para integracion con las herramientas de Golang como el autoimportado y autoindentado, entre las otras herramientas oficiales de Golang.

El `gopls` esta configurado con el `usePlaceholders` en `true`, al autocompletar funciones apareceran los parametros con el tipo de dato, se puede editar el primer parametro directamente al autocompletar la funcion, y con `<Ctrl>j` y `<Ctrl>k` puedes moverte entre los parametros a escribir.

## Common actions

* Comentar toggle linea o lineas: `<leader>c<leader>`
* Comentar en bloque: `<leader>cs`
* Descomentar: `<leader>cu`

* Ir a definicion: `<leader>gd`
* Ir a las llamadas de la funcion: `<leader>gc`
* Ir a la definicion del tipo: `<leader>gt`
* Ir a las implementaciones de una interface: `<leader>gi`
* Refactorizar nombre: `<leader>rn` | `:GoRename`
* Ver documentacion: `K`

* Regresar un `jump`: `<Ctrl-o>`
* Avanzar al `jump`: `<Ctrl-i>`

* Siguiente error de la quicklist: `]c` | `:cn`
* Anterior error de la quicklist: `[c` | `:cp`

* Agregar `tags` a una estructura: `<leader>gat`
* Eliminar `tags` de una estructura: `<leader>grt`

* Mostrar Coverage del codigo: `:GoCoverageToggle`

* Llamar a `:GoBuild`: `<leader>gj`
* Llamar a `golint`: `<leader>gl`
* Llamar a `govet`: `<leader>gk`

* Llamar a Emmet: `<Ctrl-k>`

* Buscar archivo: `<leader>f`
* Buscar archivo en buffer: `<leader>b`
* Buscar texto en archivos: `<leader>h`

* Ir al extremo opuesto de comillas, parentesis, llaves, corchetes, etc...: `%`

* Cerrar todos los archivos en buffer y tabs menos el actual: `:Bo`

* Actualizar contenido del archivo actual: `:e`

* Alternar numeros de line relativas: `:set relativenumber!`

* Cambiar a modo LightMode: `:LightMode`
* Cambiar a modo DarkMode: `:DarkMode`

## vim-surround
Esta configuracion incluye [vim-surround](https://github.com/tpope/vim-surround), para la utilizacion del mismo recomiendo leer su [README.markdown](https://github.com/tpope/vim-surround/blob/master/README.markdown) ya que explica todo lo fundamental

## coc-emoji
En un archivo Markdown (.md) puedes acceder al autocompletado de emojis con `:` en modo INSERT

## LightMode
Soy un Digital Nomad, y entre muchas de las situaciones en las que he programado aveces he tenido el problema de que la luz natural opaque mucho mi editor mientras estoy desarrollando lo cual es bastante molesto, he encontrado una solucion en los temas "light" para estas situaciones... cuando la luz del dia no te permita ver bien tu editor un tema light podria ayudar, claro... cuando no programo fuera de casa o en un entorno con tanta luz solar uso los temas "dark" a los cuales se esta mas acostumbrado.

Enciende el tema "light" de esta configuracion con `:LightMode` o vuelve al "dark" con `:DarkMode`.

Un `:li<tab>` podria ser suficiente para autocompletar a `:LightMode`, y `:da<tab>` para autocompletar a `:DarkMode`.

Usando la configuracion de `.zshrc` se carga la variable de entorno `$MODE` para setear el tema del Vim desde la terminal, con el alias `lightmode` / `darkmode` o `li` / `da`
