set encoding=UTF-8

call plug#begin('~/.config/nvim/plugged')
" Define bundles via Github repos
Plug 'christoomey/vim-run-interactive'
"vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'mileszs/ack.vim' " Tha's for ack(search)
Plug 'preservim/nerdtree' " Buffer for files
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " highlighting icons/files in buffer
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sheerun/vim-polyglot' " For faster work in vim
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/tComment'
"rails
Plug 'ctrlpvim/ctrlp.vim/vim-rspec' " For searching and open files Ctrl+P
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-rails' " For many rails stuff for example gf == go find
Plug 'tpope/vim-sensible' " ...
Plug 'vim-ruby/vim-ruby'
"frontend
Plug 'jiangmiao/auto-pairs' " authpairs
Plug 'jparise/vim-graphql'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
" Plug 'mlaursen/vim-react-snippets'
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'othree/yajs.vim' not sure for what
" Plug 'pangloss/vim-javascript' not sure for what
Plug 'peitalin/vim-jsx-typescript'
"icons && theme
Plug 'luochen1990/rainbow'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'honza/vim-snippets'
Plug 'mok-aster/rails-snippets'
"theme
" Plug 'tomasiser/vim-code-dark'
" New things
Plug 'tpope/vim-endwise' "help to finish end, def ... rails
Plug 'tpope/vim-surround'

"Rust
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'

call plug#end()

"Rust
let g:rust_clip_command = 'pbcopy'

"for html snippets in rails erb
" autocmd BufNewFile,BufRead *.html.erb set filetype=html

let g:coc_disable_startup_warning = 1
"highlight debugging stuff so you don't miss it
au BufEnter *.rb syn match error contained "\<binding.pry\>"


"disabled arrow key
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <PageUp> <NOP>
nnoremap <PageDown> <NOP>
inoremap <PageUp> <NOP>
inoremap <PageDown> <NOP>
nnoremap <Cmd> <NOP>
inoremap <Cmd> <NOP>

"apply macros with Q
nnoremap Q @q
vnoremap Q :norm @q

"delete node modules from buffer
let g:NERDTreeIgnore = ['^node_modules$']
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Leader key
let mapleader = " "

"add word to spell checker
vnoremap <leader>aw :CocCommand cSpell.addWordToUserDictionary<CR>

" quit file
nnoremap <leader>q :q<cr>

" go to the next/prev characters
imap <C-l> <right>

"nerd tree mappings
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>N :NERDTreeFind<CR>
nnoremap <leader>gb :Git blame<CR>
" autocmd VimEnter * NERDSnippetsDisable

"quicker split movement in normal mode
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k

"easier splits inside vim nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j
nnoremap <leader>w <C-w>v<C-w>l

" fzf mappings
nnoremap <c-p> :GFiles --cached --others --exclude-standard<cr>

"leader a to get to Ack to search
nnoremap <leader>a :Ack
" leader k to search for the word under the cursor
nnoremap <leader>k :Ack <C-R><C-W><CR>
" We need to install rg -> brew install rg
if executable('rg')
    let g:ctrlp_user_command = 'rg --files %s'
    let g:ctrlp_use_caching = 0
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_switch_buffer = 'et'
endif

"assign ripgrep to search for ack
let g:ackprg = 'rg --vimgrep --no-heading'

"rspec vim mappings
map <Leader>s :call RunNearestSpec()<CR>:redraw!<CR><CR>:!tmux select-window -t spec<CR><CR> <CR>
map <Leader>t :call RunCurrentSpecFile()<CR>:redraw!<CR><CR>:!tmux select-window -t spec<CR><CR> <CR>
map <Leader>l :call RunLastSpec()<CR>:redraw!<CR><CR>:!tmux select-window -t spec<CR>
map <Leader>* :call RunAllSpecs()<CR>:redraw!<CR><CR>:!tmux select-window -t spec<CR><CR> <CR>

let g:rspec_command = "silent !tmux send-keys -t spec 'clear' C-m 'bundle exec spring rspec --format progress --order rand {spec}' C-m"
" Phil dotfiles let g:rspec_command = ":silent !tmux send-keys -t spec 'clear' C-m 'bundle exec spring rspec --format progress --require ~/code/rspec_support/quickfix_formatter.rb --format QuickfixFormatter --out ~/quickfix.out --order rand {spec}' C-m"
let g:rspec_runner = "os_x_iterm2"

"tmux
set cursorline
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

"tabs
map <S-t> <esc>:tabnew<CR>

"shift direction to change tabs
noremap <S-l> gt
noremap <S-h> gT

filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" set clipboard=unnamedplus " copy to buffer
map <leader>y "*y
"scrolling speed
set ttyfast

set lazyredraw

" git settings
nmap <leader>gs :G<CR>

set backspace=2
"no backups since we are always in git (almost)
set nobackup
set nowritebackup
set noswapfile

"theme
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

" colorscheme codedark

" Customizations
set relativenumber
set number
set nocompatible
set showmatch
set ruler "show cursor position all the time
set showcmd "display incomplete commands
set autowrite " hopefully this will save buffers when I switch out of them
set laststatus=2 " always show status line
set smarttab
set noincsearch
set incsearch
set nohlsearch   "no highlighting
set guioptions-=m       " Can't remember :)
set guioptions-=T       " No toolbars
set guioptions-=r       " No scrollbars
set visualbell t_vb=    " Don't beep
set hidden              " Don't prompt to save when switching buffers

" "javascript vars for vim-javascript
" let g:javascript_enable_domhtmlcss = 1

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

let g:deoplete#enable_at_startup = 1

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" fzf-checkout.vim
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
" let g:fzf_tag_actions = {
"       \ 'checkout': {'execute': '!{git} -C {cwd} checkout {branch}'},
"       \}

"style the terminal
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

" Coc
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-eslint',
      \ 'coc-git',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-pairs',
      \ 'coc-prettier',
      \ 'coc-snippets',
      \ 'coc-tslint-plugin',
      \ 'coc-tsserver',
      \ 'coc-highlight',
      \ 'coc-yaml',
      \ 'coc-spell-checker',
      \ 'coc-dictionary',
      \ 'coc-rust-analyzer',
      \ ]

"CocCommand
nmap <leader>p :CocCommand prettier.formatFile<CR>
nmap <leader>rn <Plug>(coc-rename)
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gs <Plug>(coc-codeaction-selected)<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" nnoremap <silent> K :call CocAction('doHover')<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! CheckIfCurrentBufferIsFile()
  return strlen(expand('%')) > 0
endfunction
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && CheckIfCurrentBufferIsFile() && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

function! ToggleTree()
  if CheckIfCurrentBufferIsFile()
    if IsNERDTreeOpen()
      NERDTreeClose
    else
      NERDTreeFind
    endif
  else
    NERDTree
  endif
endfunction

"size of bar
:let g:NERDTreeWinSize=45
let g:loaded_perl_provider = 0
