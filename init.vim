
" if $SHELL == "C:/msys64/usr/bin/bash"
"     let Sshellcmdflag = '-c'
"     set shellxquote=(
"     set shellslash
" endif
" 
" :help terminal-emulator
" 
" set bash as the shell
" 
" Trying to set temp directory in the TMP path, hoping to make :read
" !<command> work without breaking existing functionality and plugins like
" vim-fugitive
" let $TMP-stdpath('config') . "\\tmp"
" 
" set noshelltemp

let $PATH .= C:\cygwin64\bin'
set shell=bash.exe
" C:\Program Files\Git\usr\bin needs to be on the path,
" so that term command opens a bash

if $SHELL == "C:/Program Files/Git/usr/bin/bash"
    let &shellcmdflag = '-c'
    set shellxquote=(
    set shellslash
endif

" set guifont=FiraCode\ NF:h11
" Something that worked in Mac:
set guifont=JetBrainsMono\ Nerd\ Font:h14

" set shellslash

" Actual .vimrc/init.vim config starts here

set number
set relativenumber

" lua << EOF
" -- require "temp_del"
" -- require "suvansh/td"
" -- require "suvansh.td"
" EOF
" 
" lua << EOF
" -- vim.wo.number = true
" -- vim.wo.relativenumber true
" EOF

set ignorecase
set smartcase

"set hidden         " Hidden buffer
                    " Pro: allow switch buffer without saving
                    " Con: May cause you to quit without saving changes

set tabstop=4       " The width of a TAB is set to 4.

                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4 columns

set shiftwidth=4    " Indents will have a width of 4
                    " (When using > to indent)

set expandtab       " Expand TABs to spaces.
                    " On pressin tab, insert 4 spaces 
                    " To unset this, we can use
                    " set noexpandtab

set incsearch
set scrolloff=4
set sidescrolloff=4
set signcolumn=yes
"set colorcolumn=80
set cursorline

set clipboard=      " Make vim use separate clipboard than the system clipboard

set shortmess-=S
" set termwinsize=18×0 " Set terminal window size 20 rows and 0 (full width) cols

set termguicolors   " Use GUI colors (needed for git bash, by default not
                    " supporting gui colors)

set noswapfile
set nowrap

" set splitbelow    " force all horizontal splits to go below the current window

" Mapping leader to space (think about this)
nnoremap <Space> <Hop>
let mapleader = " "

" load the plugins

" source ~/AppData/Local/nvim/plugins.vim
:exe 'source '.stdpath('config').'./plugins.vim'

lua << EOF
require "suvansh.colorschemesetter"
require "suvansh.snippets.snippets"
-- require "suvansh.luasnip-config" 
require "suvansh.cmp"
require "suvansh.lsp"
-- require "suvansh.null-ls"
require "suvansh.telescope"
require "suvansh.treesitter"
-- vim.notify("the treesitter has been loaded")
-- require 'nvim-treesitter.install'.compilers = { "clang" }
require "suvansh.gitsigns"
require "suvansh.nvim-tree"
EOF

" TEMPORARY trying with luasnip -------------- Start ------------------

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards
inoremap <silent> <S-Tab> <cmd>lua require 'luasnip'.jump(-1)<CR>

snoremap <silent> <Tab> <cmd>lua require 'luasnip'.jump(1)<CR>
snoremap <silent> <S-Tab> <cmd>lua require 'luasnip'.jump(-1)<CR>

" For changing choices in choiceNodes
imap <silent> <expr> <C-J> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-J>'
imap <silent> <expr> <C-K> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-K>'

smap <silent> <expr> <C-J> Luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-J>'
smap <silent> <expr> <C-K> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-K>'
" TEMPORARY trying with luasnip ----------------- End -----------------

set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr

"Easy copying and pasting from system clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>p "+p
vnoremap <leader>d "+d

" Better window navigation
nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

" ---------- TERMINAL related mappings ----------
" Open a terminal window below, resize to 18 rows, enter the insert mode
nnoremap <leader>t :below sp \| term<CR>:resize 18<CR>i
nnoremap <leader>tt :below sp \| term<CR>:resize 18<CR>i
" or
" nnoremap <leader>t :below split \| terminal<CR>:resize 18<CR>i
" nnoremap <leader>tt :below split \| terminal<CR>:resize 18<CR>i

" Open terminal below spanning horizontally
nnoremap <leader>T :bo sp \| term<CR>:resize 18<CR>i
" or
" nnoremap <leader>T :botright split \| terminal<CR>:resize 18<CR>i

" Esc to exit a terminal insert mode
tnoremap <Esc> <Esc><C-\><C-n>

" Better terminal navigation
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
" ---------- TERMINAL related mappings end ----------

" colorscheme codedark
" let g:airline_theme = 'codedark'
" let g:netrw_liststyle=3
" let g:netrw_chgwin=2
" let g:netrw_banner=0

" read from command run selected text as command, read its output into vim
vnoremap <leader>rc :read!
" above does not run the selected text as command, instead selects the range
" of the selected text into the command mode. This is not useful (in the way I
" want)
" Instead, the below (Ctrl+ Enter) in the visual mode will run selected text
" as command.

" Drawback it disturbs the clipboard. Need to find a way to do this without
" disturbing the clipboard.
vnoremap <C-CR> y: read! "<CR>

" My windows specific drawback the command shell needs to be in cmd mode, not
" bash mode so for windows, we temporarily set shell to cmd and then reset it
" back to bash
" vnoremap <C-CR> y:set shell-cmd.exe<CR>: read! "<CR>:set shell-bash.exe<CR>

" temporarily removing hjkl commands to improve navigation skills
" nnoremap h <nop>
" nnoremap j <nop>
" nnoremap k <nop>
" nnoremap 1 <nop>

" Easy promt to delete un-needed buffers
nnoremap <leader>dls :ls<CR>:bd<space>

" ---------- Telescope related mappings ----------
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fw :Telescope live_grep<CR>
nnoremap <leader>t1f :lua require'telescope.builtin.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>
" nnoremap <leader>tb Telescope buffers<CR>
nnoremap <leader>ls :Telescope buffers<CR>
nnoremap <leader>tgs :Telescope git_status<CR>
nnoremap <leader>tgb :Telescope git_branches<CR>
nnoremap <leader>gr :Telescope lsp_references<CR>
nnoremap <leader>tff :Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>td :Telescope diagnostics<CR>
" This is ctrl+/, to enter, go to insert mode, press ctrl+v, then press ctrl+/
nnoremap  :Telescope keymaps<CR>
" This is ctrl+* (in normal keyboard layout, ctrl+shift+8) or ctrl+8 here
nnoremap  :Telescope grep_string<CR>
" ---------- Telescope related mappings end ----------

" ---------- Gitsigns related mappings ----------
nnoremap <leader>gb :Gitsigns blame Line<CR>
" ---------- Gitsigns related mappings end ----------

" ---------- Nvim-tree related mappings ----------
nnoremap <leader>e :NvimTreeToggle<CR>
" ---------- Nvim-tree related mappings end ----------

" json formatting with <leader>j
augroup jsonbindings
    autocmd! jsonbindings
    autocmd FileType json nnoremap <buffer> <leader>j :%s/\("\|]\|}\):\("\|\[\|{\)/\1: \2/g<CR>:%s/\("\|\w\|]\|}\),\("\|\[\|{\)/\1,\r\2/g<CR>:%s/\(\[\|{\)\(\[\|{\|"\)/\1\r\2/g<CR>@:@:@:@:@::.,$s/\(\w\|"\|]\|}\)\(}\|\]\)/\1\r\2/g<CR>@:@:@:@:@::%s/\(\w\|"\|]\|}\)\(}\|\]\)/\1\r\2/g<CR>@:@:@:@:@:gg=%
    " autocmd FileType json nnoremap <buffer> <leader>j :%s/\("\|]\|}\):\("\|\[\|{\)/\1: \2/g <bar> %s/\("\|\w\|]\|}\),\("\|\[\|{\)/\1,\r\2/g <bar> %s/\(\[\|{\)\(\[\|{\|"\)/\1\r\2/g <bar> norm @: <bar> norm @: <bar> norm @: <bar> norm @: <bar> norm @: <bar> %s/\(\w\|"\|]\|}\)\(}\|\]\)/\1\r\2/g <bar> norm @: <bar> norm @: <bar> norm @: <bar> norm @: <bar> norm @: <bar> %s/\(\w\|"\|]\|}\)\(}\|\]\)/\1\r\2/g <bar> norm @: <bar> norm @: <bar> norm @: <bar> norm @: <bar> norm @: <bar> norm gg=%
    " fun! FormatJson()
    "     %s/\("\|]\|}\):\("\|\[\|{\)/\1: \2/g
    "     %s/\("\|\w\|]\|}\),\("\|\[\|{\)/\1,\r\2/g
    "     %s/\(\[\|{\)\(\[\|{\|"\)/\1\r\2/g
    "     norm @:
    "     norm @:
    "     norm @:
    "     norm @:
    "     norm @:
    "     .,$s/\(\w\|"\|]\|}\)\(}\|\]\)/\1\r\2/g
    "     norm @:
    "     norm @:
    "     norm @:
    "     norm @:
    "     norm @:
    "     %s/\(\w\|"\|]\|}\)\(}\|\]\)/\1\r\2/g
    "     norm @:
    "     norm @:
    "     norm @:
    "     norm @:
    "     norm @:
    "     norm gg=%
    " endfun
    " autocmd FileType json nnoremap <buffer> <leader>j command! FormatJson
augroup end

" Setting shell to cmd and bash for windows
" nnoremap <leader>ssc <cmd>set shell=cmd.exe<CR>
" nnoremap <leader>ssb <cmd>set shell=bash.exe<CR>

" Temporary mapping to improve typing accuracy
" During insert mode, backspace will remove the whole line and cursor will go
" to the beginning
inoremap <BS> ^C

" Mapping to toggle full-screen in neovide using F10
nnoremap <F10> <cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>

