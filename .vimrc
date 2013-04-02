" better mapping of noh
" Learn vim.rails

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized.git'
Bundle 'godlygeek/tabular.git'
Bundle 'jmcantrell/vim-virtualenv.git'
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'kien/ctrlp.vim.git'
Bundle 'myusuf3/numbers.vim.git'
Bundle 'tpope/vim-haml.git'
Bundle 'tpope/vim-rails.git'

" ---------------------
" --- Basic Options ---
" ---------------------

filetype plugin indent on         " required
syntax enable                     " Turn on syntax highlighting.
set autoindent                    " Next line has same indentation as previous line
set backspace=indent,eol,start    " Intuitive backspacing.
set clipboard=unnamed             " Allow yank etc to work with the OS X clipboard
set directory=/tmp/               " Set temporary directory (don't litter local dir with swp/tmp files)
set encoding=utf-8                " Use UTF-8 everywhere
set nojoinspaces                  " Remove double spaces when joining lines
set number                        " Show line numbers
set ruler                         " Show cursor position
set scrolloff=5                   " Show 5 lines of context around the cursor
set showmode                      " Display the mode you're in
set hidden                        " Allow switching buffers without saving
set wildignore=*.pyc,*.sqlite3,*.db                          " Databases
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.ico               " Images
set wildignore+=*.eot,*.svg,*.ttf,*.woff                     " Fonts
set wildignore+=*.DS_Store                                   " OS X
set wildignore+=.git,.gitkeep                                " Version control
set wildignore+=tags,*.log,tmp                               " Misc
set wildmenu                      " Enhanced command line completion
set wildmode=list:longest         " Complete files like a shell

" hide pyc files in netrw
let g:netrw_list_hide= '.*\.pyc$'

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
catch /^Vim\%((\a\+)\)\=:E185/
    " Silently catch error - This is purely for installation
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
set textwidth=0                  " Maximum width of text
if exists("&colorcolumn")
  set colorcolumn=80              " Set coloured column at 80 characters
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
" --- Custom autocommands ---
" ---------------------------

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78

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

" doesn't seem to work properly. Maybe delete this as we can just use esc when
" multi-line editing.
"imap <c-c> <esc> " Also map caps lock to ctrl.
imap jj <esc>


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

" Because I keep hitting :W
command! W :w

" Quick close html tags
imap <leader>c </<C-X><C-O><esc>F<i

" ----------------------------
" --- Multipurpose tab key ---
" --- Indent if we're at the beginning of a line. Else, do completion.
" ----------------------------

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Remove trailing whitespace on save for ruby files.
au BufWritePre *.rb :%s/\s\+$//e

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=black

" --------------------------
" --- Rails Key Mappings ---
" --------------------------

" Annotate models
:map <leader>a :!.bin/annotate<cr>

" ------------------------------
" --- ctrlp.vim configuration --
" ------------------------------

let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = '\.bin$\|bin$\|vendor\/bundle$\|vendor\/gems$'
"let g:ctrlp_custom_ignore = '\.bin$\|vendor\/bundle$'
nnoremap <c-b> :CtrlPBuffer<CR>
"nnoremap <leader>. :CtrlPTag<cr>

" --------------------
" --- Omnicomplete ---
" --------------------

"inoremap <C-space> <C-x><C-o>
"autocmd FileType ruby set omnifunc=rubycomplete#Complete
"autocmd FileType ruby let g:rubycomplete_buffer_loading=1
"autocmd FileType ruby let g:rubycomplete_classes_in_global=1
autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" ---------------------------
" --- Custom indentations ---
" ---------------------------

autocmd BufRead,BufNewFile *.js,*.js.coffee,*.coffee,*.js.erb,*.html,*.rb set tabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
set filetype=html.javascript

" ------------------------
" --- Custom FileTypes ---
" ------------------------

autocmd BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" -------------------------
" --- Ctags and Taglist ---
" --------------------------

set tags=tags;/                                  " Search for tag file
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>   " Update tags
let Tlist_WinWidth = 70                          " Window width
let Tlist_Show_One_File = 1                      " Show tags for current buffer
let Tlist_Exit_OnlyWindow = 1                    " Allow exit if only taglist
map T :TlistToggle<CR><c-w><c-w>

" --------------
" --- MacVim ---
" ---------------

if has("gui_running")
  set guioptions-=m
  set guioptions-=T
endif

" --------------------------------------------------------------
" --- Use Ack for multi-file search. Simplified from ack.vim ---
" --------------------------------------------------------------

let g:ackprg="ack -H --nocolor --nogroup --column"
let g:ackhighlight=1
let g:ackformat="%f:%l:%c:%m"
function! s:Ack(cmd, args, ...)
  redraw
  echo "Searching ..."

  " If no pattern is provided, search for the word under the cursor
  if empty(a:args)
    let l:grepargs = expand("<cword>")
  else
    let l:grepargs = a:args . join(a:000, ' ')
  end

  " Execute search
  let &grepprg=g:ackprg
  let &grepformat=g:ackformat
  silent execute a:cmd . " " . escape(l:grepargs, '|')
  botright copen

  " Highlight the search keyword.
  let @/=a:args
  set hlsearch

  redraw!
endfunction
command! -bang -nargs=* -complete=file Ack call s:Ack('grep<bang>',<q-args>)

" --------------------------------------------
" --- Rename current file - Gary Berhnardt ---
" --------------------------------------------

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

" ------------------------------------------------------
" --- Test runnner - Ben Orenstein & Gary Bernhardt ---
" ------------------------------------------------------

map <Leader>t :call RunCurrentTest()<CR>
map <Leader>o :call RunCurrentLineInTest()<CR>

function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()
    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      "call SetTestRunner("!ruby -Itest")
      call SetTestRunner("!zeus test")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end
  exec "!rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

" --- End test runnner ---

" ----------------------------------------
" --- Inline variable - Gary Bernhardt ---
" ----------------------------------------

function! InlineVariable()
    " Copy the variable under the cursor into the 'a' register
    :let l:tmp_a = @a
    :normal "ayiw
    " Delete variable and equals sign
    :normal 2daW
    " Delete the expression into the 'b' register
    :let l:tmp_b = @b
    :normal "bd$
    " Delete the remnants of the line
    :normal dd
    " Go to the end of the previous line so we can start our search for the
    " usage of the variable to replace. Doing '0' instead of 'k$' doesn't
    " work; I'm not sure why.
    normal k$
    " Find the next occurence of the variable
    exec '/\<' . @a . '\>'
    " Replace that occurence with the text we yanked
    exec ':.s/\<' . @a . '\>/' . @b
    :let @a = l:tmp_a
    :let @b = l:tmp_b
endfunction
nnoremap <leader>ri :call InlineVariable()<cr>

