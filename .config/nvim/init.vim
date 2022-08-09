lua require('config')

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

map k :silent !setsid $TERMINAL --working-directory="$(pwd)"<CR>
map K :up \| silent !rm '%:r'.md<CR>

" Uncomment the following to have Vim jump to the last position when
" reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"map z :silent !setsid $READER '%:r'.pdf<CR>
map Z :silent !R --quiet -e 'browseURL("%:r.html")'<CR>

autocmd BufNew,BufNewFile,BufRead *.ms set filetype=groff

fun! StripTrailingWhitespace()
	" Don’t strip on these filetypes
	if &ft =~ 'ruby\|javascript\|perl\|diff'
		return
	endif
	%s/\s\+$//e
endfun

fun! Markdown()
	if &ft =~ 'markdown'
		g:indent_blankline_char_list = ["html",·"python",·"sh",·"bash",·"zsh"]
	endif
endfun

autocmd BufWritePre * call StripTrailingWhitespace()
autocmd Filetype diff set nolist
call Markdown()

autocmd Filetype c lua require("c")
autocmd Filetype rmd source ~/.config/nvim/rmd.vim
autocmd Filetype css lua require("css")
autocmd Filetype scss lua require("css")
autocmd Filetype html lua require("html")
autocmd Filetype rnoweb lua require("rnoweb")
autocmd Filetype tex lua require("tex")
autocmd Filetype groff lua require("groff")
autocmd Filetype go lua require("go")

fun! Start()
	" Don't run if: we have commandline arguments, we don't have an empty
	" buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
	if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
		return
	endif
	" Now we can just write to the buffer, whatever you want.
	History!
	"set nonu nornu showtabline=0 laststatus=0 noruler noshowcmd
	set nonu nornu
endfun

autocmd VimEnter * call Start()

autocmd BufWritePost * GitGutter

"set completeopt=menu,menuone,noselect

autocmd Filetype gitcommit set colorcolumn=51
autocmd Filetype diff set nospell
