" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'

Plug 'dense-analysis/ale'

Plug 'Twinside/vim-hoogle'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'mboughaba/i3config.vim'

" Initialize plugin system
call plug#end()

" This enables automatic indentation as you type
filetype indent on

" Colorscheme
colo BlackSea

let g:airline#extensions#tabline#enabled = 1

" Enable sytax highlighting
filetype plugin on
syntax enable

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Use spaces instead of tabs
set expandtab
" Be smart when usng tabs ;)
set smarttab

" Line numbers
set number
highlight LineNr ctermfg=grey

autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1 &" | redraw!

let g:ale_linters = {
    \   'haskell' :['ghc'],
    \   'c': ['clang','gcc'],
    \   'cpp':['clang'],
    \}

nmap <silent> <F1> :ALEDetail<CR>
nmap <silent> <F5> :NERDTreeToggle<CR>
nmap <silent> <F6> :tabnew<CR>:e .<CR>
nmap <silent> <C-a> :ALEDetail<CR>

" Hoogle is a Haskell API search engine
au BufNewFile,BufRead *.hs map <buffer> <F12> :HoogleInfo 
au BufNewFile,BufRead *.hs map <buffer> <C-F12> :HoogleClose<CR>

" opens pdf file with zathura
command Zathura execute "!zathura " . (join(split(expand("%"), '\.')[:-2], ".") . ".pdf") . " &"

" saves with sudo
command W execute 'w !sudo tee "%"'
