local call = vim.call
local Plug = vim.fn["plug#"]

call("plug#begin")

Plug "rmagatti/alternate-toggler"
Plug "jiangmiao/auto-pairs"
Plug "numToStr/Comment.nvim"
Plug "editorconfig/editorconfig-vim"
Plug "junegunn/fzf.vim"
Plug "gentoo/gentoo-syntax"
Plug "lewis6991/impatient.nvim"
Plug "lukas-reineke/indent-blankline.nvim"
Plug "arcticicestudio/nord-vim"
Plug "nkakouros-original/numbers.nvim"
Plug "nacro90/numb.nvim"
Plug "kevinhwang91/nvim-hlslens"
Plug "amarakon/nvim-sensible"
Plug "gbprod/stay-in-place.nvim"
Plug "vim-scripts/tabops"
Plug "godlygeek/tabular"
Plug "amarakon/ultitabs"
Plug "vim-airline/vim-airline"
Plug "amarakon/vim-caret"
Plug "vim-scripts/vim-compile"
Plug "norcalli/nvim-colorizer.lua"
Plug "tpope/vim-eunuch"
Plug "tpope/vim-fugitive"
Plug "airblade/vim-gitgutter"
Plug "mhinz/vim-hugefile"
Plug "farmergreg/vim-lastplace"
Plug "tbastos/vim-lua"
Plug "tpope/vim-repeat"
Plug "tpope/vim-rhubarb"
Plug "kshenoy/vim-signature"
Plug "amarakon/vim-snippets"
Plug "tpope/vim-speeddating"
Plug "tpope/vim-surround"
Plug "justinmk/vim-syntax-extra"
Plug "mg979/vim-visual-multi"
Plug "lyokha/vim-xkbswitch"
Plug "romainl/vim-cool"
Plug "ryanoasis/vim-devicons"
Plug "tpope/vim-endwise"

Plug "neovim/nvim-lspconfig"
Plug "hrsh7th/cmp-nvim-lsp"
Plug "hrsh7th/cmp-buffer"
Plug "hrsh7th/cmp-path"
Plug "hrsh7th/cmp-cmdline"
Plug "hrsh7th/nvim-cmp"
Plug "kdheepak/cmp-latex-symbols"
Plug "williamboman/mason.nvim"
Plug "williamboman/mason-lspconfig.nvim"

Plug "dcampos/nvim-snippy"
Plug "dcampos/cmp-snippy"

Plug("nvim-treesitter/nvim-treesitter", {["do"] = vim.fn["TSUpdate"]})

call("plug#end")

local g = vim.g
local o = vim.o

local function map(mode, lhs, rhs, opts)
	local options = {}
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function noremap(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function nmap(lhs, rhs, opts)
	map("n", lhs, rhs, opts)
end

local function imap(lhs, rhs, opts)
	map("i", lhs, rhs, opts)
end

require("impatient")
require("numbers").setup()
require("numb").setup()
require("Comment").setup({ padding = false })
require("stay-in-place").setup({ preserve_visual_selection = false })
require("Comment.ft").set("rmd", "<!--%s-->")
o.termguicolors = true
require("colorizer").setup()
require("mason").setup()
require("mason-lspconfig").setup()

-- Set up tree-sitter
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = "all",
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	auto_install = true,
	-- List of parsers to ignore installing (for "all")
	ignore_install = { "phpdoc" },

	highlight = { enable = true, additional_vim_regex_highlighting = true },
	incremental_selection = { enable = true },
	indent = { enable = true }
}

-- Set up nvim-lspconfig
local opts = { noremap=true, silent=true }
local set = vim.keymap.set
set('n', '<c-f>', vim.diagnostic.open_float, opts)
set('n', '<c-s>', vim.diagnostic.goto_prev, opts)
set('n', '<c-t>', vim.diagnostic.goto_next, opts)
set('n', '<c-q>', vim.diagnostic.setloclist, opts)

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
	snippet = {
		-- Snippet engine
		expand = function(args)
			require('snippy').expand_snippet(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'snippy' },
		{ name = 'path' },
		{ name = 'latex_symbols' },
		}, {
			{ name = 'buffer' }
	})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
		}, {
			{ name = 'cmdline' }
	})
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup { capabilities = capabilities }
require'lspconfig'.sumneko_lua.setup { capabilities = capabilities }
require'lspconfig'.vimls.setup { capabilities = capabilities }

