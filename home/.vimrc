"            _                    
"     _   __(_)___ ___  __________
"    | | / / / __ `__ \/ ___/ ___/
"   _| |/ / / / / / / / /  / /__  
"  (_)___/_/_/ /_/ /_/_/   \___/  
"                                 


" Enableing relative and absolute numberes
set number
set relativenumber

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

call plug#end()

" Kite and autocomplete setup
let g:kite_auto_complete=1
let g:kite_tab_complete=1
" set statusline=%<%f\ %h%m%r%{kite#statusline()}%=%-14.(%l,%c%V%)\ %P
" set laststatus=2

" Letting the arrow keys warp to next and previous line
set ww+=<,>

" Auto-close
autocmd FileType csound,python,bib,text inoremap " ""<left>
autocmd FileType csound,python,bib,text inoremap ' ''<left>
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

command WC call WC()

" Placeholder replacer
inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
map <Space><Tab> <Esc>/<++><Enter>"_c4l

" Template setups
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex
  augroup END
endif

" Goyo toggle
inoremap <F10> <Esc>:Goyo<Enter>
vnoremap <F10> <Esc>:Goyo<Enter>
map <F10> <Esc>:Goyo<Enter>

" LaTeX commands
autocmd FileType bib inoremap ,book @book{<++>,<Enter>title<Space>=<Space>"<++>",<Enter>subtitle<Space>=<Space>"<++>",<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>location<Space>=<Space>"<++>",<Enter>edition<Space>=<Space>"<++>"<Enter><Backspace><Backspace>}<Esc>8k/<++><Enter>"_c4l 
autocmd FileType tex inoremap " ``"<left>
autocmd FileType tex inoremap ,c \autocite[][]{}<left>
autocmd FileType tex inoremap ,sc \section{}<left>
autocmd FileType tex inoremap ,ssc \subsection{}<left>
autocmd FileType tex inoremap ,sssc \subsubsection{}<left>

" CSound commands
autocmd FileType csound inoremap ,instr instr<Space><Enter><Enter>endin<Esc>2kA
