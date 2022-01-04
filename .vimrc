" Syntax highlighting
syntax on

" File type plugin
filetype indent plugin on

" Syntax highlighting debugging
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

set statusline+=%{SyntaxItem()}

" Enable rainbow parenthesis
let g:btm_rainbow_color = 0
let g:rainbow_active = 1
