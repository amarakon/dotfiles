map <leader>m <cmd>!R --quiet -e 'rmarkdown::render("%")'<return>
map <leader>M <cmd>silent !R --quiet -e 'browseURL("%:r.html")'<return>

imap <C-f> $\frac{<Right>{<Right>$<Esc>ba
imap <C-d> $\approx$
imap <C-g> \@ref(
imap <C-k> \num{
