" A Minimal VIMRC

" Some parts taken from tpope/vim-sensible, some parts are just
" from my main config.

if &compatible
  se nocompatible
en

" More readable than the default colourscheme
colorscheme pablo
" Other good options inculde:
" - Torte (just not as nice comment colour as pablo)
" - Murphy (sadly no current pane highlight colour, but nicest colours)
" - Slate (not as clear pane highlighting)
" - Elflord (not as nice comment colour and not as clear pane highlighting)

sy on                             " syntax on
se backspace=indent,eol,start     " backspace, behave
se complete-=i                    " set the match for insert mode completition
se enc=utf8                       " file encoding
se history=1000                   " command (:) hist
se ls=2                           " last status = 2 (always)
se mouse=                         " mouse (default)
se noeb vb t_vb=                  " no error bells
se nosm                           " matching bracket on insert
se nosol                          " jump to rough current cursor position
se noswapfile                     " yep
se nrformats-=octal               " ctrl+a and ctrl+x to increment/decrement
se ru                             " ruler (coords in bar) on
se scrolloff=3                    " vertical scroll padding
se shm=a                          " avoid all 'hit enter to continue'
se tf                             " better xterm mainly experience
se title                          " title bar title (content below)
se ttimeout                       " ttimeout and...
se ttimeoutlen=100                " used to speed up vim a little
se wmnu                           " wild menu; better command line completition

" Window title
se titlestring=file:\ %t%(\ %M%)%(\ (path:\ %{expand(\"%:~:.:h\")})%)%(\ %a%)

" Line numbers
se number
se relativenumber

" I like colour column
se colorcolumn=81
hi ColorColumn ctermbg=darkgrey

" Search
se hlsearch
se ic
se incsearch
se showmatch

" Remove trailing spaces on save
aug RTS
  au!
  au BufWritePre * :%s/\s\+$//e
aug END

" Tab stuff
se smarttab
se listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
se ts=2 shiftwidth=2 et
vn <tab> >vgv
vn <s-tab> <vgv

" Visual hjkl
nn j gj
nn k gk

" Signature iabbrev
let gcfg = "git config --global "
iab <expr> ~g substitute(system
\(gcfg . 'user.name') . " <" . system(gcfg . 'user.email') . ">", '\n', '', 'g')

" This is a few Vim Sensible options
se display+=lastline
if has('patch-7.4.2109')
  se display+=truncate
en

if v:version > 703 || v:version == 703 && has("patch541")
  se formatoptions+=j
en

if has('path_extra') && (',' . &g:tags . ',') =~# ',\./tags,'
  setg tags-=./tags tags-=./tags; tags^=./tags;
en

if !empty(&viminfo)
  se viminfo^=!
en

se sessionoptions-=options
se viewoptions-=options

if &t_Co == 8 && $TERM !~# '^Eterm'
  se t_Co=16
en

if !exists('g:is_posix')
  \&& !exists('g:is_bash')
  \&& !exists('g:is_kornshell')
  \&& !exists('g:is_dash')
  let g:is_posix = 1
en

if !exists('g:loaded_matchit')
  \&& findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
en

if exists(':Man') != 2 && !exists('g:loaded_man')
  \&& &filetype !=? 'man' && !has('nvim')
  runtime ftplugin/man.vim
en

