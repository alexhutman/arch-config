" Set monokai-bold theme 
set termguicolors
syntax on
colorscheme monokai-bold

" Add relative line numbers with absolute line number as the zeroth
set number relativenumber

" Set timeout to .1s so binding below waits for a shorter amount of time (default is 1s)
set timeoutlen=100
" Not sure how much I like this since pasting a "kj" from clipboard will hit Esc and not paste correctly.
" Going to try it out for now.
inoremap kj <Esc>
cnoremap kj <C-C>

" Remap Ctrl+W -> [J,K,L,H] to just Ctrl+[J,K,L,H]
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

