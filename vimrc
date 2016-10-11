colorscheme molokai
set shiftwidth=4
set tabstop=4
set nowrap

set foldmethod=syntax

au BufRead,BufNewFile *.h           setlocal ft=c
au BufRead,BufNewFile *.i           setlocal ft=c
au BufRead,BufNewFile *.ss          setlocal ft=scheme
au BufRead,BufNewFile *.cl          setlocal ft=lisp
au BufRead,BufNewFile *.sql         setlocal ft=mysql
au BufRead,BufNewFile *.log         setlocal ft=conf
au BufRead,BufNewFile hosts         setlocal ft=conf
au BufRead,BufNewFile *.conf        setlocal ft=nginx
au BufRead,BufNewFile http*.conf    setlocal ft=apache
au BufRead,BufNewFile *.ini         setlocal ft=dosini


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

:inoremap ( ()<esc>i
:inoremap { {}<esc>i
:inoremap [ []<esc>i

execute pathogen#infect()

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

" TagBar
let g:tagbar_sort = 0
let g:tagbar_show_linenumbers = -1
let g:tagbar_autopreview = 1

" Indent_guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size            = 1

" AirLine
let g:airline_theme = 'raven'


" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_mode_map      = {
            \'mode': 'active',
            \'passive_filetypes': ['groovy', 'kotlin', 'scala', 'clojure', 'lisp', 'eruby', 'slim', 'jade', 'scss', 'less', 'css', 'html', 'xhtml']
            \}

let g:syntastic_c_compiler = 'gcc'
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_c_compiler_options = '-std=c11 -Wall'
let g:syntastic_cpp_compiler_options = '-std=c++14 -Wall'


" Ctrl + ]
nmap <c-]> g<c-]>
vmap <c-]> g<c-]>

" Ctrl + U
imap <c-u> <c-x><c-o>

" Ctrl + H
imap <c-h> <esc>I
map <c-h> <c-w><c-h>

"Ctrl + J
imap <c-j> <esc><down>I
map <c-j> <c-w><c-j>

" Ctrl + K
imap <c-k> <esc><up>A
map <c-k> <c-w><c-k>

" Ctrl + L
imap <c-l> <esc>A
map <c-l> <c-w><c-l>

" \c
vmap <leader>c "+y

" \a
nmap <leader>a <esc>ggVG"+y<esc>

" \v
imap <leader>v <esc>"+p
nmap <leader>v "+p
vmap <leader>v "+p

" \bb
nmap <leader>bb :Tab /=<cr>

" \bn
nmap <leader>bn :Tab /

" \tl
nmap <leader>tl :TagbarToggle<cr><c-w><c-l>

" \rb
imap <leader>rb <esc>:let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>
nmap <leader>rb :let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>
vmap <leader>rb <esc>:let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>

" \rm
imap <leader>rm <esc>:%s/<c-v><c-m>//g<cr>
nmap <leader>rm :%s/<c-v><c-m>//g<cr>
vmap <leader>rm <esc>:%s/<c-v><c-m>//g<cr>

" \rt
func! RemoveTabs()
    if &shiftwidth == 2
        exec '%s/	/  /g'
    elseif &shiftwidth == 4
        exec '%s/	/    /g'
    elseif &shiftwidth == 6
        exec '%s/	/      /g'
    elseif &shiftwidth == 8
        exec '%s/	/        /g'
    else
        exec '%s/	/ /g'
    end
endfunc

imap <leader>rt <esc>:call RemoveTabs()<cr>
nmap <leader>rt :call RemoveTabs()<cr>
vmap <leader>rt <esc>:call RemoveTabs()<cr>

" \ra
nmap <leader>ra <esc>\rt<esc>\rb<esc>gg=G<esc>gg<esc>

func! Compile_Run_Code()
    exec 'w'
    if &filetype == 'c'
        exec '!gcc -Wall -std=c11 -o %:r %:t && %:r'
    elseif &filetype == 'cpp'
        exec '!g++ -Wall -std=c++14 -o %:r %:t && %:r'
    elseif &filetype == 'rust'
        exec '!rustc %:t && ./%:r'
    elseif &filetype == 'go'
        exec '!go build %:t && ./%:r'
    elseif &filetype == 'nim'
        exec '!nim c %:t && ./%:r'
    elseif &filetype == 'java'
        exec '!javac %:t && java %:r'
    elseif &filetype == 'scala'
        exec '!scala %:t'
    elseif &filetype == 'erlang'
        exec '!escript %:t'
    elseif &filetype == 'elixir'
        exec '!elixir %:t'
    elseif &filetype == 'scheme' || &filetype == 'racket'
        exec '!racket -fi %:t'
    elseif &filetype == 'lisp'
        exec '!sbcl --load %:t'
    elseif &filetype == 'haskell'
        exec '!ghc -o %:r %:t && ./%:r'
    elseif &filetype == 'lua'
        exec '!lua %:t'
    elseif &filetype == 'perl'
        exec '!perl %:t'
    elseif &filetype == 'php'
        exec '!php %:t'
    elseif &filetype == 'python'
        exec '!python3 %:t'
    elseif &filetype == 'javascript'
        exec '!node %:t'
    elseif &filetype == 'typescript'
        exec '!tsc %:t && node %:r.js'
    elseif &filetype == 'sh'
        exec '!bash %:t'
    endif
