call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter, { do': 'TSUpdate' }

" Nvim-tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Colorschemes

Plug 'gruvbox-community/gruvbox'
Plug 'tomasr/molokai'
Plug 'rakr/vim-one'
Plug 'endel/vim-github-colorscheme'
Plug 'whatyouhide/vim-gotham'
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'sainnhe/sonokai'
Plug 'liuchengxu/space-vim-dark'
Plug 'jacoborus/tender.vim'
Plug 'cseelus/vim-colors-lucid'
Plug 'tomasiser/vim-code-dark'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'altercation/vim-colors-solarized'
Plug 'Mofiqul/codedark.nvim'
Plug 'bignimbus/pop-punk.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'lunarvim/darkplus.nvim'
Plug 'Mofiqul/vscode.nvim'
" Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
" Plug 'sainnhe/everforest"
" Plug 'Shatur/neovim-ayu'
" Plug 'folke/tokyonight.nvim'
" Plug 'pacha/vem-dark'
" Plug 'cocopon/iceberg.vim'
" Plug 'srcery-colors/srcery-vim'
" Plug 'ray-x/aurora'
" Plug 'marko-cerovac/material.nvim'
" Plug 'tanvirtin/monokai.nvim'
" Plug 'bkegley/gloombuddy'
" Plug 'Yagua/nebulous.nvim'
Plug 'edeneast/nightfox.nvim'
Plug 'shaunsingh/moonlight.nvim'
" Plug 'briones-gabriel/darcula-solid.nvim'
" Plug 'shaunsingh/nord.nvim'
" Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
" Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
" Plug 'vv9k/bogster'
" Plug 'bluz71/vim-moonfly-colors
" Plug 'bluz/1/vim-nightfly-guicolors'  " only for gui or terms with
                                        " termguicolors enabled
" Plug 'rebelot/kanagawa.nvim'
" Add a colorscheme called embark as well - nvim-telescope showcase

" ----- Colorschemes end -----

" cmp (completion) - nvim-cmp plugin

Plug 'hrsh7th/nvim-cmp'         " The completion plugin
Plug 'hrsh7th/cmp-buffer'       " Buffer completions
Plug 'hrsh7th/cmp-path'         " Path completions
Plug 'hrsh7th/cmp-cmdline'      " Command line completions
Plug 'hrsh7th/cmp-nvim-lsp'     " Use lsp as a completion source for nvim-cmp
                                " completion engine / plugin

" Snippets manager for nvim-cmp plugin (since snippets are required for
" nvim-cmp)

" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'
Plug 'L3MON4D3/LuaSnip', { 'tag': 'v<CurrentMajor>.*' }
Plug 'saadparwaiz1/cmp_luasnip'

" ----- cmp end -----

" LSP

Plug 'neovim/nvim-lspconfig'                " Enable LSP
Plug 'williamboman/nvim-lsp-installer'      " Simple to use language server installer
Plug 'jose-elias-alvarez/null-ls.nvim'      " For formatters and linters

" ----- LSP end -----

" Telescope
Plug 'nvim-telescope/telescope.nvim'

" Git plugins
" Fugitive for git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Colors in vim (for css and color themes)
" Plug RRethy/vin-hexokinase, { 'do': 'make hexokinase' }
Plug 'norcalli/nvim-colorizer.lua'

" Status Line - lualine
Plug 'nvim-lualine/lualine.nvim'

call plug#end()
