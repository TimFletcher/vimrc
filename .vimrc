set nocompatible               " be iMproved filetype off                   " required!
filetype off                   " Added 30th Oct 2014

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Plugin 'pangloss/vim-javascript'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'kien/ctrlp.vim.git'
Plugin 'nvie/vim-flake8.git'
Plugin 'tpope/vim-surround.git'
Plugin 'kchmck/vim-coffee-script'
Plugin 'Shutnik/jshint2.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Slava/vim-spacebars'

" ---------------------
" --- Basic Options ---
" ---------------------

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " required
set autoindent                    " Next line has same indentation as previous line
set backspace=indent,eol,start    " Intuitive backspacing.
set clipboard=unnamed             " Allow yank etc to work with the OS X clipboard
set directory=/tmp/               " Set temporary directory (don't litter local dir with swp/tmp files)
set encoding=utf-8                " Use UTF-8 everywhere
set nojoinspaces                  " Remove double spaces when joining lines
set number                        " Show line numbers
"set relativenumber                " Show relative line numbers
set ruler                         " Show cursor position
set scrolloff=5                   " Show 5 lines of context around the cursor
set showmode                      " Display the mode you're in
set hidden                        " Allow switching buffers without saving
set history=1000                  " Keep long command history
set wildignore=*.pyc,*.sqlite3,*.db                          " Databases
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.ico               " Images
set wildignore+=*.eot,*.svg,*.ttf,*.woff                     " Fonts
set wildignore+=*.DS_Store                                   " OS X
set wildignore+=.git,.gitkeep                                " Version control
set wildignore+=tags,*.log,tmp                               " Misc
set wildmenu                      " Enhanced command line completion
set wildmode=list:longest         " Complete files like a shell
set exrc                          " enable per-directory .vimrc files
set secure                        " disable unsafe commands in local .vimrc files

" Don't write backups as this sends multiple save events which can cause issues when compiling sass on save
" http://stackoverflow.com/questions/10300835/too-many-inotify-events-while-editing-in-vim#comment13284176_10300881
set nowritebackup

" hide files in netrw
let g:netrw_list_hide= '.*\.pyc$,.DS_Store,^tags$,\.sass-cache,htmlcov'

set shell=bash\ -l                " Source ~/.profile for :sh
set noesckeys                     " Get rid of the delay when hitting esc!
"set shell=bash                    " This makes RVM work inside Vim. I have no idea why.
"set nofoldenable " Say no to code folding...

" Tabs/Spaces
set expandtab                     " Use spaces instead of tabs
set shiftwidth=4                  " Width of > and < commands in visual mode
set softtabstop=4                 " Backspace in insert mode removes X spaces
set tabstop=4                     " Global tab width - Affects tabs already in a file.

" Color
set background=dark
try
    color solarized
catch /^Vim\%((\a\+)\)\=:E185/    " Silently catch error so we can run vim before the scheme is installed.
endtry

" Searching
set ignorecase                    " do all searches in lowercase...
set smartcase                     " ...unless there's uppercase characters
set incsearch                     " Highlight search patterns while typing
set showmatch                     " Jump to show matching brackets
set hlsearch                      " Highlight previous search pattern

" Soft/Hard Wrapping
set nowrap                        " Do not wrap on window width
set linebreak                     " Don't break words to wrap
set nolist
set wrapmargin=0
set textwidth=0                   " Maximum width of text
if exists("&colorcolumn")
  set colorcolumn=79              " Set coloured column at 100 characters
endif

" Tabstops and EOLs
set list
set listchars=tab:›\ ,eol:¬ " mark trailing white space

" Status line
set laststatus=2                               " Always show the status line
set statusline=\ %f%m%r%h\ %w\ Line:\ %l/%L:%c " Customise the status line

" Leader Key
let mapleader = ","

" ---------------------------
" --------- Plugins ---------
" ---------------------------

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" CtrlP.vim
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.bin$\|bin$\|\.sass-cache$\|\.css$\|htmlcov$\|vendor\/bundle$\|vendor\/gems$\|node_modules|\.staticfiles|\.staticgen$'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:25'
nnoremap <c-b> :CtrlPBuffer<CR>

