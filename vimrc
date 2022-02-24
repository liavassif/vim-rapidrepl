"---- PLUGINS
call plug#begin('~/.vim/plugged')
"repls:

"fix ~/.vim/plugged/vim-slime/ftplugin/python/slime.vim:
"function! _EscapeText_python(text)
"  if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1
"    return ["\e[200~", a:text, "\e[201~", g:slime_dispatch_ipython_pause, "\n"]
"for automatically detecting the terminal number, also add as the first two lines of 'function! s:VimterminalConfig() abort:' in ~/.vim/plugged/vim-slime/autoload/slime.vim (remove the comment)
"  let b:slime_config = g:slime_default_config
"  return
Plug 'jpalardy/vim-slime'

"fix autoload/ripple.vim line 122 to: \ && (has('nvim') || term_getstatus(s:ft_to_term[ft]) != "finished")
"Plug 'urbainvaes/vim-ripple'
"Plug 'machakann/vim-highlightedyank'
"for cell text objects (used with vim-ripple)
"Plug 'kana/vim-textobj-user'
"Plug 'GCBallesteros/vim-textobj-hydrogen'
"vim only. ok but problem with multiline
"Plug 'sillybun/vim-repl'
"works ok in nvim (probably needs tmux for vim?). in order to interrupt needs to be in insert mode in the REPL
"Plug 'jalvesaq/vimcmdline', { 'do': ':UpdateRemotePlugins' }
"nvim only. works but cannot type in the repl itself. Workaround is connecting to an existing jupyter (qt)console
"Plug 'bfredl/nvim-ipy'
"works? but the python repl is external jupyter (qt)console, no split window etc. (but can probably interact in :terminal)
"Plug 'jupyter-vim/jupyter-vim'
"nvim only. not wokring at all
"Plug 'hkupty/iron.nvim', { 'branch': 'direct-invoke' }
"Plug 'GCBallesteros/iron.nvim'

" use =/- to expand/decrease selection
Plug 'terryma/vim-expand-region'

"Session (save workspace) management
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

"search and replace plugin
"Plug   'eugen0329/vim-esearch'
Plug 'brooth/far.vim'

"debugger
"Plug 'puremourning/vimspector'

"folds bettern than 'indent' for Python. However I like it less as the function definition is not syntax highlighted when folded
"Plug 'tmhedberg/SimpylFold'

Plug 'preservim/nerdtree'

"LSP
Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"fuzzy searchers
"Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
"Plug 'liuchengxu/vista.vim'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
"Plug 'kien/ctrlp.vim'

Plug 'vim-airline/vim-airline'             " status/tabline
"Plug 'majutsushi/tagbar'                   " overview of current file structure

"toggle comments
Plug 'tomtom/tcomment_vim'

Plug 'vim-python/python-syntax'
"nvim only
"Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

"show | instead of tabs
Plug 'Yggdroot/indentLine' 

"refactoring using rope (without lsp)
"Plug 'python-rope/ropevim'

"overrides the delete operations to actually just delete and not affect the current yank
"Plug 'svermeulen/vim-cutlass'

"colorschemes
"Plug 'joshdick/onedark.vim'
"Plug 'junegunn/seoul256.vim'
Plug 'rafi/awesome-vim-colorschemes'
"Plug 'altercation/vim-colors-solarized'

call plug#end()

"---- GENERAL UI AND EDITING
let mapleader = " "
"don't save open terminals (repls) as they won't be associated with the repl upon restart
"don't use almost any of the session options as we only want to save buffers associated with windows
set sessionoptions=winsize

"probably this is the default
filetype plugin on

filetype plugin indent on
 
set t_Co=256   " This is may or may not needed.
"use 24 color bit for terminal vim. Only works on 24bit terminals (from the shell see if this prints the text in color $echo -e "\033[38;2;243;134;48mgiant goldfish\033[0m"
if !has('gui_running')
    "set termguicolors
endif

"dark themes
"colo seoul256
"colorscheme onehalfdark

"light themes
"set background=light
"colorscheme solarized
"color summerfruit256
"colorscheme PaperColor

" good
"colorscheme one

"colorscheme onehalflight
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"colorscheme ayu

"syntax enable keeps local highlight definition while enabling syntax highlight. syntax on overrides everthing
"syntax enable
syntax on
colorscheme onehalfdark

"from python-syntax. does it have any effect?
"let g:python_highlight_all = 1

" also check https://stackoverflow.com/questions/896145/more-efficient-movements-editing-python-files-in-vim/28284564
" for movement ]],[[,]M,[M etc
" Enable folding. za toggles current fold. zM/zR create/closes all
set foldmethod=indent
" start without folds
set foldlevel=99

"using LSP for folds doesn't work well...
"set foldmethod=expr foldexpr=lsp#ui#vim#folding#foldexpr() foldtext=lsp#ui#vim#folding#foldtext()

"close current buffer. problematic as c-w is prefix for usefull windows commands
"nnoremap <C-w> :bd<CR> 

"source $VIMRUNTIME/mswin.vim
" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
"behave mswin
" backspace and cursor keys wrap to previous/next line
"we set more mswin behaviour at the end
set backspace=indent,eol,start whichwrap+=<,>,[,]

"underline the current line
hi CursorLine gui=underline cterm=underline
set cursorline                               " Underlining the current line

"ipython sometimes crashes with utf8 exception, not sure its related but disabling for now
"set encoding=utf-8

"Vim usually has its own clipboard and ignores the system keyboards, but sometimes you might want to cut, copy, and/or paste to/from other applications outside of VIM. On OS X, you can access your system clipboard with this line
"pasting from outside works ok but copying is not working. currently using the mouse for the terminal
set clipboard=unnamedplus
"paste from clipboard into command line mode
cmap <S-Insert> <C-r>+
"paste from clipboard into terminal mode
tmap <S-Insert> <C-W>"+
"paste from vim editor into terminal mode
tmap <leader><Insert> <C-W>"0
"paste from vim editor in insert mode
imap <C-V> <C-R>+
imap <S-Insert> <C-R>+
"copy the current filename to the clipboard
nmap <leader>c :let @+ = expand("%")<cr>
"map <S-Insert> p
"map <C-Insert> y

"make C-right/left skip to words (instead of words with whitespace)
map <C-right> <S-right>
map <C-left> <S-left>

"vim search stop at end of file
set nowrapscan

set nowrap

"Vim won't complain if a buffer that has unsaved changes is not shown in a window any longer, and only confront you on quitting Vim.
set hidden

"avoid nvim/vim terminal statusline escape char bugs. perhaps this need to be done in after/ ?
if has('gui_running')
    "set guifont=Source\ Code\ Pro\ 10
    "avoid scrollbars as they make ripple flash when sending to ripple
    "set guioptions-=Ll
    "set guioptions=Ace 
    "hide toolbar
    set guioptions -=T
else
    set guicursor=
endif

" search options
set ignorecase " usually ignore case when searching
set smartcase " unless a search term starts with a capital letter
"set inccommand=nosplit

" allow mouse control
set mouse=a

" avoid delays when exiting insert mode with escape
set ttimeoutlen=0

" more frequent updates and cursor hold
set updatetime=2000

"maximize window (put this after guioptions as they also might change size)
if has('gui_running')
    set lines=300 columns=300
endif

"set nobackup
"set noswapfile
"set noundofile
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//
set undodir=~/.vim/tmp//

"open buffers in a vertical split
set splitright
" open help in a vertical split
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

nnoremap <C-Right> w
nnoremap <C-Left> b

"auto reload files
set autoread
au FocusGained,BufEnter * :checktime
if !exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(1000,'CheckUpdate')
endfunction
"the following also works but is slightly slower
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
"    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
"            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
"autocmd FileChangedShellPost *
"  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" always show the sign colum to prevent flickering
"set signcolumn=yes

set number " show line numbers

if has('nvim')
    " when switching to terminal enter insert mode
    au BufEnter * if &buftype == 'terminal' | startinsert | else | stopinsert | endif
else
    "disable line numbers in terminal
    autocmd TerminalOpen * setlocal nonu
    autocmd TerminalOpen * setlocal bufhidden=hide
    "autocmd TerminalOpen * setlocal signcolumn=no
endif

"Keep your cursor centered vertically on the screen
augroup VCenterCursor
  au!
  au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
augroup END

"map tab to indent in normal and visual (seems already mapped in insert) modes
"In normal mode, type >> to indent the current line, or << to unindent.
"In insert mode, CTRL-T indents the current line, and CTRL-D unindents.
map <tab> >>
map <S-tab> <<
vnoremap <tab> >gv
vnoremap <S-tab> <gv

set autochdir "auto cd to currently edited file. might be useful for opening another file...?

"map comment
nmap <leader>/ gcc
"toggle comment and retain selection (remove gv in order not to retain)
xmap <leader>/ gcgv

"search and replace undo far plugin
" Use Farr and then Fardo
let g:far#enable_undo=1

"switch between windows
" Note: Allows faster switching between windows with "Ctrl+w"! By Questor
nnoremap <silent> <M-1> <C-w><C-w>
inoremap <silent> <M-1> <Esc><C-w><C-w>
vnoremap <silent> <M-1> <Esc><C-w><C-w>
tnoremap <silent> <M-1> <C-w><C-w>

"since we mapped Tab to completion it unfortunately maps C-i as well, we remap Alt-o for next location
"so <c-o>/<M-o> (was <c-i>) traverses jumps. g;/g, traverses changes
nnoremap <silent> <M-o> <C-i>

nmap <C-PageUp> :bprev<cr>
nmap <C-PageDown> :bnext<cr>
imap <C-PageUp> <esc>:bprev<cr>i
imap <C-PageDown> <esc>:bnext<cr>i

"skip over terminal buffers (use ls! to show hidden buffers)
"https://www.reddit.com/r/vim/comments/8njgul/is_it_possible_to_skip_over_terminal_buffers_when/
autocmd TerminalOpen * if bufwinnr('') > 0 | setlocal nobuflisted | endif

"sometimes cursor disappears. this fixes it (also see https://stackoverflow.com/questions/1025762/cursor-disappears-in-vim-when-switching-windows-between-vertical-and-horizontal)
"and also more fixes (close stuck popups etc). might have to manually :call popup_clear() first
nmap <silent> <F6> :!echo > /dev/null<cr>:call popup_clear()<cr>:set updatetime=2000<cr>:set guicursor&<cr>
"start with this: (usually paste also stops working so use <C-r>+ to paste this)
":set guicursor&

"https://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers
function! DeleteHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed ".closed." hidden buffers"
endfunction
"note that some plugins (such as leaferf) relies on their own hidden buffer. closing them will cause errors.
nmap <silent> <F7> :call DeleteHiddenBuffers()<cr>

" search current word in path. can also use C-q for quickfix
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j *.py" <Bar> cw<CR>

"close all buffers except current. somewhat buggy
command! BufOnly execute '%bdelete|edit #|normal `"'

let g:indentLine_char = '│'

"vim-cutlass. cut using m
"nnoremap m d
"xnoremap m d
"nnoremap mm dd
"nnoremap M D

"do not copy when deleting (shift-del in visual mode keeps on its cut function which is good)
imap <del> <C-O>"_x
vmap <del> "_xi
nmap <del> "_xi

"---- LSP
if executable('pylsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ 'configurationSources': [''],
        \ })

elseif executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    "inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    "autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
    "something still sets it to 1, so we set it again at the end
    let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
    let g:lsp_diagnostics_highlights_enabled = 0
    let g:lsp_diagnostics_signs_enabled = 0
    "let g:lsp_diagnostics_signs_delay = 1000
    let g:lsp_diagnostics_virtual_text_enabled = 0
    "let g:lsp_document_highlight_enabled = 1
    highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"completions
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
let g:asyncomplete_auto_popup = 1
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"---- REPL
if 0
    "vim-repl
    let g:repl_program = {
                \   'python': 'ipython',
                \   'default': 'zsh',
                \   'r': 'R',
                \   'lua': 'lua',
                \   'vim': 'vim -e',
                \   }
    "let g:repl_predefine_python = {
    "            \   'numpy': 'import numpy as np',
    "            \   'matplotlib': 'from matplotlib import pyplot as plt'
    "            \   }
    let g:repl_python_auto_import = 0
    let g:repl_cursor_down = 1
    let g:repl_python_automerge = 0
    let g:repl_ipython_version = '7'
    let g:repl_output_copy_to_register = "t"
    nnoremap <leader>r :REPLToggle<Cr>
    nnoremap <leader>e :REPLSendSession<Cr>
    "autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
    "autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
    "autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>
    let g:repl_position = 3
elseif 0
" for nvim-ipy. instead perhaps add in the plug statement: , { 'do': ':UpdateRemotePlugins' }
    "so ~/.local/share/nvim/rplugin.vim 

elseif 0
" for vimcmdline
    let cmdline_app           = {}
    let cmdline_app['python']     = 'ipython'
    let cmdline_vsplit = 1
elseif 0
"for iron repl
    "luafile $HOME/.config/nvim/plugins.lua
elseif 0
"for ripple
    let g:ripple_highlight = ""
    let g:ripple_repls = { "python": ["ipython", "\<esc>[200~", "\<esc>[201~\<cr>", 1] }
    nmap <F1> :Ripple<cr>
    nmap <F5> <Plug>(ripple_send_buffer)
    nmap <F9> <Plug>(ripple_send_line)
else
"for slime

    if has('nvim')
        let g:slime_target = "neovim"
        nmap <F1> :vsplit term://ipython -c 'cd ~/code/counter_stream'<cr><C-W><C-W>
    else
        let g:slime_target = "vimterminal"
    "    nmap <F1> :vert term ipython -c "cd ~/code/counter_stream" <cr><C-W><C-W>
    "    nmap <F1> :vert term <cr>
        nmap <F1> :call StartTerm()<cr>
    endif
    let g:slime_cell_delimiter = "# %%"
    "nmap <leader>s <Plug>SlimeSendCell
    let g:slime_python_ipython = 1
    let g:slime_vimterminal_cmd = "ipython"
    "g:slime_vimterminal_config doesn't work. Instead start from normal mode ":vert term ipython" and then when slime starts it will ask to assign to the existing term
    "let g:slime_vimterminal_config = {vert term}
    "nmap <F1> :vert term ipython<cr><C-W><C-W>
    nmap <F2> :SlimeSend0("cd " . expand('%:p:h') . "\n")<cr>
    "nmap <F5> :%SlimeSend<cr>
    nmap <F5> :w<cr>:SlimeSend0("%cd " . expand('%:p:h') . "\n" . "%run -i " . expand('%:p') . "\n")<cr>
    imap <F5> <esc>:w<cr>:SlimeSend0("%cd " . expand('%:p:h') . "\n" . "%run -i " . expand('%:p') . "\n")<cr>
    nmap <F9> <Plug>SlimeLineSend
    nmap <leader>1 <Plug>SlimeLineSend <bar> j

    if has('gui_running')
        nmap <C-return> <Plug>SlimeSendCell
        imap <C-return> <C-O><Plug>SlimeSendCell
        
    else
        "sometimes in the terminal C-enter is interpreted as C-j
    "    nmap <C-j> <Plug>SlimeSendCell
        nmap <leader><return> <Plug>SlimeSendCell
    endif

    "imap <C-2> <esc>viw<C-c><C-c>
    nmap <leader>2 viw<C-c><C-c>
    map <leader>3 <C-c><C-c>
    "copy current word
    nmap <leader>4 yiw
    "paste over selected word
    "<c-\> is <C-4>
    nmap <C-\> viw"0p
    nmap <C-4> viw"0p
    "select current word
    nmap <M-4> viw
    nmap <leader>5 :SlimeConfig<cr>
endif

function! StartTerm()
  execute 'vert term'
  "the autocmd for terminal doesn't work in this case so we need to execute this manually
  execute 'setlocal nobuflisted'
  let l:p = bufnr('%')
  if !exists("g:slime_default_config")
    let g:slime_default_config = {"bufnr": ""}
  end
  let g:slime_default_config["bufnr"] =p
  call feedkeys(". ~/init2.sh\<cr>")

  "doesn't work...
  "normal <esc><C-w><C-w>
  "normal <esc><M-1>
  "normal <M-1>
endfunction

"start terminal ("term" doesn't automatically start when using prosession)
autocmd! User ProsessionPost call StartTerm()

"switch to repl insert mode
nmap <leader>0 <C-W>li
nmap <leader>9 <C-W>h
"map <ESC> to normal mode for the terminal
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
else
    "tnoremap <ESC> <C-w>N
    tmap <C-w><C-c> <nop>
    "arrow keys do not work on terminal with tnoremap <Esc> <C-W>N
    tnoremap <Esc> <C-W>N
    tnoremap <Esc><Esc> <C-W>N
    set timeout timeoutlen=1000  " Default
    set ttimeout ttimeoutlen=100  " Set by defaults.vim
endif

" make <C-C> also stop repl execution from the editor buffer
nmap <C-C> <M-1><C-C><M-1>

"disable hiding windows because this messes up the viewing setup. not working?
nmap <C-W><C-Q> <nop>
nnoremap <C-W><C-Q> <nop>
tnoremap <C-W><C-Q> <nop>
tmap <C-W><C-Q> <nop>
tmap <C-W>Q <nop>
tnoremap <C-W>Q <nop>

"restore terminal position when the view is single window (should change this to : if a terminal exists and shown do nothing, hidden, do it, otherwise run terminal e.g F1)
nmap <leader>w :only<cr>:vert sb /bin/<cr>

" insert iPython debug statement
nnoremap <leader>d ofrom IPython.core.debugger import Pdb; ipdb = Pdb(); ipdb.set_trace()<esc>


"---- CELLS NAVIGATION
nmap <C-down> /# %%<CR>
"imap <C-down> <esc>/# %%<CR>i
imap <C-down> <C-O>/# %%<CR>
nmap <C-up> ?# %%<CR>
"imap <C-up> <esc>?# %%<CR>i
imap <C-up> <C-O>?# %%<CR>
" cells navigation using vim-textobj-hydrogen
":nmap <C-down> ]h
":nmap <C-up> [h
"if has('gui_running')
    "nmap <C-j> <C-down>
"endif
"nmap <C-k> <C-up>
"mark current cell
"nmap <C-a> Vih
"vim repl
"nmap <C-return> Vih<leader>w
"cmdline
"nmap <leader>c Vih<Space>
"ripple
"nmap <C-return> VihR


"---- STATUS BAR
" vim-airline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1

" Make cursorline prominent
" refer https://jonasjacek.github.io/colors/
"hi CursorLine cterm=NONE ctermbg=236

"Highlight IPython cells. https://github.com/hanschen/vim-ipython-cell/issues/21
"highlight MyGroup ctermbg=238 guifg=black guibg=#ffffa4
highlight MyGroup ctermbg=238 guibg=#ffffa4
autocmd Filetype python match MyGroup /^# %%.*/
augroup highlight_cell_header
  autocmd!
  autocmd Filetype python match MyGroup /^# %%.*/
augroup END



"---- FUZZY SEARCHERS

" Can also use built in :find command
" taken from https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim. Read it all as it has nice builtins usefull even when using LSP
" FINDING FILES:
" Search down into subfolders
" Provides tab-completion for all file-related tasks
"seems like that even with wildignore it first scans the whole subfolders which can be slooow
"set path+=**
"ignore these paths
"set wildignore+=**/data/**
" Display all matching files when we tab complete
set wildmenu
" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy
" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer


" finders using plugins:

if 0
"CtrlP
    "set runtimepath^=~/.vim/bundle/ctrlp.vim     " enabling ctrlP Fuzzy Search
    let g:ctrlp_max_files=10                      " number of files to scan initially
    let g:ctrlp_max_depth=4                     " directory depth to recurse into when scanning
    set wildignore+=*data/,*/tmp/*,*/logs/,*/bin/*,*/bower_components/*,*/node_modules/*,*.so,*.swp,*.zip     " for CtrlP in MacOSX/Linux
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
    "If a file is already open, open it again in a new pane instead of switching to the existing pane
    let g:ctrlp_switch_buffer = 'et'
    "let g:ctrlp_match_window = 'top,order:ttb,min:1,max:10,results:10'
    let g:ctrlp_cmd = 'CtrlPBuffer'
    "nnoremap <leader>f :<C-u>CtrlP<CR> 
elseif 0
"FZF
    "only works on vim 8.2
    "let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
    " Empty value to disable preview window altogether
    let g:fzf_preview_window = []
    if has('nvim') && !exists('g:fzf_layout')
      autocmd! FileType fzf
      autocmd  FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    endif
    "let $FZF_DEFAULT_COMMAND = 'ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'

elseif 0
"vim-Clap
    "By default, the vim-clap window is placed relative to the currently active window. To make it relative to the whole editor modify this variable as shown below
    let g:clap_layout = { 'relative': 'editor' , 'height': '25%'}
    let g:clap_theme = 'solarized_light'
    let g:clap_open_preview = 'never'
    let g:clap_provider_buffers_cur_tab_only = 1

    "vista shows symbols. alternatively can use built-in vim-lsp: gs
    "let g:vista_default_executive='vim_lsp'
    "doesn't work with vista and lsp. if falls back to ctags
    "let g:vista_ignore_kinds=['Variable']

    "install conda install -c conda-forge universal-ctags
    let g:vista_ignore_kinds=['variable','modules','member']
    "or uncomment these for older ctags:
    "let g:vista_ctags_cmd = {
    "      \ 'python': 'ctags --format=2 --excmd=pattern --fields=+nksSaf --sort=no --append=no --language-force=python --python-kinds=cvfim -f- ',
    "      \ }
    "let g:vista_ignore_kinds=['variables','modules','members']

    nnoremap <C-p> :<C-u>Clap buffers<CR>
    nmap <leader>p :<C-u>Clap tags<CR>
    nnoremap <C-f> :<C-u>Clap blines<CR>
    nnoremap <C-l> :<C-u>Clap filer <CR>
    nnoremap <leader>l :<C-u>Clap history<CR>
    nnoremap <leader>x :<C-u>Clap command<CR>
    nnoremap <C-x> :<C-u>Clap providers<CR>
    nnoremap <C-q> :<C-u>Clap quickfix<CR>
    "nnoremap <leader>f :<C-u>Clap hist/<CR>
else
"vim-LeaderF
    " don't show the help in normal mode
    let g:Lf_HideHelp = 1
    let g:Lf_UseCache = 0
    let g:Lf_UseVersionControlTool = 0
    let g:Lf_IgnoreCurrentBufferName = 1
    " popup mode
    let g:Lf_WindowPosition = 'popup'
    let g:Lf_PreviewInPopup = 0
    "let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
    let g:LF_RememberLastSearch = 1
    "let g:LF_PopupHeight = 0.3
    "let g:Lf_PopupColorscheme = 'one'
    let g:Lf_PopupColorscheme = 'gruvbox_default'
    let g:Lf_AutoResize = 0
    "should install fonts from https://github.com/ryanoasis/nerd-fonts
    " Show icons, icons are shown by default
    "let g:Lf_ShowDevIcons = 1
    " For GUI vim, the icon font can be specify like this, for example
    "let g:Lf_DevIconsFont = "DroidSansMono Nerd Font Mono"
    " If needs
    "set ambiwidth=double    
    "let g:Lf_ShortcutF = "<leader>ff"
    let g:Lf_ShortcutB='<C-p>'
    nmap <M-p> :<C-u>LeaderfBufferAll<CR>
    "nmap <leader>p :<C-u>LeaderfBufTag<CR>
    "nnoremap <C-f> :<C-u>LeaderfLine<CR>
    nnoremap <leader>f :<C-u>LeaderfLine<CR>
    nnoremap <C-l> :<C-u>LeaderfFile<CR>
    nnoremap <C-q> :<C-u>LeaderfQuickFix<CR>
    nnoremap <leader>l :<C-u>LeaderfMru<CR>
    nnoremap <C-x> :<C-u>LeaderfSelf<CR>
    nnoremap <leader>x :<C-u>LeaderfCommand<CR>
    let g:Lf_WildIgnore = {
                \ 'dir': ['data/','bak','__pycache__'],
                \ 'file': []
                \}
    let g:Lf_WildIgnore = {'dir': ['data/','bak','/__pycache__/'],'file': ['*.pyc']}
    let g:Lf_MaxCount=20000


    function! MyLspShowSymbolsLeaderf()
        " comment out plugged/vim-lsp/autoload/lsp/ui/vim.vim line 219: " botright copen
        call lsp#ui#vim#document_symbol()
        execute 'sleep 1'
        execute 'LeaderfQuickFix'
    endfunction
    nmap <leader>p :call MyLspShowSymbolsLeaderf()<cr>

endif

"---- DEBUG (vimspector)
let g:vimspector_enable_mappings='HUMAN'

"---- MSWIN behaviour (taken and modified from mswin.vim)
"https://github.com/fabi1cazenave/cua-mode.vim/blob/master/plugin/cua-mode.vim
" set the 'cpoptions' to its Vim default
let s:save_cpo = &cpoptions
set cpo&vim

" behave like xterm when not in GUI mode
behave xterm
if has('gui_running')
  set mousemodel=popup_setpos   " right-click displays a popup menu
"  set keymodel=startsel,stopsel " shift+arrows triggers the select mode
"  set keymodel=startsel " shift+arrows triggers the select mode
endif


if 1==1
    " shift+arrow selection
    nmap <S-Up> v0<C-g>
    nmap <S-Home> v0<C-g>
    nmap <S-Down> v$<C-g>
    nmap <S-End> v$h<C-g>
    nmap <S-Left> v<Left><C-g>
    nmap <S-Right> v<Right><C-g>
    vmap <S-Up> <Up><C-g>
    vmap <S-Down> <Down><C-g>
    vmap <S-Left> <Left><C-g>
    vmap <S-Right> <Right><C-g>
    imap <S-Up> <C-O>v0<C-g>
    "select until first column
"    imap <S-Home> <esc>v0<C-g>
    "goto first column. inconsistent with the rest of the keys but more usefull
    imap <S-Home> <C-O>0<C-g>
    imap <S-Down> <C-O>v$<C-g>
    imap <S-End> <C-O>v$h<C-g>
    imap <S-Left> <esc>v<Left><C-g>
    imap <S-Right> <C-O>v<Right><C-g>
else
    set keymodel=startsel " shift+arrows triggers the select mode
endif    
nnoremap <C-S-Right> ve<C-g>
nnoremap <C-S-Left> vb<C-g>
inoremap <C-S-Right> <C-O>ve<C-g>
inoremap <C-S-Left> <esc>vb<C-g>
vnoremap <C-Right> e<C-g>
vnoremap <C-Left> b<C-g>
vnoremap <C-S-Right> e<C-g>
vnoremap <C-S-Left> b<C-g>

imap <home> <C-O>^
nmap <home> ^
nmap <S-home> 0

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

"|    Common PC shortcuts: CTRL-ZXCV <=> Undo|Cut|Copy|Paste                <<<
"|-----------------------------------------------------------------------------

" CTRL-Z is Undo
noremap  <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X>   "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C>      "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>      "+gP
map <S-Insert> "+gP

cmap <C-V>      <C-R>+
cmap <S-Insert> <C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>

" restore 'cpoptions'
set cpo&
let &cpoptions = s:save_cpo
unlet s:save_cpo

"for some reason this is ignored earlier, so we set it again here
let g:lsp_diagnostics_enabled = 0