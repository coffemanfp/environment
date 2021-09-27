let g:coc_global_extensions = [
\ 'coc-omni', 
\ 'coc-html',
\ 'coc-css',
\ 'coc-emmet',
\ 'coc-json',
\ 'coc-highlight',
\ 'coc-yank',
\ 'coc-pairs',
\ 'coc-syntax',
\ 'coc-tsserver',
\ 'coc-prettier',
\ 'coc-eslint',
\ 'coc-emoji'
\ ]

" - - - arthurnavah - Plugins -
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.config/nvim/dein'))
call dein#add(expand('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim'))
if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
endif

let g:dein#enable_notification=1
" nvim-notify - Notification manager
call dein#add('rcarriga/nvim-notify')

" NERDTree - File explorer
call dein#add('preservim/nerdtree')
call dein#add('xuyuanp/nerdtree-git-plugin')

" Denite - Search file
call dein#add('Shougo/denite.nvim')

" Airline - Status bar
call dein#add('bling/vim-airline')

" neomake - Check errors
call dein#add('neomake/neomake')

" vim-polyglot config
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['bash=sh', 'css', 'django', 'javascript', 'js=javascript', 'json=javascript', 'perl', 'php', 'python', 'ruby', 'sass', 'xml', 'html', 'vim', 'go']

" vim-polyglot syntax
call dein#add('sheerun/vim-polyglot')
call dein#add('matthewbdaly/vim-filetype-settings')

" vim-go - Go Support
call dein#add('fatih/vim-go', { 'do': ':GoUpdateBinaries' })

" vim-json - JSON Support
call dein#add('elzr/vim-json')

" vim-javascript - JavaScript Support
call dein#add('pangloss/vim-javascript')
" typescript-vim - TypeScript Support
call dein#add('leafgarland/typescript-vim')
" vim-jsx-pretty - JSX syntax
call dein#add('maxmellon/vim-jsx-pretty')
" vim-jsx-typescript - TSX syntax
call dein#add('peitalin/vim-jsx-typescript')
" vim-styled-components - Styled Components
call dein#add('styled-components/vim-styled-components', { 'branch': 'main'})

" nerdcommenter - Comments fast
call dein#add('preservim/nerdcommenter')

" emmet - HTML and CSS generator
call dein#add('mattn/emmet-vim')

" coc.nvim - Autocomplete
call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'master', 'build': 'yarn install --frozen-lockfile' })

" Gitgutter - GIT change signal icons
call dein#add('airblade/vim-gitgutter')
" vim-devicons - Icons file
call dein#add('ryanoasis/vim-devicons')
" nerdtree-devicons-syntax - Icons in nerdtree
call dein#add('vwxyutarooo/nerdtree-devicons-syntax')

" indentline - Indentline guide
call dein#add('yggdroot/indentline')

" vim-eununch - UNIX Utility
call dein#add('tpope/vim-eunuch')

" tmuxline.vim - Tmux integration
call dein#add('edkolev/tmuxline.vim')

" vim-surround - 'surroundings'
call dein#add('tpope/vim-surround')

" themes
call dein#add('vim-airline/vim-airline-themes')
call dein#add('morhetz/gruvbox')

" vimade - Dims inactive windows
"call dein#add('TaDaa/vimade')
call dein#add('sunjon/shade.nvim')

" vim-multiple-cursors - Multi cursor
"call dein#add('terryma/vim-multiple-cursors')

call dein#end()

if dein#check_install()
    call dein#install()
endif
" ---------------------------

" vim config
if &compatible
  set nocompatible " Be iMproved
endif

filetype off                  " required
set backspace=2
filetype plugin indent on    " required
set relativenumber
set number
set list
set listchars=tab:\▏\ 

set ruler

set ignorecase
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab

set laststatus=2

set scrolloff=4
set hlsearch
set smartcase
set formatoptions+=1

set updatetime=300
set timeout 
set ttimeout 
set timeoutlen=200 
set ttimeoutlen=100
set history=30
set ttyfast

set title
set noerrorbells
set autoread

set encoding=UTF-8
set fileencodings=UTF-8

