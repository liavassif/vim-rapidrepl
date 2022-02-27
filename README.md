(G)Vim setup for Python rapid prototyping
![goto symbol](/sshot.jpg)


Setup Vim to be more like an IDE with an interactive prompt (REPL), similar to [Spyder](https://www.spyder-ide.org/).

I've been using this setup for about a year and it seems to work quiet well. Basically everything here is a collection of plugins and copy-pasted code I've found online with some tweaks.

It doesn't have all the features of [VSCode](https://code.visualstudio.com/), [Spyder](https://www.spyder-ide.org/) or [PyCharm](https://www.jetbrains.com/pycharm/) but it serves my needs for rapid prototyping in research - an interactive REPL and modern (non VIM) editing.

## Why use it?
Well basically if Spyder/VSCode works well for you by all means use them. I've noticed that they work well locally but for some reason I've encountered some bugs when used on a remote cluster setting. These might originate from a strange mix of system libraries, UI libraries, network latency issues etc. The Vim setting is more bare bones in that sense and when, for example, a connection is lost to the IPython REPL, I simply close it and restart it.

## What are the features?
* Integrated IPython REPL. Starts automatically when Vim is launched (can also use jupyter console instead).  
* Text editing is mostly done using modern editing shortcuts (Ctrl-PgUp/Down for cycling between buffers, selected text is replaced) with some combination of VIM normal mode commands (save using :w and quit using :qa). See vim tutorial for basic introduction. ESC enters normal mode. Ins or i enters insert (edit) mode.  
* Code cell navigation similar to Matlab/Spyder/Jupyter notebook (Ctrl-up/down)  
* Code execution in REPL (using Vim-Slime plugin): Whole file (F5), Cell execution (C-Enter or space-Enter), Single statment/selection execution (Space-1, Space-3), Current symbol under cursor execution (Space-2). All in normal mode.  
* LSP integration (using Vim-LSP plugin and PYLSP): show/goto symbol (Space-p), goto definition (gd in normal mode), show references (gr)  
* Using popup menus for usefull commands (using LeaderF plugin): show buffers (C-p), open file (C-l), open last edited files (Space-l), show LeaderF commands (C-x). Use Ctrl-j/k to cycle up and down in the list.  
* Copy-paste to/from system clipboard works in Editor, REPL and also normal mode.  
* Debug using (Space-d) which inserts debug statements. Then run the code as usual (F5 or run cell) to drop into ipdb. Alternatively as always you can use IPython %debug when an error occurs. Statement/variable execution (evaluation) also work when in ipdb (Space-1/2/3). For more advanced usage there is the vim Spector plugin.  
* Toggle comments using C-/ (normal mode). 
* Switching between the REPL and editor (Alt-1 or C-W,C-W).  
* Using IPython already have many builtin features, sometimes missing from IDEs: symbol completion in the REPL, REPL search history, kernel interrupting (Ctrl-c), text is auto scrolled at the bottom when output is appended (long for loops)  
* You can access the REPL output and copy it by using the keyboard (Escape and then the usual editing commands)  

## Installation (from scratch)
Install [python-lsp-server](https://github.com/python-lsp/python-lsp-server):

`pip install python-lsp-server`  
Next,  
`mkdir -p ~/.vim/autoload ~/.vim/tmp`  
Install [vim-plug](https://github.com/junegunn/vim-plug) as the plugin manager (Download plug.vim and put it in "~/.vim/autoload" directory)  
Copy vimrc to ~/.vim  
Run `vim` (without gui) and type: 
`:PlugInstall (press enter)`
wait for the plugins to install  
Exit (`:qa!`) and run `gvim` (or `vim -g`).

If you see some errors regarding LeaderF, try using vim-clap instead: change elseif 0 to 1 before "for clap, remove the comment before vim-clap plugin and comment out the LeaderF plugin. Run `:PlugInstall` and `:PlugClean` and restart.

Edit some of the plugins in order to make the editing more fluent. See comments in vimrc.

## Vim version and details
Why VIM? You are misusing it!  
I've also tried other editors but had the most success using VIM. You can disable the modern editing in the configuration and use VIM as intended.

What version of Vim?  
I'm using 8.2831. Note that you can also install vim (but not gvim) using conda although this is an unofficial package:
conda install -c conda-forge vim

Why GVim and not Vim?  
Nicer fonts and more shortcuts are available.  copy-paste might not work in Vim. Other than that not much of a difference.

Can I use it in Vim instead of GVim?  
Yes, but some shortcuts most likely doesn't work so you'll have to edit them and change to different keys. Sometimes C+key needs to be replaced by M+key (Alt+key), but sometimes it is the other way around. 

## What's missing
I'm not using any Git plugins so feel free to add them if you need.  
Source code execution source integration (when an error occurs clicking on the stacktrace should jump to the code)  
Refactoring can be provided by more plugins  