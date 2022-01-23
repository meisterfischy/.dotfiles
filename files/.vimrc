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
" Code Completion with ale + completor
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Code Completion wih coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Fugitive is the premier Vim plugin for Git
Plug 'tpope/vim-fugitive'
" Vim files for editing Salt files
Plug 'saltstack/salt-vim'

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

" Fixes mouse not working properly in Vim
set ttymouse=sgr

" show line endings and tabs
set listchars=tab:>\ ,trail:~,extends:>,precedes:<
set list

" Salt Vim 
set nocompatible
filetype plugin indent on

"-- Misc -\"



"-- VimTex --" 

" compiles a LaTeX document when the file is saved
" autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1 &" | redraw!
autocmd FileType tex nnoremap <silent> <F8> :call CompileLatex()<CR>
autocmd FileType tex nnoremap <silent> <F9> :execute '!latexmk -c'<CR> | redraw!

function CompileLatex()
    let log=expand('%:r') . '.log'
    w
    silent! bdelete log
    call system('latexmk -Werror -pdf ' . expand('%'))
    if v:shell_error == 12
        set splitbelow
        15sp|view ub.log
        silent! /!
        normal zt
        wincm k
    endif
endfunction

" opens pdf file with zathura
command Zathura execute "!zathura " . (join(split(expand("%"), '\.')[:-2], ".") . ".pdf") . " &"

"let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-shell-escape',
    \ ],
    \}

autocmd FileType tex set spell spelllang=de,en

"-- VimTex --"



"/- Haskell --"

" Hoogle
augroup HoogleMaps
  autocmd!
  autocmd FileType haskell nnoremap <buffer> <space>hh :Hoogle <C-r><C-w><CR>
augroup END

"-- Haskell -/"



"/- ALE + Deoplete --"

" Use deoplete.
"autocmd FileType haskell call deoplete#enable()

let g:ale_linters = {
            \   'haskell': ['ghc','hls','hlint','stylish-haskell','hindent'],
            \}

"-- ALE + Deoplete -\"



"/- CoC --"

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"-- Coc -\"
