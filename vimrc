if has('vim_starting')
    set nocompatible

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'bkad/CamelCaseMotion'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'moll/vim-node'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'bling/vim-airline'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'gcmt/taboo.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'fatih/vim-go'
NeoBundle 'Valloric/MatchTagAlways'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'othree/html5.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'drmikehenry/vim-fontsize'
NeoBundle 'nacitar/terminalkeys.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'clausreinke/typescript-tools'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

"exec pathogen#infect()

"""""""" Multiple Cursors """""""
" Don't quit multiple cursors mode leaving insert mode
let g:multi_cursor_exit_from_insert_mode = 0

" Don't quit multiple cursors mode leaving visual mode
let g:multi_cursor_exit_from_visual_mode = 0

""""""" ULTISNIPS """"""
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<s-tab>"

"""""" AIRLINE """""""
" Use powerline font
let g:airline_powerline_fonts = 1

""""""""""""""" NEOCOMPLCACHE """"""""""""""""

"Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1


" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
autocmd VimEnter * inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" " <C-h>, <BS>: close popup and delete backword char.
autocmd VimEnter * inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
autocmd VimEnter * inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
autocmd VimEnter * inoremap <expr><C-y>  neocomplcache#close_popup()
autocmd VimEnter * inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
let g:neocomplcache_omni_patterns.typescript = '\h\w\.'

" Don't show the preview/scratch window when displaying a completion
:set completeopt-=preview

""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""" CTRL-P FILE FINDER """""""""""""
" Use git to list files when available (ignores files in .gitignore)
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""" KEY COMMANDS/SHORTCUTS """""""""
" Edit vimrc
nmap <silent> <leader>ve :e $MYVIMRC<CR>

" Reload vimrc
nmap <silent> <leader>vs :so $MYVIMRC<CR>

" Quick access to file browser
nmap <LEADER>n :NERDTreeToggle<CR>

" Quick Git commmands
nmap <LEADER>gs :Gstatus <CR>
nmap <LEADER>gc :Gcommit <CR>

" Shortcut for git move (auto-expands current file's directory)
nmap <LEADER>gm :Gmove <C-r>=expand("%:p:h")<cr>/

" Shortcut for make
nmap <LEADER>m :!make<CR>
nmap <LEADER>mt :!make test<CR>
""""""""""""""""""""""""""""""""""""""""""""""

nmap <LEADER>t :CtrlP<CR>

"""""""""""" GENERAL VIM SETTINGS """""""""""
" Many changes from http://nvie.com/posts/how-i-boosted-my-vim/
:set mouse=a      " Enable mouse in supported terminals (iTerm 2 on Mac)
:set tabstop=4
:set expandtab
:set autoindent
:set copyindent
:set number       " Line numbering
if has("gui_macvim")
    ":set guifont=Monaco:h14    " MacVim
    :set guifont=M+\ 1mn\ light:h16
else
    :set guifont=Monospace     " Linux gVim
endif
:set shiftwidth=4
:set shiftround
:set smartcase
:set smarttab
:set hlsearch
:set incsearch
:set colorcolumn=80
:colorscheme railscasts

autocmd VimEnter * highlight SignColumn guibg=#333333
autocmd VimEnter * highlight LineNr guibg=#333333

""""""""""""" TMUX COMPATIBILITY """"""""""""""""""
" In case you use vim within tmux, add the following  
" to your .tmux.conf:
"set-window-option -g xterm-keys on

if &term =~ '^screen'
    " tmux knows the extended mouse mode
    " from http://superuser.com/questions/549930/cant-resize-vim-splits-inside-tmux
    set ttymouse=xterm2

    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"""""""""""""""" GITGUTTER """"""""""""""""""""""""
autocmd VimEnter * GitGutterLineHighlightsEnable
" GitGutter background colors
autocmd VimEnter * highlight GitGutterAddLine guibg=#333933
autocmd VimEnter * highlight GitGutterChangeLine guibg=#333339
autocmd VimEnter * highlight GitGutterDeleteLine guibg=#593333
""""""""""""""""""""""""""""""""""""""""""""""""""""

" Standard Two-space indentation for coffeescript
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

"""""""""""""""" LANGUAGE SPECIFIC """""""""""""""

"""" TYPESCRIPT """"
au BufRead,BufNewFile *.ts      setlocal filetype=typescript
set rtp+=~/.vim/bundle/typescript-tools/
""""""""""""""""""""

"""""""  C  """""""""
nmap <LEADER>c !gcc %<CR>
nmap <LEADER>r !./a.out<CR>
"""""""""""""""""""""

"""""" GOLANG """""""
nmap <LEADER>gd :GoDoc<CR>
"""""""""""""""""""""

" Use arrow keys for managing splits
nmap <UP> <C-W><UP>
nmap <DOWN> <C-W><DOWN>
nmap <LEFT> <C-W><LEFT>
nmap <RIGHT> <C-W><RIGHT>
" Shift-Arrowkey splits current file in that direction
nmap <S-UP> :split<CR>
nmap <S-DOWN> :split<CR><C-W><DOWN>
nmap <S-LEFT> :vsplit<CR>
nmap <S-RIGHT> :vsplit<CR><C-W><RIGHT>
" Ctrl-Arrowkey deletes the split on that side of the current window
" expanding the current window in that direction
nmap <C-UP> <C-W><UP>:q<CR>
nmap <C-DOWN> <C-W><DOWN>:q<CR>
nmap <C-LEFT> <C-W><LEFT>:q<CR>
nmap <C-RIGHT> <C-W><RIGHT>:q<CR>

filetype   plugin indent on

nnoremap ; :

nmap <C-CR> O<ESC>

" Reload all SnipMate snippets
"ReloadAllSnippets()


" Any 2 Postscript pretty code output for printing
function! A2PS()
	let l:filename=@%
	echo system('a2ps '.l:filename.' -o /tmp/a2ps.ps --columns=2 --tabsize=4 --prologue=fixed --line-numbers=5')
	call system('open /tmp/a2ps.ps')
endfunction
nnoremap <LEADER>p :call A2PS()<CR>

" Other stuff

filetype plugin on
set grepprg=grp\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf = 'Preview'
" Treat .m files at Objective-C instead of matlab
let filetype_m='objc'
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
" Code alignment
" use <LEADER>a or :Align
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
vnoremap <silent> <Leader>a :Align<CR>

function! AlignSection(regex) range
  let extra = 1
  let sep = empty(a:regex) ? '=' : a:regex
  let maxpos = 0
  let section = getline(a:firstline, a:lastline)
  for line in section
    let pos = match(line, ' *'.sep)
    if maxpos < pos
      let maxpos = pos
    endif
  endfor
  call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
  call setline(a:firstline, section)
endfunction

function! AlignLine(line, sep, maxpos, extra)
  let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
  if empty(m)
    return a:line
  endif
  let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
  return m[1] . spaces . m[2]
endfunction

