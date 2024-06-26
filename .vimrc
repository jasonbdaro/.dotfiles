set number relativenumber
set autoindent
set tabstop=2
set shiftwidth=2
set wrap!
set noswapfile
set hlsearch
set ignorecase
set smartcase
set colorcolumn=80
set pastetoggle=<F2>
set termguicolors
set diffopt=vertical
set encoding=UTF-8
set mouse=

syntax enable
set background=dark

" Color theme
"colorscheme solarized
colorscheme PaperColor

 " transparent background
" hi Normal guibg=NONE ctermbg=NONE
" au ColorScheme * hi Normal ctermbg=none guibg=none
" au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red

call plug#begin('~/.vim/plugged')

"Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
"Plug 'phanviet/vim-monokai-pro'
"Plug 'storyn26383/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'flazz/vim-colorschemes'
Plug 'terryma/vim-multiple-cursors'
Plug 'cakebaker/scss-syntax.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
"Plug 'crusoexia/vim-monokai'
"Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'w0rp/ale'
Plug 'itchyny/vim-gitbranch'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
" Plug 'zxqfl/tabnine-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'mhinz/vim-startify'
Plug 'MaxMEllon/vim-jsx-pretty'
"Plug 'HerringtonDarkholme/yats.vim'
Plug 'NLKNguyen/papercolor-theme'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'pantharshit00/vim-prisma'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
Plug 'sheerun/vim-polyglot'

call plug#end()

set laststatus=2
set noshowmode

" airline configs
"let g:airline_theme = 'solarized'
"let g:airline_theme = 'papercolor'
let g:airline_theme = 'molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

" fzf configs
nnoremap <silent> <C-p> :Files<CR>
let g:fzf_layout = { 'down': '~25%'  }
let g:fzf_preview_window = ['up:0']

" vim configs
imap jj <esc>
nnoremap <esc><esc> :silent! nohls<cr>
vnoremap // y/<C-R>"<CR>

" nmap gt :bnext<cr>
" nmap gT :bprev<cr>
nnoremap <silent>    <A-l> <Cmd>:bnext<CR>
nnoremap <silent>    <A-h> <Cmd>:bprev<CR>

" nerdtree configs
map <C-b> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
"autocmd vimenter * NERDTree"

" indentLine configs
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" ale configs
let g:ale_sign_column_always = 1

" vim-devicons configs
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''


" gitgutter configs
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" Ag silver searcher
"autocmd VimEnter * command! -nargs=* Ag call fzf#vim#ag(<q-args>, '', fzf#vim#with_preview())

" Startify
let g:startify_lists = []

" Markdown viewer
let g:mkdp_auto_start = 1

" save sessions
function! MakeSession(overwrite)
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  if a:overwrite == 0 && !empty(glob(b:filename))
    return
  endif
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
if(argc() == 0)
  "au VimEnter * nested :call LoadSession()
  "au VimLeave * :call MakeSession(1)
else
  "au VimLeave * :call MakeSession(0)
endif
