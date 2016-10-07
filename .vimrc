syntax enable

" Spaces & Tabs
set autoindent
set shiftwidth=4    " number of spaces to use for autoindenting
set tabstop=4	    " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
" Display tabs and trailing spaces visually
set list listchars=tab:>-,trail:·

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set textwidth=80

set showmatch       " set show matching parenthesis

" Use UTF-8 as the default text encoding
set encoding=utf-8

" UI Config
set number
" set cursorline      " highlight current line
set wildmenu        " visual autocomplete for command menu
set visualbell      " Use visual bell instead of beeping when doing something wrong

" Searching
set incsearch       " search as characters are entered
set hlsearch        " highlight matches

set mouse=a