" Flake8
let g:flake8_ignore="E501"                 " Ignore line length PEP* errors

" JSHint
nnoremap <silent><F7> :JSHint<CR>
inoremap <silent><F7> <C-O>:JSHint<CR>
vnoremap <silent><F7> :JSHint<CR>

" ---------------------------
" --- Custom autocommands ---
" ---------------------------

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  "autocmd FileType text setlocal textwidth=78

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  "autocmd! BufRead,BufNewFile *.sass setfiletype sass 

  "autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  "autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

" --------------------
" --- Key Mappings ---
" --------------------

" Disable ctrl + c
imap <c-c> <Nop>

" Clear the search buffer on hitting return
function! MapCR()
  nnoremap <leader><leader> :nohlsearch <cr>
endfunction
call MapCR()

function! CloseQuickFix()
  nnoremap cl :ccl <cr>
endfunction
call CloseQuickFix()

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Jump 10 lines up and down
nnoremap <c-k> 10k
nnoremap <c-j> 10j

" Because I keep hitting :W
command! W :w

" Quick close html tags
imap <leader>c </<C-X><C-O><esc>F<i

" Quick save
nmap <leader>w :w<cr>

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=black

" Remove all trailing whitespace
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
:map ,tw :call TrimWhiteSpace()<cr>

" --------------------------
" --- Rails Key Mappings ---
" --------------------------

" Annotate models
:map <leader>a :!.bin/annotate<cr>

" ------------------------------------------------------------------------
" --- Key command to toggle between absolute and relative line numbers ---
" ------------------------------------------------------------------------

"function! NumberToggle()
"  if(&relativenumber == 1)
"    set number
"  else
"    set relativenumber
"  endif
"endfunc
"
"nnoremap <C-n> :call NumberToggle()<cr>

" ---------------------------
" --- Custom indentations ---
" ---------------------------

autocmd BufRead,BufNewFile *.js,*.js.coffee,*.coffee,*.js.erb,*.html,*.rb,*.css,*.scss set tabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" ------------------------
" --- Custom FileTypes ---
" ------------------------

autocmd BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set filetype=ruby
autocmd BufRead,BufNewFile *.html set filetype=html.htmldjango
autocmd BufRead,BufNewFile *.scss set filetype=scss.css

" -------------------------
" --- Ctags and Taglist ---
" --------------------------

" Search for tag file
set tags=tags;/

" Ctags should include the virtualenv's site-packages and src directories
map <F1> :!ctags -R -f ./tags --exclude=node_modules . $VIRTUAL_ENV/lib/python3.4/site-packages $VIRTUAL_ENV/lib/python2.7/site-packages $VIRTUAL_ENV/src vendor/bundle/gems<CR>

" Show window to choose when there are multiple matches for a tag - http://stackoverflow.com/a/3614824/453405
nnoremap <C-]> :execute 'tj' expand('<cword>')<CR>zv "

" --------------
" --- MacVim ---
" ---------------

if has("gui_running")
  set guioptions-=m
  set guioptions-=T
endif

" -----------------
" --- rspec.vim ---
" -----------------

"let g:rspec_command = "!bundle exec rspec {spec} --format documentation"

" RSpec.vim mappings
"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>

" ---------------------------------------------------------
" --- Use ag (The Silver Searcher) for multi-file search
" ---------------------------------------------------------

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ack silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ack<SPACE>

" ------------------------
" --- Run Django tests ---
" ------------------------

function! GetModule()
  let l:module = substitute(expand("%"), "/", ".", "g")
  let l:module = substitute(l:module, ".py", "", "")
  return l:module
endfunction

function! MapDjangoTest()
  let l:module = GetModule()
  let l:command = "!django-admin.py test --settings=`echo $DJANGO_TEST_SETTINGS_MODULE` {module}"
  let g:test_command = substitute(l:command, "{module}", l:module, "g")
endfunction

function! RunDjangoTest()
  execute g:test_command
endfunction

map <Leader>m :call MapDjangoTest()<CR>
map <Leader>t :call RunDjangoTest()<CR>
