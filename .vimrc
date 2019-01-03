" @vundle {{{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdtree'
Plugin 'https://github.com/majutsushi/tagbar.git'
Plugin 'VundleVim/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
call vundle#end()
filetype plugin indent on
" }}}
" @fzf {{{
set rtp+=~/.fzf
" }}}
" @gitgutter {{{
let g:gitgutter_max_signs = 500  " default value
"}}}
" @nerdtree {{{
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1

" open NERDTree automatically when vim starts up with no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}
" @youcompleteme {{{
let g:ycm_auto_trigger=1
let g:ycm_add_preview_to_completeopt=1
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.', 're![a-zA-Z][a-zA-Z0-9]'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::', 're![a-zA-Z][a-zA-Z0-9]'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }

nnoremap ga :YcmCompleter GoToDeclaration<CR>
nnoremap gs :YcmCompleter GoToDefinition <CR>
nnoremap gd :YcmCompleter GetType<CR>
imap <c-a> <C-o>:YcmCompleter GoToDeclaration<CR>
imap <c-s> <C-o>:YcmCompleter GoToDefinition<CR>
imap <c-d> <C-o>:YcmCompleter GetType<CR>

" inoremap <silent><expr> ( complete_parameter#pre_complete("()")
" smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" }}}
" @ultisnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-f>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
let g:airline_section_b = '%{strftime("%Y/%m/%d %H:%M:%S")}'

" @vimset {{{
syntax on
color zellner

let line='normal'
set number

set expandtab
set sts=4 sw=4 ts=4
autocmd FileType html set sts=2 sw=2 ts=2

" @serach
set hls
set incsearch
set ignorecase

set fileencodings=utf-8,gb2312,gbk,gb18030

" @folder
set foldcolumn=4
set foldenable
set foldlevel=100
set foldmethod=marker

" @mouse
set mouse=a
set selection=exclusive
set selectmode=mouse,key

set title
set backupcopy=yes
set backspace=indent,eol,start
set clipboard=unnamed
set autochdir
set autoindent
set nobackup
set pastetoggle=``
set shortmess=atl
set ttyfast
" }}}
" @shortcut {{{
:command W w
:command WQ wq
:command Wq wq
:command Q q

nmap <F2> ggVGy
nmap <c-e> :call SwitchNum()<CR>
nmap <F4> :Commentary<CR>

nmap <F5> :NERDTreeToggle<CR>
nmap <F6> :TagbarToggle<CR>
nmap <F7> gg=G
map <F9>      : call CompileDebug()<CR>
map <F8>      : call CompileRelease()<CR>
map <F10>     : call Run()<CR>

nmap <s-tab> <<
nmap <tab> >>
" }}}

function SwitchNum() " {{{
    if &rnu == 1
        exec ':set nornu'
    else
        exec ':set rnu'
    endif
endfunc
" }}}

function CompileDebug() " {{{
    exec "w"
    if &filetype == "c" || &filetype == "h"
        exec ":! clear; gcc % -o %:r -Wall -DDEBUG -DLOCAL; if [ $? = 0 ]; then echo '\033[1;32;m[SUC] Compile (debug) Succeed..\033[0m'; else echo '\033[1;31;m[ERR] Compile (debug) Error..\033[0m'; fi;"
    elseif &filetype == "cpp" || &filetype == "hpp"
        exec ":! clear; g++ % -o %:r -Wall -DDEBUG -DLOCAL; if [ $? = 0 ]; then echo '\033[1;32;m[SUC] Compile (debug) Succeed..\033[0m'; else echo '\033[1;31;m[ERR] Compile (debug) Error..\033[0m'; fi;"
    elseif &filetype == "python"
        exec ":! clear; python3 %"
    elseif &filetype == "sh"
        exec ":! chmod +x %"
    endif
endfunction
" }}}
function CompileRelease() " {{{
    exec "w"
    if &filetype == "c" || &filetype == "h"
        exec ":! clear; gcc % -o %:r -Wall -DRELEASE -DLOCAL; if [ $? = 0 ]; then echo '\033[1;32;m[SUC] Compile (release) Succeed..\033[0m'; else echo '\033[1;31;m[ERR] Compile (release) Error..\033[0m'; fi;"
    elseif &filetype == "cpp" || &filetype == "hpp"
        exec ":! clear; g++ % -o %:r -Wall -DRELEASE -DLOCAL; if [ $? = 0 ]; then echo '\033[1;32;m[SUC] Compile (release) Succeed..\033[0m'; else echo '\033[1;31;m[ERR] Compile (release) Error..\033[0m'; fi;"
    elseif &filetype == "python"
        exec ":! clear; python3 %"
    elseif &filetype == "sh"
        exec ":! chmod +x %"
    endif
endfunction
" }}}
function Run() " {{{
    if &filetype == "cpp" || &filetype == "c" 
        exec ":! clear; ./%:r;"
    elseif &filetype == "sh"
        exec ":! clear; ./%"
    elseif &filetype == "python"
        exec ":! clear; python3 %"
    endif
endfunction
" }}}
