set laststatus=2  
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ col:%2c\ line:%2l/%L\ [%2p%%]

set formatoptions=cro

set wrap

colorscheme molokai
set shiftwidth=4
set tabstop=4
set nowrap

set foldmethod=syntax

au BufRead,BufNewFile *.h           setlocal ft=c
au BufRead,BufNewFile *.hpp         setlocal ft=cpp


set backspace=2
set autoindent
set ai!
set smartindent
set nu!
set ruler
set incsearch
set hlsearch
set nowrapscan
set nocompatible
set hidden
set autochdir
set foldmethod=indent
set foldlevel=100
set laststatus=2
set cmdheight=2
set autoread
set nobackup
set noswapfile
set list
set listchars=tab:\~\ ,trail:.
set expandtab

syntax enable
syntax on
filetype indent on
filetype plugin on
filetype plugin indent on

set encoding=utf-8

"execute pathogen#infect()

au FileType perl,php       set iskeyword-=.
au FileType perl,php       set iskeyword-=$
au FileType perl,php       set iskeyword-=-
au FileType nginx          set iskeyword-=/
au FileType nginx          set iskeyword-=.

au FileType c          call AddCDict()
au FileType cpp        call AddCPPDict()
au FileType java       call AddJavaDict()
au FileType perl       call AddPerlDict()

function AddCDict()
    set dict+=~/.vim/dict/c.txt
    set complete+=k
endfunction

function AddCPPDict()
    set dict+=~/.vim/dict/c.txt
    set dict+=~/.vim/dict/cpp-stdlib.txt
    set dict+=~/.vim/dict/cpp-boost.txt
    set complete+=k
endfunction

function AddJavaDict()
    set dict+=~/.vim/dict/java.txt
    set complete+=k
endfunction
function AddPerlDict()
    set dict+=~/.vim/dict/perl.txt
    set complete+=k
endfunction

" \rm
imap <leader>rm <esc>:%s/<c-v><c-m>//g<cr>
nmap <leader>rm :%s/<c-v><c-m>//g<cr>
vmap <leader>rm <esc>:%s/<c-v><c-m>//g<cr>

" \rt
nmap <leader>rt :retab<cr>

" \ra
nmap <leader>ra <esc>\rt<esc>\rb<esc>gg=G<esc>gg<esc>

" mapping
map gG Go
imap <C-c> <Esc>:
imap <C-z> <Esc>
map pO O<Esc> 
map po o<Esc> 

au BufEnter * silent loadview
au BufLeave * mkview

au BufNewFile *.pl s/$/#!\/bin\/perl\r\ruse v5.10;\ruse strict;\ruse warnings;\r\r / | 7
au BufNewFile *.pm s/$/use v5.10;\ruse strict;\ruse warnings;\r\r/ | 5
au BufNewFile *.sed s/$/#!\/usr\/bin\/sed -nf\r\r/ | 3   
au BufNewFile *.sh  s/$/#!\/usr\/bin\/bash\r\r/ | 3
