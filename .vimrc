set tabstop=2 shiftwidth=2 expandtab

autocmd Filetype css setlocal tabstop=4
autocmd Filetype xml setlocal tabstop=3

syntax on

colorscheme default

" on vimdiff use another color schema
if &diff
   colorscheme monokai
endif
