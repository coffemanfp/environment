
set nocompatible              " be iMproved, required

filetype off                  " required
set backspace=2

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"--------------------------
" Tecla lider remapeada : ,
let mapleader=","
let maplocalleader="\\"
"--------------------------

" - - - ArthurNavaH - Plugins -

" NERDTree - Explorador de Archivos
Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'


nnoremap <leader>j :NERDTreeToggle<CR>
nnoremap <leader>g :NERDTreeFind<CR>

let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=1
let NERDTreeMouseMode=2
let NERDTreeIgnore=[ '^\.git$' ]
let NERDTreeAutoDeleteBuffer = 1

"------------------
"------------------
"------------------


" FZF - Buscador de Archivos
Plugin 'junegunn/fzf'

nnoremap <leader>f :FZF<CR>

"------------------
"------------------
"------------------


" Airline - Barra de Estado
Plugin 'bling/vim-airline'

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='hybrid'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

"------------------
"------------------
"------------------


" Syntastic - Aumento de Sintaxis
Plugin 'scrooloose/syntastic'

"------------------
"------------------
"------------------


" VIM-JSON - Mejor soporte para JSON
Plugin 'elzr/vim-json'

let g:vim_json_syntax_conceal = 2

"------------------
"------------------
"------------------


" VIM-TYPESCRIPT - Mejor soporte para TypeScript
Plugin 'leafgarland/typescript-vim'

"------------------
"------------------
"------------------


" VIM-GO - Mejor soporte para Go
Plugin 'fatih/vim-go'

let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_deadline = "5s"
let g:go_auto_sameids = 1
let g:go_list_type = "quickfix"

let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

let g:go_version_warning = 0

"------------------
"------------------
"------------------


" VIM-JAVASCRIPT - Mejor soporte para JavaScript
Plugin 'pangloss/vim-javascript'

"------------------
"------------------
"------------------


" VIM-PHP - Mejor soporte para PHP
Plugin 'stanangeloff/php.vim'
Plugin 'shawncplus/phpcomplete.vim'


"------------------
"------------------
"------------------


" TEMAS - Configuracion de Temas
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dracula/vim'
Plugin 'w0ng/vim-hybrid'
" Plugin 'edkolev/tmuxline.vim'

colorscheme dracula
color dracula
set t_Co=256
set background=dark

"------------------
"------------------
"------------------


" EASYMOTION - Movilidad simple
Plugin 'easymotion/vim-easymotion'

let g:EasyMotion_do_mapping = 0

nmap ; <Plug>(easymotion-overwin-f2)

let g:EasyMotion_smartcase = 1

nnoremap <Leader>k <Plug>(easymotion-j)
nnoremap <Leader>l <Plug>(easymotion-k)

"------------------
"------------------
"------------------


" Commentary Vim - Comentarios rapidos de codigo
Plugin 'tpope/vim-commentary'

"------------------
"------------------
"------------------


" Delimit Mate - Cierres automaticos de parentesis, llaves, etc
Plugin 'raimondi/delimitmate'

"------------------
"------------------
"------------------


" EMMET - Generador de HTML y CSS
Plugin 'mattn/emmet-vim'

"--------------------------
" Tecla lider de Emmet remapeada : <C-K>
let g:user_emmet_leader_key='<C-K>'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
"--------------------------

"------------------
"------------------
"------------------


" NeoComplete - Mejora para el autocompletado
Plugin 'shougo/neocomplete.vim'

"------------------
"------------------
"------------------


" AsiEsc - Solucion para caracteres de escape invalidos en la interfaz
Plugin 'AnsiEsc.vim'

"------------------
"------------------
"------------------


" Multi Cursor - Multi cursor
Plugin 'terryma/vim-multiple-cursors'

"------------------
"------------------
"------------------


" Gitgutter - Soporte para señales de cambios en GIT
Plugin 'airblade/vim-gitgutter'

