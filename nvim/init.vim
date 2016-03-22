"         __         __          _
"        / /  _ __   \ \  __   _(_)_ __ ___  _ __ ___
"       | |  | '_ \   | | \ \ / / | '_ ` _ \| '__/ __|
"    _  | |  | | | |  | |  \ V /| | | | | | | | | (__
"   (_) | |  |_| |_|  | |   \_/ |_|_| |_| |_|_|  \___|
"        \_\         /_/
"
" Author: Richard de Wit
" Repo:   https://github.com/richarddewit/.dotfiles/nvim/init.vim


" Setup NeoBundle  ---------------------------------------------------------{{{
" If NeoBundle is not installed, do it first

  let bundleExists = 1
  if (!isdirectory(expand("$HOME/.nvim/bundle/neobundle.vim")))
     call system(expand("mkdir -p $HOME/.nvim/bundle"))
     call system(expand("git clone https://github.com/Shougo/neobundle.vim ~/.nvim/bundle/neobundle.vim"))
     let bundleExists = 0
  endif


  if 0 | endif

  if has('vim_starting')
    if &compatible
      " Be iMproved
      set nocompatible
    endif

" Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    set runtimepath+=~/.vim/bundle/bolt.vim/
  endif
  filetype off

" Required:
  call neobundle#begin(expand('~/.nvim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
  NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

" Packages  ----------------------------------------------------------------{{{
" Colorscheme & visual stuff
  NeoBundle 'mhartington/oceanic-next'
  NeoBundle 'Yggdroot/indentLine'
  NeoBundle 'Raimondi/delimitMate'
  NeoBundle 'valloric/MatchTagAlways'
  NeoBundle 'vim-airline/vim-airline-themes'
  NeoBundle 'vim-airline/vim-airline'


" VSC
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'mhinz/vim-signify'
  NeoBundle 'ludovicchabant/vim-lawrencium'


" Languages
" HTML
  NeoBundle 'mattn/emmet-vim'
" JavaScript
  NeoBundle 'mxw/vim-jsx'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'moll/vim-node'
  NeoBundle 'kchmck/vim-coffee-script'
" CSS
  NeoBundle 'csscomb/vim-csscomb'
  NeoBundle 'hail2u/vim-css3-syntax'
  NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload':{'filetypes':['scss','sass']}}
  NeoBundle 'gorodinskiy/vim-coloresque'
" Python
  NeoBundle 'fisadev/vim-isort', {'autoload':{'filetypes':['python']}}
  NeoBundleLazy 'davidhalter/jedi-vim', {'autoload':{'filetypes':['python']}}
  NeoBundleLazy 'klen/python-mode', {'autoload':{'filetypes':['python']}}
" Other
  NeoBundleLazy 'evanmiller/nginx-vim-syntax', {'autoload': {'filetypes': 'nginx'}}
  NeoBundle 'fatih/vim-go'
  NeoBundle 'saltstack/salt-vim'
  NeoBundle 'tpope/vim-markdown'


" Utils
  NeoBundle 'honza/vim-snippets'
  NeoBundle 'SirVer/ultisnips'
  NeoBundle 'sjl/gundo.vim'
  NeoBundle 'mhinz/vim-startify'
  NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf' }
  NeoBundle 'junegunn/fzf.vim'
  NeoBundle 'Shougo/vimproc.vim', {
  \   'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \   },
  \ }
  NeoBundle 'tomtom/tcomment_vim'
  NeoBundle 'terryma/vim-expand-region'
  NeoBundle 'terryma/vim-multiple-cursors'
  NeoBundle 'blacktorn/vim-endwise'
  NeoBundle 'tpope/vim-eunuch'
  NeoBundle 'tpope/vim-repeat'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tpope/vim-unimpaired'
  NeoBundle 'Valloric/YouCompleteMe', {
  \   'build'      : {
  \     'mac'     : './install.py --clang-completer --gocode-completer --tern-completer',
  \     'unix'    : './install.py --clang-completer --gocode-completer --tern-completer',
  \     'windows' : './install.py --clang-completer --gocode-completer --tern-completer',
  \     'cygwin'  : './install.py --clang-completer --gocode-completer --tern-completer'
  \   }
  \ }


  call neobundle#end()

" Required:
  filetype plugin indent on
  NeoBundleCheck
  if bundleExists == 0
    echo "Installing Bundles, ignore errors"
  endif

" }}}

" System Settings  ---------------------------------------------------------{{{

" Neovim Settings
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  set clipboard+=unnamedplus

" Search with smartcase
" /copyright      Case insensitive
" /Copyright      Case sensitive
" /copyright\C    Case sensitive
" /Copyright\c    Case insensitive
  set ignorecase " smartcase needs ignorecase
  set smartcase

  set encoding=utf-8
  setglobal fileencoding=utf-8
" Currently needed for neovim paste issue
  set pastetoggle=<f6>
" Let airline tell me my status
  set noshowmode
  set noswapfile
  filetype on
  set relativenumber number
  set tabstop=2 shiftwidth=2 expandtab
  set conceallevel=0