set wildignore+=**/bower_components/**,**/node_modules/**,**vendor/bundle**,**target/scala**,**project/target**,*.jpg,*.gif,*.png,*.svg,*.zip,package-lock.json

set hidden
set nobackup
set nowritebackup
set signcolumn=auto

set directory^=$HOME/.config/nvim/tmp//

if has('nvim')
    set icm=nosplit
endif

set guifont=Fira\ Mono\ for\ Powerline\ 12

" vim config -- disable conceal
set conceallevel=0
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" vim config -- increment speed
set lazyredraw
"set cul!

" vim config -- mapping
let mapleader=" "
let maplocalleader="\\"
cnoremap jk <Esc>
inoremap jk <Esc>
cnoremap kj <Esc>
inoremap kj <Esc>

" vim config -- theme enable
if !exists("g:syntax_on")
    syntax on
endif

let g:rehash256 = 1
set t_Co=256

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif

" vim config -- set theme
if filereadable(expand("$HOME/.mode"))
    let modeTheme = readfile(expand("$HOME/.mode"))
    if len(modeTheme) == 1
        let $MODE = modeTheme[0]
    endif
endif

let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_sign_column='bg0'

set cursorline

if $MODE == "light"
    set background=light
    let g:airline_theme='gruvbox'

    let g:gruvbox_number_column='light2'
    colorscheme gruvbox
else
    set background=dark
    let g:airline_theme='gruvbox'

    let g:gruvbox_number_column='dark0'
    colorscheme gruvbox

	highlight CursorLine guibg=#262626
endif

" vim config -- theme config

" --- end vim config

" shade.nvim config

lua << EOF
require'shade'.setup({
  overlay_opacity = 70,
  opacity_step = 1
})
EOF

" NERDTree config
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>m :NERDTreeFind<CR>

let g:WebDevIconsNerdTreeBeforeGlyphPadding = " "
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=1
let NERDTreeMouseMode=2
let NERDTreeIgnore=[ '^\.git$', '\.pyc$', '^__pycache__$' ]
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

" denite config
nmap <leader>b :Denite -no-empty buffer <CR>
nmap <leader>f :Denite -no-empty file/rec <CR>
nnoremap <leader>h :Denite -no-empty grep<CR>

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> t
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> s
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> f
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
endfunction

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', 'vendor/', 'node_modules/', 'package-lock.json'])

call denite#custom#var('file/rec', 'command',
    \ ['rg', '--files', '--vimgrep'])

call denite#custom#var('grep', {
    \ 'command': ['rg',
    \   '-g', '!package-lock.json', 
    \   '-g', '!go.sum'],
    \ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
    \ 'recursive_opts': [],
    \ 'pattern_opt': ['--regexp'],
    \ 'separator': ['--'],
    \ 'final_opts': [],
    \ })

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
	imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

let s:denite_options = {
      \ 'prompt' : '>',
      \ 'split': 'floating',
      \ 'start_filter': 0,
      \ 'auto_resize': 1,
      \ 'source_names': 'short',
      \ 'direction': 'botright',
      \ 'highlight_filter_background': 'CursorLine',
      \ 'highlight_matched_char': 'Type',
      \ }

call denite#custom#option('default', s:denite_options)

" airline config
let g:airline_powerline_fonts = 1
let g:airline_detect_iminsert=1
let g:airline_skip_empty_sections = 1
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#ale#enabled = 0

let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#neomake#enabled = 0

let g:airline_extensions = 
	\ ['coc', 'quickfix', 'tabline', 'whitespace']
let g:airline_highlighting_cache = 1

let g:airline_section_z = '%p%%%#__accent_bold# %l%#__restore__#%#__accent_bold#/%L%#__restore__#%#__accent_bold#%{g:airline_symbols.colnr}%v%#__restore__#'
let g:airline_section_warning = ''
let g:airline_section_errors = ''
let g:airline_section_statistics = ''

let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c'],
  \ [ 'x', 'z' ]
  \ ]

" tmuxline.vim config
let g:tmuxline_powerline_separators = 0

" typescript config
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" vim-go config
"let g:go_metalinter_enabled = []

let g:go_auto_type_info = 1
let g:go_jump_to_error = 0
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_addtags_transform = "camelcase"

let g:go_term_enabled = 1

autocmd FileType go nmap <leader>gj  :GoBuild<CR>
autocmd FileType go nmap <leader>gl :GoLint<CR>
autocmd FileType go nmap <leader>gk :GoVet<CR>
autocmd FileType go nmap <leader>gat  :GoAddTags
autocmd FileType go nmap <leader>grt  :GoRemoveTags
autocmd FileType go nmap <leader>gcp  :GoChannelPeers<CR>
" go - show function calls
autocmd BufEnter *.go nmap <leader>gc  <Plug>(go-callers)

" emmet config
let g:user_emmet_leader_key='<C-K>'
let g:user_emmet_install_global = 0
autocmd FileType html,xhtml,css,javascript,js EmmetInstall

" gitgutter config
let g:gitgutter_max_signs = 200

" indentline config
let g:indentLine_char = '▏'

" neomake config
autocmd! BufReadPost,BufWritePost * Neomake

call neomake#configure#automake('nrwi', 350)

let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

" Disable inherited syntastic
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }

let g:neomake_open_list=0
let g:jsx_ext_required = 0

" coc.nvim config
set cmdheight=2
set shortmess+=c
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gt <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" coc-pairs config
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" ---------------------------------------

" vim scripts

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

command! -nargs=0 LightMode call LightMode()
function! LightMode()
    set background=light

    let g:gruvbox_number_column='light2'
    colorscheme gruvbox

    AirlineTheme gruvbox

    silent exec "!echo 'light' > ~/.mode"
endfunction

command! -nargs=0 DarkMode call DarkMode()
function! DarkMode()
    set background=dark

    let g:gruvbox_number_column='dark0'
    colorscheme gruvbox

    AirlineTheme gruvbox

	highlight CursorLine guibg=#262626

    silent exec "!echo 'dark' > ~/.mode"
endfunction
"----------------------------------------------------
