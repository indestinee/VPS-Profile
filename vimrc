set nocompatible
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf

call vundle#begin()
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'iamcco/markdown-preview.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'https://github.com/majutsushi/tagbar.git'
Plugin 'VundleVim/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
" Plugin 'kien/ctrlp.vim'
" Plugin 'vim-scripts/TaskList.vim'
" Plugin 'SirVer/ultisnips'
" Plugin 'python-mode/python-mode'
call vundle#end()            " required

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


let g:ycm_add_preview_to_completeopt=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

nnoremap ga :YcmCompleter GoToDeclaration<CR>
nnoremap gs :YcmCompleter GoToDefinition <CR>
nnoremap gd :YcmCompleter GetType<CR>

filetype plugin indent on    " required
syntax on
color zellner
set autochdir
set hls
set autoindent
set title
set backupcopy=yes
set backspace=indent,eol,start
set clipboard=unnamed
set expandtab
set foldcolumn=4
set foldenable
set foldlevel=100
set foldmethod=marker
set ignorecase
set incsearch
set mouse=a
set nobackup
set nocompatible
set number
set pastetoggle=``
set selection=exclusive
set selectmode=mouse,key
set sw=4
set shortmess=atl
set showcmd
set showmode
set smartindent
set sts=4
set ts=4
set ttyfast
set fileencodings=utf-8,gb2312,gbk,gb18030
:command W w
:command WQ wq
:command Wq wq
:command Q q

let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1

nmap <F2> ggVGy
map <F3>      : call SetTemplate()<CR>
map <leader>lc   : call SetLCTemplate()<CR>
nnoremap <F4> :Commentary<CR>
nnoremap <silent> <F5> :NERDTree<CR>
nmap <F6> :TagbarToggle<CR>
nmap <F7> gg=G

map <F9>      : call CompileDebug()<CR>
map <F8>      : call CompileRelease()<CR>
map <F10>     : call Run()<CR>

nmap <s-tab> <<
nmap <tab> >>

function CompileDebug()
    exec "w"
    if findfile("Makefile", ".") == "Makefile"
        exec ":! clear; make; if [ $? = 0 ]; then echo '[SUC] Makefile done..'; else echo '[ERR] Makefile failed..'; fi;"
    elseif &filetype == "c" || &filetype == "h"
        exec ":! clear; gcc-8 % -o %:r -Wall -DDEBUG -DLOCAL; if [ $? = 0 ]; then echo '[SUC] Compile (debug) Succeed..'; else echo '[ERR] Compile (debug) Error..'; fi;"
    elseif &filetype == "cpp" || &filetype == "hpp"
        exec ":! clear; g++-8 % -o %:r -Wall -DDEBUG -DLOCAL; if [ $? = 0 ]; then echo '[SUC] Compile (debug) Succeed..'; else echo '[ERR] Compile (debug) Error..'; fi;"
    elseif &filetype == "python"
        exec ":! clear; python3 %"
    elseif &filetype == "sh"
        exec ":! chmod +x %"
    endif
endfunction


function CompileRelease()
    exec "w"
    if &filetype == "c" || &filetype == "h"
        exec ":! clear; gcc-8 % -o %:r -Wall -DRELEASE -DLOCAL; if [ $? = 0 ]; then echo '[SUC] Compile (release) Succeed..'; else echo '[ERR] Compile (release) Error..'; fi;"
    elseif &filetype == "cpp" || &filetype == "hpp"
        exec ":! clear; g++-8 % -o %:r -Wall -DRELEASE -DLOCAL; if [ $? = 0 ]; then echo '[SUC] Compile (release) Succeed..'; else echo '[ERR] Compile (release) Error..'; fi;"
    elseif &filetype == "python"
        exec ":! clear; python3 %"
    elseif &filetype == "sh"
        exec ":! chmod +x %"
    endif
endfunction

function Run()
    if &filetype == "cpp" || &filetype == "c" 
        exec ":! clear; auto_run ./%:r;"
    elseif &filetype == "sh"
        exec ":! clear; ./%"
    elseif &filetype == "python"
        exec ":! clear; auto_run python3 %"
    endif
endfunction

function SetTemplate()
    exec ":%d"
    let l = 0
    let l = l + 1 | call setline(l, '/*')
    let l = l + 1 | call setline(l, ' *  Author:')
    let l = l + 1 | call setline(l, ' *      indestinee')
    let l = l + 1 | call setline(l, ' *  Date:')
    let l = l + 1 | call setline(l, ' *      '.strftime('%Y/%m/%d'))
    let l = l + 1 | call setline(l, ' *  Name:')
    let l = l + 1 | call setline(l, ' *      '.expand('%'))
    let l = l + 1 | call setline(l, ' */')
    let l = l + 1 | call setline(l, '')
    let l = l + 1 | call setline(l, '#include <bits/stdc++.h>')
    let l = l + 1 | call setline(l, 'using namespace std;')
    let l = l + 1 | call setline(l, '')
    let l = l + 1 | call setline(l, 'int main() {')
    let l = l + 1 | call setline(l, '')
    let l = l + 1 | call setline(l, '')
    let l = l + 1 | call setline(l, '    return 0;')
    let l = l + 1 | call setline(l, '}')
endfunc

function SetLCTemplate()
    exec ":%d"
    let l = 0
    let l = l + 1 | call setline(l, '/*')
    let l = l + 1 | call setline(l, ' *  Author:')
    let l = l + 1 | call setline(l, ' *      indestinee')
    let l = l + 1 | call setline(l, ' *  Date:')
    let l = l + 1 | call setline(l, ' *      '.strftime('%Y/%m/%d'))
    let l = l + 1 | call setline(l, ' *  Name:')
    let l = l + 1 | call setline(l, ' *      '.expand('%'))
    let l = l + 1 | call setline(l, ' */')
    let l = l + 1 | call setline(l, '')
    let l = l + 1 | call setline(l, '#include <bits/stdc++.h>')
    let l = l + 1 | call setline(l, 'using namespace std;')
    let l = l + 1 | call setline(l, '')
    let l = l + 1 | call setline(l, '#ifdef LOCAL')
    let l = l + 1 | call setline(l, 'int main() {')
    let l = l + 1 | call setline(l, '')
    let l = l + 1 | call setline(l, '')
    let l = l + 1 | call setline(l, '    return 0;')
    let l = l + 1 | call setline(l, '}')
    let l = l + 1 | call setline(l, '#endif')
endfunc

