" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'

Plug 'lervag/vimtex'

Plug 'preservim/nerdtree'

Plug 'vim-airline/vim-airline'

Plug 'mboughaba/i3config.vim'

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'monkoose/fzf-hoogle.vim'

Plug 'neovimhaskell/haskell-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

" This enables automatic indentation as you type
filetype indent on


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

colorscheme onedark

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'

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

nmap <silent> <F1> :NERDTreeToggle<CR>

" Hoogle is a Haskell API search engine
au BufNewFile,BufRead *.hs map <F12> :HoogleInfo<CR>
au BufNewFile,BufRead *.hs map <C-F12> :HoogleClose<CR>

nmap <silent> <F5> :NERDTreeToggle<CR>

" opens pdf file with zathura
" command Zathura execute "!zathura " . (join(split(expand("%"), '\.')[:-2], ".") . ".pdf") . " &"

" compiles a LaTeX document when the file is saved
" autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1 &" | redraw!
autocmd BufWritePost *.tex :VimtexCompile<CR>

" saves with sudo
command W execute 'w !sudo tee "%"'

" Hoogle
augroup HoogleMaps
  autocmd!
  autocmd FileType haskell nnoremap <buffer> <space>hh :Hoogle <C-r><C-w><CR>
augroup END

""" coc.nvm config

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" TextEdit might fail if hidden is not set.
set hidden

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
