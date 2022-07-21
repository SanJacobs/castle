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

" Ability to move lines up and down when selected
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Search and replace
nnoremap <leader>r :%s///gc<Left><Left><Left><Left>

" Clear search highlight
nnoremap <leader>n :noh<CR>

" Git shortcuts
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gp :Git push<CR>

" Random shit VimWiki wants
set nocompatible
filetype plugin on
syntax on

" Insert datestamp
nmap <F3> i<C-R>=strftime("%Y-%m-%d")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d")<CR>

" Tab settings
set softtabstop=4
set tabstop=4
set shiftwidth=4
set smartindent
set noexpandtab
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
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'mhinz/vim-signify'
Plug 'dense-analysis/ale'
Plug 'frazrepo/vim-rainbow'
Plug 'vimwiki/vimwiki'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'evanleck/vim-svelte'

call plug#end()

" CtrlP.vim setup
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll|o)$',
	\ }

" Undo tree
nnoremap <leader>z :UndotreeShow<CR>

" Clang Complete
let g:clang_library_path='/usr/lib/llvm-11/lib'

" Letting the arrow keys warp to next and previous line
set ww+=<,>

" Auto-close
autocmd FileType cpp,csound,python,bib,text inoremap " ""<left>
autocmd FileType cpp,csound,python,bib inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><Left>
autocmd FileType cpp inoremap < <

" Spellcheck
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F5> :setlocal spell! spelllang=nb<CR>

" Wordcount
function! WC()
    let filename = expand("%")
    let cmd = "detex " . filename . " | wc -w"
    let result = system(cmd)
    echo result
endfunction

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

" Airline setup
" Don't forget to install the patched fonts!
" https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:airline#extensions#hunks#enabled=0

" Setting the theme
set background=dark
"colorscheme gruvbox
"hi Normal guibg=NONE ctermbg=NONE

" ### Filetype-specific preferences

" LaTeX commands
autocmd FileType tex command WC call WC()
autocmd FileType tex map <buffer> <F8> :w<CR>:exec '!latexmk -pdf' shellescape(@%, 1)<CR><CR>
autocmd FileType bib inoremap ,book @book{<++>,<Enter>title<Space>=<Space>"<++>",<Enter>subtitle<Space>=<Space>"<++>",<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>location<Space>=<Space>"<++>",<Enter>edition<Space>=<Space>"<++>"<Enter><Backspace><Backspace>}<Esc>8k/<++><Enter>"_c4l 
autocmd FileType bib inoremap ,online @online{<++>,<Enter>title<Space>=<Space>{<++>},<Enter>subtitle<Space>=<Space>{<++>},<Enter>author<Space>=<Space>{<++>},<Enter>organization<Space>=<Space>{<++>},<Enter>url<Space>=<Space>{<++>},<Enter>urldate<Space>=<Space>{<++>},<Enter>date<Space>=<Space>{<++>}<Enter><Backspace>}<Esc>8k/<++><Enter>"_c4l
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

" C++ commands
autocmd FileType cpp map <F8> :w<CR>:make debug<CR>
autocmd FileType cpp imap <F8> <esc>:w<CR>:make debug<CR>
autocmd FileType cpp map <F9> :w<CR>:make release<CR>
autocmd FileType cpp imap <F9> <esc>:w<CR>:make release<CR>
autocmd FileType cpp imap {<CR> {<CR><CR>}<Up><Right>
set errorformat^=%-G%f:%l:\ warning:%m