let g:gitgutter_max_signs = 200

"------------------
"------------------
"------------------


" Icons - Iconos para archivos
Plugin 'ryanoasis/vim-devicons'
set encoding=utf-8
set fileencodings=utf-8
set guifont=Fira\ Mono\ for\ Powerline\ 12

"------------------
"------------------
"------------------


" Indentline Guides - Guia de indentacion con lineas
Plugin 'yggdroot/indentline'

let g:indentLine_char = '¦'

"------------------
"------------------
"------------------


" VIM-EUNUCH - Utilidades UNIX
Plugin 'tpope/vim-eunuch'

"------------------
"------------------
"------------------


" - - - ArthurNavaH - Configuracion -

set number
set ruler

syntax on

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab

set laststatus=2

set scrolloff=4
set hlsearch
set smartcase
set formatoptions+=1

set smartcase

set updatetime=600
set ttyfast
set timeout timeoutlen=600 ttimeoutlen=50
set history=50
set nobackup
set noswapfile
set title
set visualbell
set noerrorbells
set lazyredraw

set wrap linebreak nolist
set autoread

set cursorline
if (has("termguicolors"))
  set termguicolors
endif

autocmd FileType markdown let g:indentLine_enabled=0

"------------------
"------------------
"------------------


" Movilidad con Teclado Español
nnoremap j h
nnoremap k j
nnoremap l k
nnoremap ñ l
nnoremap J H
nnoremap K J
nnoremap L K
nnoremap Ñ L
nnoremap gk gj
nnoremap gl gk

vnoremap j h
vnoremap k j
vnoremap l k
vnoremap ñ l
vnoremap J H
vnoremap K J
vnoremap L K
vnoremap Ñ L
vnoremap gk gj
vnoremap gl gk

"------------------
"------------------
"------------------


" Inhabilitar las teclas de dirección
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
let g:elite_mode=1

"------------------
"------------------
"------------------


" Atajos de Teclado Personales
nnoremap <leader>ñ :vsplit<CR>
nnoremap <leader>k :split<CR>
nnoremap <leader>{ <C-]><CR>

nnoremap <C-c> <C-a><CR>

nnoremap <C-W>j <C-W>h
nnoremap <C-W>k <C-W>j
nnoremap <C-W>l <C-W>k
nnoremap <C-W>ñ <C-W>l

"------------------
"------------------
"------------------


" - - - ArthurNavaH - Scripts -

" Borrar archivos de Buffer excepto el activo con :Bo
"   Author : Christian J. Robinson <infynity@onewest.net>
command! -nargs=? -complete=buffer -bang Bo
    \ :call BufOnly('<args>', '<bang>')

function! BufOnly(buffer, bang)
	if a:buffer == ''
		" No buffer provided, use the current buffer.
		let buffer = bufnr('%')
	elseif (a:buffer + 0) > 0
		" A buffer number was provided.
		let buffer = bufnr(a:buffer + 0)
	else
		" A buffer name was provided.
		let buffer = bufnr(a:buffer)
	endif

	if buffer == -1
		echohl ErrorMsg
		echomsg "No matching buffer for" a:buffer
		echohl None
		return
	endif

	let last_buffer = bufnr('$')

	let delete_count = 0
	let n = 1
	while n <= last_buffer
		if n != buffer && buflisted(n)
			if a:bang == '' && getbufvar(n, '&modified')
				echohl ErrorMsg
				echomsg 'No write since last change for buffer'
							\ n '(add ! to override)'
				echohl None
			else
				silent exe 'bdel' . a:bang . ' ' . n
				if ! buflisted(n)
					let delete_count = delete_count+1
				endif
			endif
		endif
		let n = n+1
	endwhile

	if delete_count == 1
		echomsg delete_count "buffer deleted"
	elseif delete_count > 1
		echomsg delete_count "buffers deleted"
	endif

endfunction
"----------------------------------------------------