endfunc

" \rr
imap <leader>rr <esc>:call Compile_Run_Code()<cr>
nmap <leader>rr :call Compile_Run_Code()<cr>
vmap <leader>rr <esc>:call Compile_Run_Code()<cr>



" mapping
map gG Go
imap <C-c> <Esc>:
imap <C-z> <Esc>
map pO O<Esc> 
map po o<Esc> 

function! PerlMap()
    inoremap <buffer> { {}<Esc>i
    inoremap <buffer> ( ()<Esc>i
    inoremap <buffer> [ []<Esc>i
endfunction

function! CppMap()
   let $VIM_STYLE = "c"
   set colorcolumn=80
   imap <buffer> #d #define
   imap <buffer> #ifd #ifdef 
   imap <buffer> #ifn #ifndef
   imap <buffer> #en #endif
   imap <buffer> #inc #include <><Esc>i
   inoremap <buffer> #imc #include ""<Esc>i
   imap <buffer> @i if(
   imap <buffer> @str struct 
   imap <buffer> @ty typedef
   imap <buffer> @w while(
   imap <buffer> @f for(
   imap <buffer> @r return 
   inoremap <buffer> #head int main( int argc, char **argv ) {<CR><Tab><CR>return 0;<CR><Esc>0i}<Esc>2ki
    inoremap <buffer> { {}<Esc>i
    inoremap <buffer> ( ()<Esc>i
    inoremap <buffer> [ []<Esc>i
   ""set dictionary=/usr/share/vim/vim74/dict/c.txt/
endfunction

function! CMap()
   let $VIM_STYLE = "c"
   set colorcolumn=80
   imap <buffer> #d #define
   imap <buffer> #ifd #ifdef 
   imap <buffer> #ifn #ifndef
   imap <buffer> #en #endif
   imap <buffer> #inc #include <.h><Esc>2hi
   inoremap <buffer> #imc #include ".h"<Esc>2hi
   imap <buffer> @i if(
   imap <buffer> @str struct 
   imap <buffer> @ty typedef
   imap <buffer> @w while(
   imap <buffer> @f for(
   imap <buffer> @r return 
   inoremap <buffer> #head int main( int argc, char **argv ) {<CR><Tab><CR>return 0;<CR><Esc>0i}<Esc>2ki
   inoremap <buffer> { {}<Esc>i
   inoremap <buffer> ( ()<Esc>i
   inoremap <buffer> [ []<Esc>i
   ""set dictionary=/usr/share/vim/vim74/dict/c.txt/
endfunction
       

function! JavaMap()
   set colorcolumn=120
   imap <buffer> @r return
   imap <buffer> @w while(
   imap <buffer> @imp import
   imap <buffer> @int interface
   imap <buffer> @iml implements
   imap <buffer> @ex extends 
   imap <buffer> @s static
   imap <buffer> @pu public
   imap <buffer> @pro protected
   imap <buffer> @pri private
   imap <buffer> @pac package
   imap <buffer> @c class
   imap <buffer> @vo void
   imap <buffer> @St String
   inoremap <buffer> @head public static void main( String[] args ){<CR>}<Esc>O<Tab>
   inoremap <buffer> { {}<Esc>i
   inoremap <buffer> ( ()<Esc>i
   inoremap <buffer> [ []<Esc>i
endfunction

function! JSMap()
   imap <buffer> @fu function 
   inoremap <buffer> { {}<Esc>i
    inoremap <buffer> ( ()<Esc>i
    inoremap <buffer> [ []<Esc>i
endfunction

function! SHMap()
    inoremap <buffer> { {}<Esc>i
    inoremap <buffer> ( ()<Esc>i
    inoremap <buffer> [ []<Esc>i
endfunction

au FileType c       call CMap()
au FileType h       call CMap()
au FileType cpp     call CppMap()
au FIleType hpp     call CppMap()
au FileType java    call JavaMap()
au FileType perl    call PerlMap()
au FileType sh      call SHMap()
au FileType javascript call JSMap()

let g:syntastic_asm_checkers = []

au BufEnter * silent loadview
au BufLeave * mkview

au BufNewFile *.pl s/$/#!\/bin\/perl\r\ruse v5.10;\ruse strict;\ruse warnings;\r\r / | 7
au BufNewFile *.pm s/$/use v5.10;\ruse strict;\ruse warnings;\r\r/ | 5
au BufNewFile *.sed s/$/#!\/usr\/bin\/sed -nf\r\r/ | 3   
au BufNewFile *.sh  s/$/#!\/usr\/bin\/bash\r\r/ | 3
au BufNewFile *.h s/$/#pragma once\r\r/ | 4
