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


"Plugins
call plug#begin('~/.config/nvim/plugged/')

"Themes
Plug 'morhetz/gruvbox'


"Plugins IDE

"Navegar desde cualquier parte del codigo
Plug 'easymotion/vim-easymotion'

"Mostrar el arbol de directorios a la izquierda
Plug 'scrooloose/nerdtree'

"Moverse entre pantallas de nerdTRee
Plug 'christoomey/vim-tmux-navigator'





call plug#end()


"Configuraciones para los plugins
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

