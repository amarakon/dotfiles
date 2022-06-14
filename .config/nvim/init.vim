colorscheme nord

autocmd filetype r let R_auto_start = 1

let R_open_example = 0

let R_nvimpager = 'no'

let R_args = ['--quiet']

let Rout_more_colors = 1

let R_rcomment_string = '# '

let g:netrw_winsize = 20

let g:rainbow_active = 1

let g:rainbow_conf = {
\   'separately': {
\       'cmake': 0,
\   }
\}

let g:indent_blankline_char_list = ['│', '┊', '┆', '|', '¦']

" Change Leader and LocalLeader keys:
let maplocalleader = ','
let mapleader = ';'

" Use Ctrl+Space to do omnicompletion:
if has('nvim') || has('gui_running')
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

let rrst_syn_hl_chunk = 1
let rmd_syn_hl_chunk = 1

let rout_follow_colorscheme = 1

autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set cul nu rnu noshowmode shiftwidth=4 ch=1 autoindent smartindent encoding=utf-8 termguicolors termbidi

nmap <silent> <LocalLeader>vl :call RAction("viewobj", ", howto='aboveleft vsp'")<CR>
nmap <silent> <LocalLeader>vt :call RAction("viewobj", ", howto='topleft 11sp', nrows=10")<CR>

map t :up<CR>
map q :x<CR>
map Q :q!<CR>
map f :filetype detect<CR>
map F :set filetype=
map h :noh<CR>
map j :redo<CR>
"map k :up \| silent !trash '%:r'.md<CR>
map k :on<CR>
map K :up \| silent !trash '%:r'.md<CR>
"map K :up \| silent !trash '%:r'.html<CR>
map <C-y> "+y
map <C-d> "+d
map <C-p> "+p
map l a\|\|<Left><Esc>
map <Home> gg
map <End> G

nmap <C-r> :m .+1<CR>
nmap <C-s> :m .-2<CR>
nmap <C-a> yyp

imap <Home> <Esc>ggi
imap <End> <Esc>Gi
imap <C-c> #<Space>

vmap <C-r> :m '>+1<CR>
vmap <C-s> :m '<-2<CR>

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

autocmd Filetype rmd map m :up \| !R --quiet -e 'rmarkdown::render("%")'<CR>
autocmd Filetype rmd map M :up \| !R --quiet -e 'bookdown::render_book("index.Rmd")'<CR>
autocmd Filetype rnoweb map m :up \| !R --quiet -e 'knitr::knit2pdf("%")'<CR>
autocmd Filetype tex map m :up \| !pdflatex %<CR>
autocmd Filetype rmd map  a\text{<Esc>
autocmd Filetype rmd map ] a\autoalign{<Right>{<Right>{<Esc>b
"autocmd Filetype rmd map x a$\sfrac{<Right>{<Right>$<Esc>b
autocmd Filetype rmd imap <C-a> ---<CR>---<Esc>O
autocmd Filetype rmd imap <C-o> **<Left>
autocmd Filetype rmd imap <C-b> ****<Left><Left>
autocmd Filetype rmd imap <C-u> []{.ul}<Left><Left><Left><Left><Left><Left>
"autocmd Filetype rmd imap <C-x> ~~~~<Left><Left>
autocmd Filetype rmd imap <C-f> $\frac{<Right>{<Right>$<Esc>ba
autocmd Filetype rmd imap <C-q> ^^<Left>
autocmd Filetype rmd imap <C-w> ~~<Left>
autocmd Filetype rmd imap <C-d> $\approx$
autocmd Filetype rmd imap <C-n> &larr;
autocmd Filetype rmd imap <C-e> &rarr;
autocmd Filetype rmd imap <C-l> &darr;
autocmd Filetype rmd imap <C-y> &uarr;
autocmd Filetype rmd imap <C-z> $$<Left>
autocmd Filetype rmd imap <C-r> ```<CR><Up><Right><Right><Right>
autocmd Filetype rmd imap <C-s> :::<CR><CR><CR><CR>:::<Up><Up><Up><Up>
autocmd Filetype rmd imap <C-t> ::: {. latex=""}<CR><CR><CR><CR>:::<Up><Up><Up><Up><Right><Right><Right>
autocmd Filetype rmd imap <C-g> \@ref(
autocmd Filetype rmd imap <C-k> \num{
autocmd Filetype rmd imap <C-c> <!--  --><Left><Left><Left><Left>
autocmd Filetype rmd imap <F1> - [ ]<Space>
autocmd Filetype rmd imap <F2> - [x]<Space>
autocmd Filetype rmd imap <F3> ```{r}<CR><CR><CR><Up>plot(vals, xlab="$x$", ylab="$y$", type='o', pch=16, col='blue')<Up><CR><Up>vals <- c()<Left>
autocmd Filetype rmd imap <F4> ```{r}<CR><CR><CR><Up>plot(fun1, -5, 5, xlab = '$x$', ylab = '$y$', col = 'blue')<Up><CR><Up>fun1 <- function(x){}<Left>
autocmd Filetype rmd imap <F5> ```{r}<CR><CR><Up>grViz("digraph {<CR><Backspace><Backspace><Down><Space><Space><Up>  graph [layout = dot, rankdir = TB]<CR><CR>node [shape = rectangle]<CR>rec1 [label = '']<CR><CR>rec1<Up><Up><Esc>A<Left><Left>
autocmd Filetype rmd imap <F6> ```{r}<CR><CR><Up>grViz("digraph graph2 {<CR><Backspace><Backspace><Down><Space><Up>  graph [layout = dot, rankdir = LR]<CR><CR>node [shape = oval]<CR>oval1 [label = '']<CR><CR>oval1<Up><Up><Esc>A<Left><Left>
autocmd Filetype rmd :inoremap <F7> <C-o>:.-1read /usr/lib64/R/site-library/amaryaml/rmarkdown/templates/eisvogel/skeleton/skeleton.Rmd<CR><CR>
autocmd Filetype rmd :inoremap <F8> <C-o>:.-1read /usr/lib64/R/site-library/amaryaml/rmarkdown/templates/norbeam/skeleton/skeleton.Rmd<CR><CR>
autocmd Filetype rmd :inoremap <F9> <C-o>:.-1read /usr/lib64/R/site-library/amaryaml/rmarkdown/templates/book/skeleton/skeleton.Rmd<CR><CR>
autocmd Filetype rmd :inoremap <F10> <C-o>:.-1read /usr/lib64/R/site-library/amaryaml/rmarkdown/templates/github/skeleton/skeleton.Rmd<CR><CR>

 map z :silent !setsid $READER '%:r'.pdf<CR>
