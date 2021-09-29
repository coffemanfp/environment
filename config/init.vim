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

" icons
call dein#add('kyazdani42/nvim-web-devicons')
call dein#add('ryanoasis/vim-devicons')

" nvim-notify - Notification manager
call dein#add('rcarriga/nvim-notify')
let g:dein#enable_notification=1

" startify - Start screen
call dein#add('mhinz/vim-startify')

" nvim-tree - File explorer
call dein#add('kyazdani42/nvim-tree.lua')

" Airline - Status bar
call dein#add('bling/vim-airline')

" Denite - Search file
" call dein#add('Shougo/denite.nvim')
call dein#add('nvim-telescope/telescope.nvim')
call dein#add('nvim-telescope/telescope-fzf-native.nvim')
call dein#add('nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' })

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

" kommentary - Comments fast
call dein#add('b3nj5m1n/kommentary')

" emmet - HTML and CSS generator
call dein#add('mattn/emmet-vim')

" coc.nvim - Autocomplete
call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'master', 'build': 'yarn install --frozen-lockfile' })

" gitsigns - GIT change signal icons
call dein#add('nvim-lua/plenary.nvim')
call dein#add('lewis6991/gitsigns.nvim')

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
call dein#add('lifepillar/vim-gruvbox8')

call dein#end()

if dein#check_install()
    call dein#install()
endif
" ---------------------------

" startify config
let g:startify_custom_header = [
\ '    ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗',
\ '    ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║',
\ '    ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║',
\ '    ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║',
\ '    ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║',
\ '    ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝',
\ '                                                    ',
\ '                                         a̳r̳t̳h̳u̳r̳n̳a̳v̳a̳h̳',
\ ]
highlight StartifyHeader ctermfg=white

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
let g:gruvbox_italicize_strings=1
let g:gruvbox_sign_column='bg0'

set cursorline

if $MODE == "light"
    set background=light
	let g:airline_theme='gruvbox8'

    let g:gruvbox_number_column='light2'
    colorscheme gruvbox
else
    set background=dark
	let g:airline_theme='deus'

    let g:gruvbox_number_column='dark0'
    colorscheme gruvbox

	highlight Cursorline cterm=bold gui=bold guibg=#262626
	highlight CocFloating guibg=#303030 
	highlight Pmenu guibg=#303030 

endif


" vim config -- theme config

" --- end vim config

" nvim-tree config
let g:nvim_tree_ignore = [ '.git', '.pyc', '__pycache__' ]
let g:nvim_tree_refresh_wait = 600
lua << EOF
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- default mappings
require'nvim-tree'.setup {
  auto_close          = true,
  open_on_setup       = true,
  view = {
    width = 30,
    auto_resize = true,
    mappings = {
      list = {
		  { key = "s",                        cb = tree_cb("vsplit") },
		  { key = "i",                        cb = tree_cb("split") },
		  { key = "t",                        cb = tree_cb("tabnew") },
		  { key = "x",                        cb = tree_cb("close_node") },
	  } 
    }
  }
}
EOF
nnoremap <leader>n :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>m :NvimTreeFindFile<CR>:NvimTreeFocus<CR>

" telescope.nvim config
lua << EOF
require('telescope').setup{
	defaults = {
		prompt_prefix = "🔍 ",

		vimgrep_arguments = {
		  "rg",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
		  "-g", "!package-lock.json",
		  "-g", "!go.sum",
		  "-g", "!node_modules",
		},

		mappings = {
			n = {
				["q"] = require('telescope.actions').close,
				["<Esc>"] = require('telescope.actions').close,
				["t"] = require('telescope.actions').select_tab,
				["s"] = require('telescope.actions').select_vertical,
				["i"] = require('telescope.actions').select_horizontal,
				["d"] = require('telescope.actions').delete_buffer,

				["<Space>"] = {
					require('telescope.actions').toggle_selection,
					type = 'action',
					keymap_opts = { nowait = true },
				},
			},
		},
	},
}
EOF
nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>

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
	\ ['quickfix', 'tabline', 'whitespace', 'coc']
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

" gitsigns config
lua << EOF
require('gitsigns').setup()
EOF

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
	let g:airline_theme='gruvbox8'

    let g:gruvbox_number_column='light2'
    colorscheme gruvbox

    silent exec "!echo 'light' > ~/.mode"
endfunction

command! -nargs=0 DarkMode call DarkMode()
function! DarkMode()
    set background=dark
	let g:airline_theme='deus'

    let g:gruvbox_number_column='dark0'
    colorscheme gruvbox

	highlight Cursorline cterm=bold gui=bold guibg=#262626
	highlight CocFloating guibg=#303030 
	highlight Pmenu guibg=#303030 

    silent exec "!echo 'dark' > ~/.mode"
endfunction
"----------------------------------------------------
