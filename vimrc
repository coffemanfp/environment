call plug#begin('~/.vim/plugged')

" - - - ArthurNavaH - Plugs -

" NERDTree - Explorador de Archivos
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'

" FZF - Buscador de Archivos
" Plug 'junegunn/fzf'
Plug 'shougo/denite.nvim'

" Airline - Barra de Estado
Plug 'bling/vim-airline'

" Syntastic - Aumento de Sintaxis
Plug 'scrooloose/syntastic'

" VIM-JSON - Mejor soporte para JSON
Plug 'elzr/vim-json'

" VIM-TYPESCRIPT - Mejor soporte para TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" VIM-GO - Mejor soporte para Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'mdempsky/gocode', {'rtp': 'vim/'}

" VIM-JAVASCRIPT - Mejor soporte para JavaScript
Plug 'pangloss/vim-javascript'

" VIM-JSX - Soporte para JSX
Plug 'mxw/vim-jsx'

" Commentary Vim - Comentarios rapidos de codigo
Plug 'scrooloose/nerdcommenter'

" Delimit Mate - Cierres automaticos de parentesis, llaves, etc
Plug 'raimondi/delimitmate'

" EMMET - Generador de HTML y CSS
Plug 'mattn/emmet-vim'

" NeoComplete - Mejora para el autocompletado
Plug 'shougo/neocomplete.vim'

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'neoclide/vim-node-rpc'

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-neco'

" AsiEsc - Solucion para caracteres de escape invalidos en la interfaz
Plug 'vim-scripts/AnsiEsc.vim'

" Multi Cursor - Multi cursor
Plug 'terryma/vim-multiple-cursors'

" Gitgutter - Soporte para señales de cambios en GIT
Plug 'airblade/vim-gitgutter'

" Icons - Iconos para archivos
Plug 'ryanoasis/vim-devicons'

" Indentline Guides - Guia de indentacion con lineas
Plug 'yggdroot/indentline'

" VIM-EUNUCH - Utilidades UNIX
Plug 'tpope/vim-eunuch'

" ALE - Resaltado de sintaxis
Plug 'w0rp/ale'

" TEMAS - Configuracion de Temas
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'
Plug 'dracula/vim'
Plug 'w0ng/vim-hybrid'
Plug 'flrnprz/taffy.vim'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'

call plug#end()

" ---------------------------

set nocompatible              " be iMproved, required

filetype off                  " required
set backspace=2
filetype plugin indent on    " required
let mapleader=" "
let maplocalleader="\\"

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>nn :NERDTreeFind<CR>

let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=1
let NERDTreeMouseMode=2
let NERDTreeIgnore=[ '^\.git$', ]
let NERDTreeAutoDeleteBuffer = 1

nmap <leader>b :Denite buffer <CR>
nmap <leader>f :Denite file/rec <CR>
nnoremap <leader>h :<C-u>Denite grep:. -no-empty -mode=normal<CR>

"" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> <CR>
				\ denite#do_map('do_action')
	nnoremap <silent><buffer><expr> p
				\ denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> q
				\ denite#do_map('quit')
	nnoremap <silent><buffer><expr> f
				\ denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <Space>
				\ denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
	imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', 'vendor/', 'node_modules'])

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='oceanicnext'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

let g:vim_json_syntax_conceal = 2

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Activar GoMetaLinter al guardar el archivo
let g:go_metalinter_autosave = 1

" Activa GoInfo automaticamente
let g:go_auto_type_info = 1

" Resaltar automaticamente las coincidencias bajo el cursor
let g:go_auto_sameids = 1

" Etiquetas para los campos de la estructura
let g:go_addtags_transform = "camelcase"

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

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
" Ejecutar :GoChannelPeers con <leader>gcp
autocmd FileType go nmap <leader>gcp  :GoChannelPeers<CR>

let g:user_emmet_leader_key='<C-K>'
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript EmmetInstall

let g:gitgutter_max_signs = 200

set encoding=utf-8
set fileencodings=utf-8
set guifont=Fira\ Mono\ for\ Powerline\ 12

let g:indentLine_char = '¦'

let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file<Paste>

let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }


" ---------------------------------------

set number
set ruler

syntax on

set ignorecase
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

set updatetime=200
set ttyfast
set timeout timeoutlen=200 ttimeoutlen=50
set history=50

set noswapfile
set title
set noerrorbells
set lazyredraw
set wrap linebreak nolist
set autoread

colorscheme gruvbox
if (has("termguicolors"))
 set termguicolors
endif

let g:rehash256 = 1
set t_Co=256
set background=dark

autocmd FileType markdown let g:indentLine_enabled=0
set conceallevel=0

nnoremap <leader>l :vsplit<CR>
nnoremap <leader>j :split<CR>

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
" vmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

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
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


