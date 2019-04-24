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
let NERDTreeIgnore=[ '^\.git$', ]
let NERDTreeAutoDeleteBuffer = 1

"------------------
"------------------
"------------------


" FZF - Buscador de Archivos
" Plugin 'junegunn/fzf'
Plugin 'shougo/denite.nvim'

nmap <leader>b :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>f :Denite file/rec -split=floating -winrow=1<CR>
nnoremap <leader>h :<C-u>Denite grep:. -no-empty -mode=normal<CR>

" nnoremap <leader>f :FZF<CR>

"------------------
"------------------
"------------------


" Airline - Barra de Estado
Plugin 'bling/vim-airline'

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_theme='hybrid'
let g:airline_theme='oceanicnext'
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
Plugin 'peitalin/vim-jsx-typescript'

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

"------------------
"------------------
"------------------


" VIM-GO - Mejor soporte para Go
Plugin 'fatih/vim-go'
" Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'mdempsky/gocode', {'rtp': 'vim/'}

let g:go_fmt_command = "goimports"
" Silenciar pestañas de advertencias de GoFmt
" let g:go_fmt_fail_silently = 1
"
" Elije que deseas que se coloree de la sintaxis de Go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
"
" Evitar que GoMetaLinter se ejecute por demasiado tiempo
let g:go_metalinter_deadline = '20s'

" let g:go_list_type = 'quickfix'

" Activar GoMetaLinter al guardar el archivo
let g:go_metalinter_autosave = 1

" Declara el referenciador a definiciones
let g:go_def_mode = 'godef'

" Activa GoInfo automaticamente
let g:go_auto_type_info = 1

" Resaltar automaticamente las coincidencias bajo el cursor
let g:go_auto_sameids = 1

" Etiquetas para los campos de la estructura
let g:go_addtags_transform = "camelcase"

" let g:go_version_warning = 0

" Ejecutar :GoTest con <leader>gt
autocmd FileType go nmap <leader>gt  :GoTest<CR>
" Ejecutar :GoBuild con <leader>gb
autocmd FileType go nmap <leader>gb  :GoBuild<CR>
" Ejecutar :GoAlternate con <leader>ga
autocmd FileType go nmap <leader>ga  :GoAlternate<CR>
" Ejecutar :GoCoverage con <leader>gc
autocmd FileType go nmap <leader>gc  :GoCoverageToggle<CR>
" Ejecutar :GoAddTags con <leader>gat
autocmd FileType go nmap <leader>gat  :GoAddTags
" Ejecutar :GoRemoveTags con <leader>grt
autocmd FileType go nmap <leader>grt  :GoRemoveTags
" Ejecutar :GoImport con <leader>gi
autocmd FileType go nmap <leader>gi  :GoImport
" Ejecutar :GoChannelPeers con <leader>gcp
autocmd FileType go nmap <leader>gcp  :GoChannelPeers<CR>
" Agregar comentario a bloque de codigo con <leader>gac
autocmd FileType go nmap <leader>gac  ?{<CR>0wywO//<ESC>pa

"------------------
"------------------
"------------------


" VIM-JAVASCRIPT - Mejor soporte para JavaScript
Plugin 'pangloss/vim-javascript'

"------------------
"------------------
"------------------


" VIM-JSX - Soporte para JSX
Plugin 'mxw/vim-jsx'

"------------------
"------------------
"------------------


" VIM-PHP - Mejor soporte para PHP
" Plugin 'stanangeloff/php.vim'
" Plugin 'shawncplus/phpcomplete.vim'


"------------------
"------------------
"------------------


" TEMAS - Configuracion de Temas
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mhartington/oceanic-next'
Plugin 'joshdick/onedark.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sickill/vim-monokai'
Plugin 'dracula/vim'
Plugin 'w0ng/vim-hybrid'

colorscheme OceanicNext
color OceanicNext
set background=dark

if (has("termguicolors"))
 set termguicolors
endif

let g:rehash256 = 1
set t_Co=256
" let g:solarized_termcolors=256
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

"------------------
"------------------
"------------------


" " EASYMOTION - Movilidad simple
" Plugin 'easymotion/vim-easymotion'

" let g:EasyMotion_do_mapping = 0

" nmap ; <Plug>(easymotion-overwin-f2)

" let g:EasyMotion_smartcase = 1

" nnoremap <Leader>k <Plug>(easymotion-j)
" nnoremap <Leader>l <Plug>(easymotion-k)

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
autocmd FileType html,css,javascript EmmetInstall
"--------------------------

"------------------
"------------------
"------------------


" NeoComplete - Mejora para el autocompletado
Plugin 'shougo/neocomplete.vim'

Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'neoclide/vim-node-rpc'

Plugin 'neoclide/coc.nvim'
Plugin 'neoclide/coc-neco'

" if has("nvim")
"     Plugin 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"     Plugin 'shougo/deoplete.nvim'
" endif
" let g:deoplete#enable_at_startup=1
" let g:deoplete#enable_ignore_case=1
" let g:deoplete#enable_smart_case=1
" let g:deoplete#enable_camel_case=1
" let g:deoplete#enable_refresh_always=1
" let g:deoplete#max_abbr_width=0
" let g:deoplete#max_menu_width=0
" let g:deoplete#omni#input_patterns=get(g:,'deoplete#omni#input_patterns', {})

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

set nohlsearch

set updatetime=300
set ttyfast
" set timeout timeoutlen=300 ttimeoutlen=50
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
set conceallevel=0

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
"
" Coc.nvim

" Better display for messages
set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
