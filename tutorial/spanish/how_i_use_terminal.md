# How do I use Terminal?

Desarrollo y trabajo utilizando 100% la terminal de Linux (menos el Navegador Web), editor de codigo, bases de datos, monitorizacion de sistema.

La GUI de terminal que utilizo es indiferente a mi flujo de trabajo, suelo usar la [Alacritty](https://github.com/alacritty/alacritty) porque tiene aceleracion por GPU y se me hizo mas facil de transportar su configuracion, mi flujo de trabajo se divide en :

-   Terminal GUI: [`alacritty`](https://github.com/alacritty/alacritty)
    -   Nerd fond: ["FiraCode"](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
-   Shell: `zsh`
-   Terminal Multiplexor: `tmux`
-   Code editor: `nvim` (NeoVim)
-   Music player: `cmus`

Para aumentar la velocidad de movimiento en Vim seteo el delay y repeat rate para el servidor grafico con:

```sh
xset r rate 200 30
# to make it permanent, write in ~/.zshrc (backup first for safety)
```

Al encender mi maquina, abro la terminal, voy a la carpeta de mi proyecto, ejecuto `tmux` y presiono `F11` para trabajar con la terminal en pantalla completa.

## Zsh

Utilizo `zsh` como Shell en reemplazo a `bash`, por el autocompletado y plugins visuales con `Oh My Zsh!`.

## Tmux

Utilizo `tmux` para multiplexar mi terminal con varios splits y paneles, he cambiado la `"Key leader"` a `<Ctrl>a` en reemplazo a `<Ctrl>b`.

-   Crear split horizontal: `<Ctrl>a%`

-   Crear split vertical: `<Ctrl>a"`

-   Hacer toggle zoom de un split: `<Ctrl>az`

-   Crear nuevo panel: `<Ctrl>ac`

-   Ir al siguiente panel: `<Ctrl>an`

-   Ir al panel anterior: `<Ctrl>ap`

-   Moverte entre splits (con movimientos de Vim): `<Ctrl>a{h, j, k, l}` | ejemplo: `<Ctrl>al`

-   Redimensionar split (con movimientos de Vim): `<Ctrl>a{H, J, K, L}` | ejemplo: `<Ctrl>aL`

-   Guardar entorno: `<Ctrl>a <Ctrl>s`

-   Restaurar entorno: `<Ctrl>a <Ctrl>r`

-   Modo de movimiento Vi: `<Ctrl>a[`

-   Renombrar panel: `<Ctrl>a,`

Se puede redimensionar splits con el mouse, arrastrando las lineas separadoras.

Al seleccionar texto con el mouse y dejarlo presionado, se puede presionar `y` para copiar lo seleccionado.

## Common commands/actions

-   Copiar path actual al portapapeles: `pwd | xclip -selection clipboard`

-   Abrir archivo o carpeta con su programa por defecto: `gio open <PATH/NAME>`

-   Buscador de comandos: `<Ctrl>r`

-   "Flecha arriba": `<Ctrl>p`

-   "Flecha abajo": `<Ctrl>n`

-   Ir al inicio de la linea: `<Ctrl>a <Ctrl>a` (Doble, por usar Tmux)

-   Ir al final de la linea: `<Ctrl>e`

-   Borrar desde el cursor hasta el inicio de la linea: `<Ctrl>u`

-   Borrar desde el cursor hasta el final de la linea: `<Ctrl>k`

-   Borrar palabra antes del cursor: `<Ctrl>w`

-   Borrar palabra siguiente del cursor: `<Alt>d`

-   Ir a siguiente palabra: `<Alt>f`

-   Ir a palabra anterior: `<Alt>b`

-   Suspender proceso, ponerlo en background: `<Ctrl>z`

-   Recuperar proceso en background: `fg` | `%`

-   Ver procesos en background: `jobs`

## LightMode

Como explique al final de [el tutorial de mi Vim](./how_i_use_vim.md), al programar en otras situaciones y lugares con distinta iluminacion... me hizo encontrarle un uso a los themes light, sobre todo cuando hay luz solar, acceso a la configuracion de la Terminal GUI que utilizo... por el momento es [`alacritty`](https://github.com/alacritty/alacritty):

`~/.config/alacritty/alacritty.yml`

Tambien cambio los colores del Tmux con los comandos `lightmode` / `darkmode` o `li` / `da`
