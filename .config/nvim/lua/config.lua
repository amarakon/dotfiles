require('impatient')
require('numbers').setup()
require('numb').setup()
require('Comment').setup({ padding = false })

require("stay-in-place").setup({ preserve_visual_selection = false })

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local g = vim.g
local o = vim.o
local opt = vim.opt
local wo = vim.wo
local ft = require('Comment.ft')

ft.set('rmd', '<!--%s-->')

vim.cmd("colorscheme nord")

g.vcm_default_maps = 0
g.user_emmet_leader_key = "<c-z>"

g.indent_blankline_char = '│'
g.rainbow_active = true

g.airline_powerline_fonts = true
g.maplocalleader = '\\'
g.mapleader = ','

g.ale_lint_on_text_changed = "never"
g.ale_lint_on_insert_leave = 0

g.ale_sign_error = '•'
g.ale_sign_warning = '·'

map("i", "<C-Space>", "<C-x><C-o>")

o.title = true
o.number = true
o.relativenumber = true
o.numberwidth = 1
opt.foldlevel = 1
opt.mouse = "a"
opt.listchars = "tab:──,space:·"
opt.textwidth = 80
opt.list = true
opt.cul = true
opt.showmode = false
opt.tabstop = 4
opt.softtabstop = -1
opt.shiftwidth = 0
opt.ch=1
opt.autoindent = true
opt.smartindent = true
opt.termguicolors = true
opt.termbidi = true
opt.spell = true
opt.spelllang = "en_ca"
wo.colorcolumn = "81"

map("n", "<Home>", "gg")
map("n", "<End>", "G")
map("n", "X", "dw")
map("n", "M", ":delmarks ")

map("i", "<Home>", "<Esc>ggi")
map("i", "<End>", "<Esc>Gi")

-- Comments
map("i", "<c-z>", "`# `<Left>")

map("i", "<c-l>", "<escape><c-l>a")

-- Clipboard
map("n", "<c-y>", "<cmd>silent !xclip -r -i -selection clipboard %<return>")
map("n", "<c-p>", "\"+p")
map("v", "Y", "\"+y")
map("v", "D", "\"+d")

vim.api.nvim_create_augroup("bufcheck", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
		group = "bufcheck",
		pattern = { "gitcommit", "gitrebase" },
		command = "startinsert | 1",
	})
