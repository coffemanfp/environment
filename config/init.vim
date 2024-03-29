let g:coc_global_extensions = [
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

" dependencies
call dein#add('nvim-lua/plenary.nvim')
call dein#add('nvim-lua/popup.nvim')

" icons
call dein#add('kyazdani42/nvim-web-devicons')
call dein#add('ryanoasis/vim-devicons')

" colorizer.lua - Colorizer
call dein#add('norcalli/nvim-colorizer.lua')

" vim-repeat - Repeat in plugins
call dein#add('tpope/vim-repeat')

" nvim-notify - Notification manager
call dein#add('rcarriga/nvim-notify')
let g:dein#enable_notification=1

" fugitive - Git integration
call dein#add('tpope/vim-fugitive')

" dashboard-nvim - Start screen
call dein#add('glepnir/dashboard-nvim')

" nvim-tree - File explorer
call dein#add('kyazdani42/nvim-tree.lua')

" Airline - Status bar
call dein#add('bling/vim-airline')

" Denite - Search file
call dein#add('nvim-telescope/telescope.nvim')
call dein#add('nvim-telescope/telescope-fzf-native.nvim')
call dein#add('nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' })

" neomake - Check errors
call dein#add('neomake/neomake')

" vim-go - Go Support
call dein#add('fatih/vim-go', { 'do': ':GoUpdateBinaries' })

" vim-json - JSON Support
call dein#add('elzr/vim-json')

" scss-syntax - SASS syntax
call dein#add('cakebaker/scss-syntax.vim')

" vim-javascript - JavaScript Support
call dein#add('pangloss/vim-javascript')

" vim-jsx-pretty - JSX syntax
call dein#add('yuezk/vim-js')
call dein#add('maxmellon/vim-jsx-pretty')
" vim-styled-components - Styled Components
call dein#add('styled-components/vim-styled-components', { 'branch': 'main'})

" typescript-vim - TypeScript Support
call dein#add('leafgarland/typescript-vim')
" vim-jsx-typescript - TSX syntax
call dein#add('peitalin/vim-jsx-typescript')

" kommentary - Comments fast
call dein#add('b3nj5m1n/kommentary')

" emmet - HTML and CSS generator
call dein#add('mattn/emmet-vim')

" coc.nvim - Autocomplete
call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })

" gitsigns - GIT change signal icons
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
call dein#add('lifepillar/vim-gruvbox8')
call dein#add('tanvirtin/monokai.nvim')
call dein#add('rafamadriz/neon')
call dein#add('morhetz/gruvbox')

call dein#end()

if dein#check_install()
    call dein#install()
endif
" ---------------------------

" dashboard-nvim config
let g:dashboard_custom_header = [
\ '███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗',
\ '████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║',
\ '██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║',
\ '██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║',
\ '██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║',
\ '╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝',
\ '                                                ',
\ 'Welcome, '.$USER.'.',
\ ]
let g:dashboard_default_executive ='telescope'

let g:dashboard_custom_section={
\	'1': {
\		'description': ['    New file		(i)'],
\		'command': 'DashboardNewFile',
\	},
\	'11': {
\		'description': ['   Find File		(f)'],
\		'command': 'DashboardFindFile',
\	},
\	'2': {
\		'description': ['   Find Word		(h)'],
\		'command': 'DashboardFindWord',
\	},
\	'22': {
\		'description': [''],
\		'command': '',
\	},
\	'3': {
\		'description': ['   Open Tree		(e)'],
\		'command': 'NvimTreeOpen',
\	},
\	'33': {
\		'description': ['  Open Folder		(o)'],
\		'command': '!gio open .',
\	},
\	'4': {
\		'description': [''],
\		'command': '',
\	},
\	'44': {
\		'description': ['  Edit Config		(c)'],
\		'command': 'e ~/.config/nvim/init.vim',
\	},
\	'5': {
\		'description': ['❤️  Checkhealth		(s)'],
\		'command': 'checkhealth',
\	},
\	'55': {
\		'description': [''],
\		'command': '',
\	},
\	'99': {
\		'description': ['❌       Exit		(q)'],
\		'command': 'q',
\	},
\}
autocmd FileType dashboard nmap <buffer> <silent> i :DashboardNewFile<CR>
autocmd FileType dashboard nmap <buffer> <silent> f :DashboardFindFile<CR>
autocmd FileType dashboard nmap <buffer> <silent> h :DashboardFindWord<CR>
autocmd FileType dashboard nmap <buffer> <silent> e :NvimTreeOpen<CR>
autocmd FileType dashboard nmap <buffer> <silent> o :silent exec '!gio open .'<CR>
autocmd FileType dashboard nmap <buffer> <silent> c :e ~/.config/nvim/init.vim<CR>
autocmd FileType dashboard nmap <buffer> <silent> s :checkhealth<CR>
autocmd FileType dashboard nmap <buffer> <silent> q :q<CR>

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

" disable providers
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

" vim config -- disable conceal
set conceallevel=0
setlocal conceallevel=0
let g:vim_json_syntax_conceal=0
let g:vim_markdown_conceal=0
let g:vim_markdown_conceal_code_blocks=0
let g:indentLine_fileTypeExclude = ['dashboard', 'markdown']

