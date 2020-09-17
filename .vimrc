" vim-plug plugin manager
call plug#begin()

Plug 'preservim/nerdtree'

Plug 'dense-analysis/ale'

Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'mboughaba/i3config.vim'

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

autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Use ALE as completion sources for all code.
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})

let g:ale_linters = {
    \   'haskell': ['ghc'],
    \   'c': ['clang','gcc'],
    \   'cpp':['clang'],
    \}

" smart brackets 
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" exit insert on terminal
tnoremap <Esc> <C-\><C-n>

nmap <silent> <F1> :ALEToggleBuffer<CR>
nmap <silent> <F5> :NERDTreeToggle<CR>
nmap <silent> <F7> :Newterm<CR>
nmap <silent> <F8> :ALEDetail<CR>
nmap <silent> <F4> :tabnew<CR>:e .<CR>

command -bar Newterm call Create_term()

" opens pdf file with zathura
command Zathura execute "!zathura " . (join(split(expand("%"), '\.')[:-2], ".") . ".pdf") . " &"

" ===========
" FUNCTIONS
" ===========

function Create_term()
	tabnew
    execute "terminal"
endfunction
