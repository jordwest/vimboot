exec pathogen#infect()
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>

nmap <LEADER>t :CtrlP<CR>

" Many changes from http://nvie.com/posts/how-i-boosted-my-vim/
:set tabstop=4
:set expandtab
:set autoindent
:set copyindent
:set number
:set guifont=Monaco:h14
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

autocmd VimEnter * GitGutterLineHighlightsEnable
" GitGutter background colors
autocmd VimEnter * highlight GitGutterAddLine guibg=#333933
autocmd VimEnter * highlight GitGutterChangeLine guibg=#333339
autocmd VimEnter * highlight GitGutterDeleteLine guibg=#593333

" Standard Two-space indentation for coffeescript
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

nmap <LEADER>c !gcc %<CR>
nmap <LEADER>r !./a.out<CR>

nmap <LEADER>n :NERDTreeToggle<CR>

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

