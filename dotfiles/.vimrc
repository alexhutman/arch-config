call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'lervag/vimtex'
call plug#end()
" If this is the first time running on a machine, type ":PlugInstall" in vim
" However, my config generator (https://github.com/alexhutman/config-generator/) does this automatically.

" Set term colors to 256
set t_Co=256
set termguicolors

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

" Make tabs appear smaller
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Remap KJ to exit terminal mode
tnoremap KJ <C-\><C-n>

" Splits open at the bottom and right. Vim default is stupid..
set splitbelow splitright

"set nolist

" Set gruvbox theme
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark

syntax on


function! YankSelectedText()
	execute "normal! \"+y"
	let result = substitute(getreg("+"), "^J", "\\n", "g")
	let result2 = substitute(result, "[[:cntrl:]]", "", "g")
	" Use the below line for using the asterisk register instead
	" let result = getreg("*")
	
	"TODO: Maybe print the string to make sure escape chars get removed
	"properly first

	call system("clip.exe", result)<CR>

	echom "Selected text was added to the clipboard"
endfunc

function! GetClipboardText()
	let result = call system('powershell.exe Get-Clipboard')<CR>

	call append(line('$'), result)<CR>

	echom "Text inserted from clipboard"
endfunc

if has("clipboard") && executable("clip.exe") && executable("powershell.exe")
	noremap "+y YankSelectedText()
	" Use the below line for using the asterisk register instead
	" noremap "*y :call system('clip.exe', GetSelectedText())<CR>
	
	noremap "+p GetClipboardText()
endif
