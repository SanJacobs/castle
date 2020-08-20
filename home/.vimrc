"            _                    
"     _   __(_)___ ___  __________
"    | | / / / __ `__ \/ ___/ ___/
"   _| |/ / / / / / / / /  / /__  
"  (_)___/_/_/ /_/ /_/_/   \___/  
"                                 


" Enableing relative and absolute numberes
set number
set relativenumber

" Some nice basics
set noerrorbells
set smartcase
set incsearch
set noswapfile
set undodir=~/.vim/undodir
set undofile

" Making it possible to move between buffers
let mapleader = " "
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Clear search highlight
nnoremap <leader>n :noh<CR>

" Tab settings
set softtabstop=4
set tabstop=4
set shiftwidth=4
set smartindent
inoremap <CR> <CR>x<BS>
inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>

" Vim-plug auto-install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim-plug section
call plug#begin('~/.vim/plugged')

Plug 'luisjure/csound-vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'

call plug#end()

" Kite and autocomplete setup
let g:kite_auto_complete=1
let g:kite_tab_complete=1
let g:kite_supported_languages = ['python']
nnoremap <leader>d :KiteGotoDefinition<CR>
" set statusline=%<%f\ %h%m%r%{kite#statusline()}%=%-14.(%l,%c%V%)\ %P
" set laststatus=2

" Undo tree
nnoremap <leader>z :UndotreeShow<CR>

" Letting the arrow keys warp to next and previous line
set ww+=<,>

" Auto-close
autocmd FileType csound,python,bib,text inoremap " ""<left>
autocmd FileType csound,python,bib inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><Left>

" Spellcheck
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F5> :setlocal spell! spelllang=nb<CR>

" Wordcount
function! WC()
    let filename = expand("%")
    let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
    let result = system(cmd)
    echo result . " words"
endfunction

"command WC call WC()

" Placeholder replacer
inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
map <Space><Tab> <Esc>/<++><Enter>"_c4l

" Template setups
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex
    autocmd BufNewFile *.html 0r ~/.vim/templates/skeleton.html
    autocmd BufNewFile *.htm 0r ~/.vim/templates/skeleton.html
  augroup END
endif

" Goyo toggle
inoremap <F10> <Esc>:Goyo<Enter>
vnoremap <F10> <Esc>:Goyo<Enter>
map <F10> <Esc>:Goyo<Enter>

" Airline setup
" Don't forget to install the patched fonts!
" https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'

" Setting the theme
set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" ### Filetype-specific preferences

" LaTeX commands
autocmd FileType bib inoremap ,book @book{<++>,<Enter>title<Space>=<Space>"<++>",<Enter>subtitle<Space>=<Space>"<++>",<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>location<Space>=<Space>"<++>",<Enter>edition<Space>=<Space>"<++>"<Enter><Backspace><Backspace>}<Esc>8k/<++><Enter>"_c4l 
autocmd FileType tex inoremap " ``"<left>
autocmd FileType tex inoremap ,c \autocite[][]{}<left>
autocmd FileType tex inoremap ,sc \section{}<left>
autocmd FileType tex inoremap ,ssc \subsection{}<left>
autocmd FileType tex inoremap ,sssc \subsubsection{}<left>

" CSound commands
autocmd FileType csound inoremap ,instr instr<Space><Enter>;<Space>############<Enter>;<Space>###<Space><++><Space>###<Enter>;<Space>############<Enter><Enter><++><Enter><Enter>endin<Esc>7kA
autocmd FileType csound set tabstop=4 

" Webdev commands
autocmd FileType html,css,htm,javascript set tabstop=4 

" Python commands
autocmd FileType python map <buffer> <F8> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F8> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