g.maplocalleader = '\\'
g.mapleader = ','

g.indent_blankline_char = '│'
g.airline_powerline_fonts = true
g.Tabops_useGoto = 0
g.Tabops_useMove = 0
g.XkbSwitchEnabled = 1
g.netrw_winsize = 10

g.VM_Mono_hl = 'Visual'
g.VM_Extend_hl = 'Visual'
g.VM_Cursor_hl = 'Visual'
g.VM_Insert_hl = 'Visual'

o.textwidth = 80
o.showmode = false
o.spell = true
o.autochdir = true

nmap("X", "dw")
nmap("M", ":delmarks ")
imap("<c-l>", "<escape><c-l>a")

vim.cmd [[
colorscheme nord

map <leader>k <cmd>silent !setsid $TERMINAL --working-directory="$(pwd)"<CR>
map <leader>K <cmd>silent up \| !rm '%:r'.md<CR>

autocmd vimenter * set omnifunc=syntaxcomplete#Complete shortmess+=c
autocmd vimenter * set completeopt+=menuone,noinsert pumheight=5

function! StripTrailingWhitespace()
	if &binary || index(['diff', 'whitespace'], &ft) >= 0 | return | endif

	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun

autocmd bufwritepre * call StripTrailingWhitespace()

autocmd filetype rmd source ~/.config/nvim/rmd.vim

autocmd vimenter * GitGutter
autocmd bufwritepost * GitGutter

autocmd vimenter * call timer_start( 100, { id -> execute( 'SignatureRefresh' ) }, { 'repeat': -1 } )

imap <c-t> <escape>l
imap <c-d> <c-v><tab>

"imap <c-e> <escape>o
"imap <c-s> <escape>O

let g:hugefile_trigger_size = 100

nmap <c-c> gcc
vmap <c-c> gc
imap <c-c> <cmd>s/\s\+$//e<return><cmd>nohlsearch<return><escape>gcA<space>

"cmap <c-s> <return><cmd>nohlsearch<return>

autocmd filetype html imap <c-c> <!--  --><left><left><left><left>
autocmd filetype rmd imap <c-c> <!--  --><left><left><left><left>

nmap <leader><backspace> <cmd>delmarks a-zA-Z0-9<return>
nmap <leader>s <cmd>wshada!<return>
nmap <leader>n :$tabedit<space>
nmap <leader>N :Tabclose<space>

nmap <leader>q <cmd>x<return>
nmap <leader>Q <cmd>q!<return>
nmap <leader>t <cmd>up<return>
nmap <leader>T <cmd>w!<return>
nmap <leader>f <cmd>Filetypes<return>
nmap <leader>F <cmd>Files<return>
nmap <leader>g <cmd>Git<return>
nmap <leader>c <cmd>Git commit<return>
nmap <leader>C <cmd>Git commit -a<return>
nmap <leader>a <cmd>Git add %<return>
nmap <leader>A <cmd>Git add -A<return>
nmap <leader>d <cmd>Git diff<return>
nmap <leader>D <cmd>!diff<space>
nmap <leader>r :Move<space>
nmap <leader>p <cmd>ToggleAlternate<return>
nmap <leader>z <cmd>!'./%:r'<return>

" No auto-comment
autocmd vimenter * set formatoptions-=r formatoptions-=c formatoptions-=o

inoremap <expr> <Tab> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-advance)' : '<c-t>'
inoremap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<c-d>'
snoremap <expr> <Tab> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<c-t>'
snoremap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<c-d>'
xnoremap <Tab> <Plug>(snippy-cut-text)

map <bar> <cmd>Tabularize /│<return>
nmap U <cmd>GitGutterUndoHunk<return>
nmap J <cmd>GitGutterPreviewHunk<return>
map <leader>; <cmd>Commands<return>
nmap <leader>h <cmd>Help<return>
nmap <leader>H <cmd>History<return>

highlight alewarningsign gui=bold
highlight aleerrorsign gui=bold

nmap <silent> <return> :nohlsearch<return>

autocmd filetype python set noexpandtab

set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
]]
