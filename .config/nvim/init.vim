lua require('config')

map <leader>k <cmd>silent !setsid $TERMINAL --working-directory="$(pwd)"<CR>
map <leader>K <cmd>silent up \| !rm '%:r'.md<CR>

" Uncomment the following to have Vim jump to the last position when
" reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd BufNew,BufNewFile,BufRead *.ms set filetype=groff

fun! StripTrailingWhitespace()
	if &ft =~ 'diff\|ruby\|javascript\|perl'
		return
	endif
	%s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()
autocmd Filetype diff set nolist

autocmd Filetype rmd source ~/.config/nvim/rmd.vim

fun! Start()
	" Don't run if: we have command-line arguments, we don't have an empty
	" buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
	if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
		return
	endif
	History!
	set nonu nornu
endfun

autocmd VimEnter * call Start()

autocmd BufWritePost * GitGutter

autocmd VimEnter * GitGutter
autocmd VimEnter * set omnifunc=syntaxcomplete#Complete shortmess+=c completeopt=menuone,noselect,noinsert pumheight=5
autocmd vimenter * call timer_start( 100, { id -> execute( 'SignatureRefresh' ) }, { 'repeat': -1 } )
autocmd Filetype gitcommit set colorcolumn=51
autocmd Filetype diff set nospell

imap <expr> <up> pumvisible() ? "<c-e><up>" : "<up>"
imap <expr> <down> pumvisible() ? "<c-e><down>" : "<down>"
imap <expr> <return> pumvisible() ? "<c-e><return>" : "<return>"

imap <c-t> <escape>l
imap <c-d> <c-v><tab>

imap <c-e> <escape>o
imap <c-s> <escape>O

let g:hugefile_trigger_size = 100

nmap <c-c> gcc
vmap <c-c> gc
imap <c-c> <escape>gcA<space>

cmap <c-s> <return><return>

autocmd filetype html imap <c-c> <!--  --><left><left><left><left>
autocmd filetype rmd imap <c-c> <!--  --><left><left><left><left>

nmap <leader><backspace> <cmd>delmarks a-zA-Z0-9<return>
nmap <leader>s <cmd>wshada!<return>
nmap <tab> <cmd>tabnext<return>
nmap <s-tab> <cmd>tabprevious<return>
nmap <leader>n :$tabedit<space>
nmap <leader>N :Tabclose<space>

" Go to tab by number
for i in range(9)
	execute "nmap <leader>".i." ".i."gt"
endfor

nnoremap <leader>0 <cmd>tablast<return>

nmap <leader>q <cmd>x<return>
nmap <leader>Q <cmd>q!<return>
nmap <leader>t <cmd>up<return>
nmap <leader>T <cmd>w!<return>
map <leader><tab> :Tabularize<space>
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
"noremap ; :
nmap ; <cmd>Commands<return>
nmap H <cmd>Help<return>

nmap <silent> <C-s> <Plug>(ale_previous_wrap)
nmap <silent> <C-t> <Plug>(ale_next_wrap)

highlight alewarningsign gui=bold
highlight aleerrorsign gui=bold

imap <c-l> <c-x><c-l>

nmap <silent> <return> :noh<return>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

function! MyLineNumber()
  return substitute(line('.'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g'). ' | '.
    \    substitute(line('$'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
endfunction

call airline#parts#define('linenr', {'function': 'MyLineNumber', 'accents': 'bold'})

let g:airline_section_z = airline#section#create(['%3p%%: ', 'linenr', ':%3v'])

let g:airline#extensions#tabline#tab_nr_type = 1

autocmd vimenter * set stal=1

autocmd filetype python set noexpandtab

let &titlestring = "Neovim – %t%( %m%)"
"autocmd vimenter * silent write
" Scanning tags

set autochdir

function! Tabclose(...)
	if a:1 == ""
		tabonly
	elseif a:1 == "left"
		Tabops Close Left
	elseif a:1 == "right"
		Tabops Close Right
	else
		execute "tabclose " a:1
	endif
endfunction

command -nargs=* Tabclose call Tabclose("<args>")

cabbrev tabclose Tabclose

" close multiple tab
"function! s:TabClose(...)
"  for i in reverse(sort(copy(a:000)))
"    execute 'tabclose ' . i
"  endfor
"endfunction
"command! -nargs=* TabClose  call <SID>TabClose(<f-args>)
"nnoremap <Space>td  :<C-u>tabs<Return>:TabClose<Space>

let g:Tabops_useGoto = 0
let g:Tabops_useMove = 0
