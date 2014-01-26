exec pathogen#infect()
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>

" Many changes from http://nvie.com/posts/how-i-boosted-my-vim/
:set tabstop=4
:set expandtab
:set autoindent
:set copyindent
:set number
:set bg=dark
:set guifont=Monaco:h14
:set lines=42
:set columns=175
:set shiftwidth=4
:set shiftround
:set smartcase
:set smarttab
:set hlsearch
:set incsearch
:set colorcolumn=80
:colorscheme railscasts

nmap <LEADER>c !gcc %<CR>
nmap <LEADER>r !./a.out<CR>

nmap <LEADER>n :NERDTreeToggle<CR>

filetype plugin indent on

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