" block select not limited by shortest line
  set virtualedit=
  set wildmenu
  set laststatus=2
  set wrap linebreak nolist
  set wildmode=full
  set wildignore+=*/tmp/*,*.so,*.swp,*.pyc,*.zip
" leader is ,
  let mapleader = '\'
  let gmapleader = '\'
  map <Space> <leader>
  set undofile
  set undodir="$HOME/.VIM_UNDO_FILES"
  set backupdir=~/.backups,~/.tmp,~/tmp,/var/tmp,/tmp

  set list
  set listchars=tab:▸\ ,trail:•,extends:»,precedes:«
  set colorcolumn=80

  set cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd WinEnter * setlocal cursorline

  set backspace=indent,eol,start

" Remember cursor position between vim sessions
  autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif
              " center buffer around cursor when opening files
  autocmd BufRead * normal zz

  let g:jsx_ext_required = 0
  set complete=.,w,b,u,t,k
  let g:gitgutter_max_signs = 1000  " default value
  set guifont=Hack:h12
  set scrolloff=20
" }}}

" Keymap  ------------------------------------------------------------------{{{

  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

" Disable arrow keys
  noremap <Up> <NOP>
  noremap <Down> <NOP>
  noremap <Left> <NOP>
  noremap <Right> <NOP>

  noremap H ^
  noremap L g_
  noremap J 5j
  noremap K 5k

  map <Esc> :noh<Cr>
  noremap <C-/> :TComment<Cr>
  noremap <Leader>; :TComment<Cr>

  " Faster save
  nnoremap <Leader>w :w<CR>

" Copy to clipboard
  vmap <Leader>y "+y
  vmap <Leader>d "+d
  nmap <Leader>p "+p
  nmap <Leader>P "+P
  vmap <Leader>p "+p
  vmap <Leader>P "+P

" Indent and keep selection
  vmap < <gv
  vmap > >gv

  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)

  nnoremap <F3> :<C-u>GundoToggle<CR>

" vim-unimpaired
  nmap <C-up> [e
  nmap <C-down> ]e
  vmap <C-up> [egv
  vmap <C-down> ]egv

" emmet-vim
  imap <expr> <Tab> emmet#expandAbbrIntelligent("\<Tab>")
" }}}

" Themes, Commands, etc  ---------------------------------------------------{{{
" Theme
  syntax enable
  colorscheme OceanicNext
  set background=dark
" highlightt the current line number
  hi CursorLineNR guifg=#ffffff
" no need to fold things in markdown all the time
  let g:vim_markdown_folding_disabled = 1
" turn on spelling for markdown files
  autocmd BufRead,BufNewFile *.md setlocal spell complete+=kspell
" highlight bad words in red
  hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224
" Keep my termo window open when I navigate away
  autocmd TermOpen * set bufhidden=hide

  autocmd BufWritePre * :%s/\s\+$//e
" Write on focus lost, buffer change, etc
  au FocusLost * silent! :wa
  set autowriteall
"}}}

" vim-airline  -------------------------------------------------------------{{{
  let g:airline_powerline_fonts = 1
  let g:airline_theme = 'oceanicnext'
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#enabled = 1
  set hidden
  let g:airline#extensions#tabline#show_tab_nr = 1

" Tabline part of vim-airline
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
  cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
" cmap x Sayonara

" This replaes :tabnew which I used to bind to this mapping
  nmap <leader>t :term<Cr>
" Move to the next buffer
  nmap <leader>, :bnext<CR>
  nmap <leader><Tab> :bnext<CR>
  nmap <leader>bd :bdelete<CR>
" Move to the previous buffer
  nmap <leader>. :bprevious<CR>
  nmap <leader><S-Tab> :bprevious<CR>
  let g:airline#extensions#tabline#buffer_idx_mode = 1

  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9

"}}}

" Python  ------------------------------------------------------------------{{{
" python-mode
  let g:version=0
  let g:pymode_folding=0
" jedi-vim
  let g:jedi#popup_on_dot=0
  let g:jedi#use_tabs_not_buffers=0

" }}}

" FZF ----------------------------------------------------------------------{{{

" Brew install fzf
  let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
  map <C-p> :FZF<CR>
  tmap <C-p> <C-\><C-n>:FZF<CR>
  map <leader>a :Ag<CR>
  tmap <leader>a <C-\><C-n>:Ag<CR>

  vmap <leader>aw y:Ag <C-r>0<CR>
" nmap <leader>aw :Ag <C-r><C-w>
  map <leader>h :History<CR>
  tmap <leader>h <C-\><C-n>:History<CR>
  map <leader>l :Lines<CR>

"}}}

" YouCompleteMe  -----------------------------------------------------------{{{

  let g:ycm_complete_in_comments_and_strings=1
  " let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
  let g:ycm_key_list_select_completion=['<Down>']
  " let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
  let g:ycm_key_list_previous_completion=['<Up>']

" }}}

" Folding ----------------------------------------------------------------- {{{

" Space to toggle folds.
  nnoremap <Leader><Space> za
  vnoremap <Leader><Space> za

  set foldmethod=marker
  set foldlevelstart=0

  " Make zO recursively open whatever fold we're in, even if it's partially open.
  nnoremap zO zczO

  " "Focus" the current line.  Basically:
  "
  " 1. Close all folds.
  " 2. Open just the folds containing the current line.
  " 3. Move the line to a little bit (15 lines) above the center of the screen.
  " 4. Pulse the cursor line.  My eyes are bad.
  "
  " This mapping wipes out the z mark, which I never use.
  "
  " I use :sus for the rare times I want to actually background Vim.
  nnoremap <C-z> mzzMzvzz15<C-e>`z:Pulse<Cr>

  function! MyFoldText() " {{{
      let line = getline(v:foldstart)

      let nucolwidth = &fdc + &number * &numberwidth
      let windowwidth = winwidth(0) - nucolwidth - 3
      let foldedlinecount = v:foldend - v:foldstart

      " expand tabs into spaces
      let onetab = strpart('          ', 0, &tabstop)
      let line = substitute(line, '\t', onetab, 'g')

      let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
      let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
      return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
  endfunction " }}}
  set foldtext=MyFoldText()

" }}}

" Pulse Line  --------------------------------------------------------------{{{

function! s:Pulse() " {{{
    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 8
    let width = 1
    let start = width
    let end = steps * width
    let color = 233

    for i in range(start, end, width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor
    for i in range(end, start, -1 * width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor

    execute 'hi ' . old_hi
endfunction " }}}
command! -nargs=0 Pulse call s:Pulse()

" }}}

" Cursor settings  ---------------------------------------------------------{{{
" Switch from block-cursor to vertical-line-cursor when going into/out of insert mode
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" For Gnome-terminal
  au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
  au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
  au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
  au VimEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
" }}}

" Filetype settings  -------------------------------------------------------{{{

  au BufNewFile,BufRead *.scss set filetype=scss.css
  au BufNewFile,BufRead *.sass set filetype=sass.css
  au BufNewFile,BufRead *.html setlocal filetype=htmldjango

  autocmd Filetype vim setlocal tabstop=2 shiftwidth=2 autoindent
  autocmd Filetype python setlocal tabstop=4 shiftwidth=4
  autocmd Filetype html setlocal tabstop=2 shiftwidth=2
  autocmd Filetype htmldjango setlocal tabstop=2 shiftwidth=2
  autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2
  autocmd Filetype json setlocal tabstop=2 shiftwidth=2
  autocmd Filetype scss setlocal tabstop=2 shiftwidth=2 autoindent
  autocmd Filetype sass setlocal tabstop=2 shiftwidth=2 autoindent
  autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 autoindent

  autocmd FileType sass,scss,css nnoremap <buffer> <F5> :call CSScomb()<CR>
  function! CSScomb()
    execute "silent !csscomb " . expand('%')
    redraw!
  endfunction

" }}}

" Other packages settings  -------------------------------------------------{{{

" vim-expand-region
  let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ }
" vim-signify
  let g:signify_update_on_bufenter=0
" vim-startify
  let g:startify_change_to_vcs_root = 1
  let g:startify_show_sessions = 1
  nnoremap <C-F1> :Startify<Cr>
" ultisnips
  let g:UltiSnipsExpandTrigger="<Tab>"
  let g:UltiSnipsJumpForwardTrigger="<Tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsSnippetsDir='~/.vim/snippets'

  let ignore_list = [
        \ '\.DS_Store',
        \ '\.swp',
        \ '\.swo',
        \ '\.git/',
        \ '\.hg/',
        \ 'git5/.*/review/',
        \ 'google/obj/',
        \ 'tmp/',
        \ '\.vagrant/',
        \ '\.sass-cache/',
        \ '\.ropeproject/',
        \ '\.idea/',
        \ '\.iml',
        \ 'node_modules/',
        \ 'bower_components/',
        \ 'dist/',
        \ '\.git5_specs/',
        \ '\.pyc',
        \ ]

  let g:netrw_list_hide = join(ignore_list, ', ')

" }}}

" GUI settings  ------------------------------------------------------------{{{

  if has('gui_running')
      " GUI Vim

      set guifont=Hack:h12

      " Remove all the UI cruft
      set go-=T
      set go-=l
      set go-=L
      set go-=r
      set go-=R

      highlight SpellBad term=underline gui=undercurl guisp=Orange

      " Different cursors for different modes.
      set guicursor=n-c:block-Cursor-blinkon0
      set guicursor+=v:block-vCursor-blinkon0
      set guicursor+=i-ci:ver20-iCursor

      if has("gui_macvim")
          " Full screen means FULL screen
          set fuoptions=maxvert,maxhorz
      end
  endif

" }}}

" Autoreload vimrc  --------------------------------------------------------{{{

  augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
  augroup END

" }}}