" vim config -- increment speed
set lazyredraw
"set cul!

" vim config -- mapping
let mapleader="\<Space>"
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

" let g:neon_style='dark'
" let g:neon_italic_comment=1
" let g:neon_italic_keyword=1
" let g:neon_italic_function=1

set cursorline

if $MODE == "light"
    set background=light
	let g:airline_theme='gruvbox8'

    let g:gruvbox_number_column='light2'
    colorscheme gruvbox
else
    set background=dark
	let g:airline_theme='molokai'

	" colorscheme neon
	colorscheme monokai_pro

	highlight Cursorline cterm=bold gui=bold
	highlight NvimTreeNormal guibg=#1c1c1c
	highlight NvimTreeVertSplit guibg=#1c1c1c guifg=#1c1c1c
endif

highlight dashboardHeader guifg=orange

" vim config -- theme config

" --- end vim config

" nvim-tree config
let g:nvim_tree_refresh_wait = 500
lua << EOF
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- default mappings
require'nvim-tree'.setup {
  filters = {
    custom = {
	  ".git",
	  ".pyc",
	  "__pycache__"
	},
  },
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
nnoremap <silent> <leader>e :NvimTreeToggle<CR>
nnoremap <silent> <leader>r :NvimTreeRefresh<CR>
nnoremap <silent> <leader>n :NvimTreeToggleFindFile<CR>

" telescope.nvim config
lua << EOF
require('telescope').setup{
	defaults = {
		prompt_prefix = "🔍 ",

		vimgrep_arguments = {
		  "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
		  "-g", "!package-lock.json",
		  "-g", "!go.sum",
		  "-g", "!node_modules",
		  "-g", "!.git",
		},

		mappings = {
			n = {
				["q"] = require('telescope.actions').close,
				["<Esc>"] = require('telescope.actions').close,
				["<C-t>"] = require('telescope.actions').select_tab,
				["<C-s>"] = require('telescope.actions').select_vertical,
				["<C-i>"] = require('telescope.actions').select_horizontal,
				["<C-d>"] = require('telescope.actions').delete_buffer
			},
			i = {
				["<C-t>"] = require('telescope.actions').select_tab,
				["<C-s>"] = require('telescope.actions').select_vertical,
				["<C-i>"] = require('telescope.actions').select_horizontal,
				["<C-d>"] = require('telescope.actions').delete_buffer
			},
		},

		preview = {
			filesize_limit = 15,
			timeout = 200,
		}
	},
}
EOF
nnoremap <silent> <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <silent> <leader>h <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <silent> <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>

" treesitter config
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  ensure_installed = {
    "vim",
    "javascript",
    "typescript",
    "tsx",
    "bash",
    "json",
    "yaml",

    "html",
    "scss",
    "css",
    "go",
    "gomod",
    "cpp",
    "lua",
    "dockerfile",
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
EOF

" colorizer.lua config
lua << EOF
require'colorizer'.setup()
EOF

" airline config
let g:airline_powerline_fonts = 1
let g:airline_detect_iminsert=1
let g:airline_skip_empty_sections = 1
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
let g:airline_detect_modified=1

let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#ale#enabled = 0

let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#neomake#enabled = 0
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tabs_label = ''

let g:airline_extensions =
	\ ['branch', 'quickfix', 'tabline', 'whitespace', 'coc']

let g:airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}%{get(b:, "gitsigns_status", "")}'

let g:airline_section_z = '%p%%%#__accent_bold# %l%#__restore__#%#__accent_bold#/%L%#__restore__#%#__accent_bold#%{g:airline_symbols.colnr}%v%#__restore__#'

let g:airline_section_warning = ''
let g:airline_section_errors = ''
let g:airline_section_statistics = ''

let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c'],
  \ [ 'x', 'z' ]
  \ ]

let g:airline_highlighting_cache = 1

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '

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
		lua require("notify")("Buffer deleted")
	elseif delete_count > 1
		lua require("notify")("Buffers deleted")
	endif
endfunction

command! -nargs=0 LightMode call LightMode()
function! LightMode()
    set background=light
	let g:airline_theme='gruvbox8'

    let g:gruvbox_number_column='light2'
    colorscheme gruvbox

    silent exec "!echo 'light' > ~/.mode"
	lua require("notify")("Light Mode!")
endfunction

command! -nargs=0 DarkMode call DarkMode()
function! DarkMode()
    set background=dark
	let g:airline_theme='molokai'

	colorscheme monokai_pro

	highlight Cursorline cterm=bold gui=bold
	highlight NvimTreeNormal guibg=#1c1c1c
	highlight NvimTreeVertSplit guibg=#1c1c1c guifg=#1c1c1c

    silent exec "!echo 'dark' > ~/.mode"
	lua require("notify")("Dark Mode!")
endfunction

command! -nargs=0 NvimTreeToggleFindFile call NvimTreeToggleFindFile()
function! NvimTreeToggleFindFile()
	if &filetype == "NvimTree"
		NvimTreeClose
	else
		NvimTreeFindFile
	endif
endfunction

command! -nargs=0 Cpath call Cpath()
function! Cpath()
    silent exec "!pwd | xclip -selection clipboard"
	lua require("notify")("Copied " .. vim.fn.getcwd())
endfunction
"----------------------------------------------------
