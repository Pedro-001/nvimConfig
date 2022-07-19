set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set laststatus=2

"" Searching
set hlsearch	"highlight matches
set incsearch	"incremental searching
set ignorecase 	"searches are case insensitive
set smartcase 	" ... unless they contain at least one capital letter


"Plugins
call plug#begin('~/.config/nvim/plugged/')

"Themes
Plug 'morhetz/gruvbox'

"""""""""""""""""""""""""""
"Plugins IDE
""""""""""""""""""""""""""""

"Navegar desde cualquier parte del codigo
Plug 'easymotion/vim-easymotion'

"Mostrar el arbol de directorios a la izquierda
Plug 'scrooloose/nerdtree'

"Moverse entre pantallas de nerdTRee
Plug 'christoomey/vim-tmux-navigator'

"autocompletado de parentesis
Plug 'jiangmiao/auto-pairs'

"Autocompletado y cerrado de etiquetas de html y react
Plug 'alvan/vim-closetag'

"autocompletado de codigo js
Plug 'sirver/ultisnips'

" intelisens js python type
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"multiples cursores
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"Mostrar Lineas indentadas
Plug 'Yggdroot/indentLine'

"Comentar lineas
Plug 'preservim/nerdcommenter'

"Busqueda de archivos
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""
"Configuraciones para los plugins
""""""""""""""""""""""""""""""""""""

"configuración del theme gruvbox
colorscheme gruvbox
let g:gruvbox_contrast_dart ="hard"

"configuracion nerdtree para cerrarlo después de abrir un archivo
"let NERDTreeQuitOnOpen=1



"""""""""""""""""""""""""""
"Shortcuts para los plugins
""""""""""""""""""""""""""""

"configuración de tecla leader
let mapleader=" "

"Comando para usar easymotion
nmap <Leader>s <Plug>(easymotion-s2)

"Comando para abrir el arbol de directorios de nerdtree
nmap <Leader>nt :NERDTreeFind<CR>

"Comandos para saltar entre ventanas nerdtree control + H o L
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>

"Buscar archivos
map <Leader>p :Files<CR>

"Buscar cadenas de texto
map <Leader>ag :Ag<CR>

"Atajos para el autocompletado
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Buffers o archivos abiertos durante la sesión de nvim
"map <Leader>ob :Buffers<cr> 
nnoremap <leader>bb :buffers<cr>:b<space> 


" run current file
nnoremap <Leader>x :!node %<cr>

" Use <c-space> to trigger completion.
"if &filetype == "javascript" || &filetype == "python"
  "inoremap <c-space> <C-x><C-u>
"else
  inoremap <silent><expr> <c-space> coc#refresh()
"endif


set splitright
function! OpenTerminal()
  " move to right most buffer
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"

  let bufNum = bufnr("%")
  let bufType = getbufvar(bufNum, "&buftype", "not found")

  if bufType == "terminal"
    " close existing terminal
    execute "q"
  else
    " open terminal
    execute "vsp term://bash"

    " turn off numbers
    execute "set nonu"
    execute "set nornu"

    " toggle insert on enter/exit
    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!

    " set maps inside terminal buffer
    execute "tnoremap <buffer> <C-h> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q<CR>"
    execute "tnoremap <buffer> <C-\\><C-\\> <C-\\><C-n>"

    startinsert!
  endif
endfunction
nnoremap <C-t> :call OpenTerminal()<CR>

inoremap <expr> <CR> ParensIndent()

function! ParensIndent()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<CR>\<ESC>O"
  endif
  
  return "\<CR>"
endfunction

inoremap <expr> <space> ParensSpacing()

function! ParensSpacing()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<space>\<space>\<left>"
  endif
  
  return "\<space>"
endfunction

inoremap <expr> <BS> ParensRemoveSpacing()

function! ParensRemoveSpacing()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')

  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<bs>\<right>\<bs>"
  endif
  
  if (prevChar == ' ' && afterChar == ' ')
    let prev = col('.') - 2
    let after = col('.') + 1
    let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
    let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
    if (prevChar == '"' && afterChar == '"') ||
  \    (prevChar == "'" && afterChar == "'") ||
  \    (prevChar == "(" && afterChar == ")") ||
  \    (prevChar == "{" && afterChar == "}") ||
  \    (prevChar == "[" && afterChar == "]")
      return "\<bs>\<right>\<bs>"
    endif
  endif
  
  return "\<bs>"
endfunction

inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap ' ''<left>
inoremap " ""<left>

let curly = "}"
inoremap <expr> } CheckNextParens(curly)

let bracket = "]"
inoremap <expr> ] CheckNextParens(bracket)

let parens = ")"
inoremap <expr> ) CheckNextParens(parens)

let quote = "'"
inoremap <expr> ' CheckNextQuote(quote)

let dquote = '"'
inoremap <expr> " CheckNextQuote(dquote)

let bticks = '`'
inoremap <expr> ` CheckNextQuote(bticks)

function CheckNextQuote(c)
  let after = col('.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  
  if (afterChar == a:c)
    return "\<right>"
  endif
  if (afterChar == ' ' || afterChar == '' || afterChar == ')' || afterChar== '}' || afterChar == ']')
    return a:c . a:c . "\<left>"
  endif
  if (afterChar != a:c)
    let bticks = '`'
    let dquote = '"'
    let quote = "'"
    if(afterChar == dquote || afterChar == quote || afterChar == bticks)
      return a:c . a:c . "\<left>"
    endif
  endif
  return a:c
endfunction

function CheckNextParens(c)
  let after = col('.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (afterChar == a:c)

    return "\<right>"
  endif
  return a:c
endfunction
