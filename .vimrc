" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Rainbow Parentheses
Plug 'frazrepo/vim-rainbow'
" ColorScheme
Plug 'joshdick/onedark.vim'
" Vim for LaTeX
Plug 'lervag/vimtex', { 'for': 'tex' }
" File System Explorer
Plug 'preservim/nerdtree'
" Status/Tabline
Plug 'vim-airline/vim-airline'
" For the i3 config
Plug 'mboughaba/i3config.vim'
" For Hoogle
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'monkoose/fzf-hoogle.vim'
" Syntax Highlighting and Indentation for Haskell and Cabal
Plug 'neovimhaskell/haskell-vim'
" Asynchronous Lint Engine
Plug 'dense-analysis/ale'
" Code Completion
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Initialize plugin system
call plug#end()


"/- Theme And Looks --"

" Enable rainbow Parentheses
let g:rainbow_active = 1
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']


colorscheme onedark

" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'


" Enable sytax highlighting
filetype plugin on
syntax enable

"-- Theme And Looks -\"



"/- Misc --"

" This enables automatic indentation as you type
filetype indent on

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Use spaces instead of tabs
set expandtab
" Be smart when usng tabs ;)
set smarttab

" Line numbers
set number
highlight LineNr ctermfg=240

" Open Nerd Tree
nmap <silent> <F1> :NERDTreeToggle<CR>

" Terminal in vertical split
set splitright
nmap <silent> <F10> :vert term<CR>

" saves with sudo
command W execute 'w !sudo tee "%"'

"-- Misc -\"



"-- VimTex --" 

" compiles a LaTeX document when the file is saved
" autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1 &" | redraw!

" opens pdf file with zathura
" command Zathura execute "!zathura " . (join(split(expand("%"), '\.')[:-2], ".") . ".pdf") . " &"

au filetype *tex nmap <silent> <F4> :VimtexCompile<CR>

let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'

"-- VimTex --"



"/- Haskell --"

" Hoogle
augroup HoogleMaps
  autocmd!
  autocmd FileType haskell nnoremap <buffer> <space>hh :Hoogle <C-r><C-w><CR>
augroup END

"-- Haskell -/"



"/- Deoplete --"

" Use deoplete.
let g:deoplete#enable_at_startup = 1

"-- Deoplete -\"
