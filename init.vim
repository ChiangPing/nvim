" ====================
" === Editor Setup ===
" ====================
" ===
" === System
" ===
set clipboard=unnamedplus
" avoid the background error
let &t_ut=''
set noautochdir

"Grep
" set grepprg=rg\ --vimgrep\ --smart-case\ --follow
" set grepformat^=%f:%l:%c:%m
" command! -nargs=+ Grep execute 'silent grep! <args>' | copen

" ===
" === Editor behavior
" ===
filetype plugin indent on
set encoding=UTF-8
set autoread

" display
set number
set relativenumber
set hidden
set scrolloff=2
set cursorline
set virtualedit=block
" set colorcolumn=105
set list
set listchars=tab:▸\ ,trail:•
set wrap
set tw=0

" delay
set ttimeoutlen=0
set notimeout
set updatetime=300

" indent
set autoindent
set indentexpr=
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

"folding
set foldenable
set foldmethod=indent
set foldlevel=99

" Window behaviors
set splitright
set splitbelow

" Searching options
" set ignorecase
set smartcase

" Status/command bar
set shortmess+=c
set showcmd
set formatoptions-=tc
set noshowmode
set inccommand=split
set wildmenu
set cmdheight=2

" other
set completeopt=longest,noinsert,menuone,noselect,preview
set viewoptions=cursor,folds,slash,unix
set ttyfast "should make scrolling faster"
set lazyredraw "same as above"

" backup and undo
set nobackup
set nowritebackup
" silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
" set backupdir=~/.config/nvim/tmp/backup,.
" set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo,.
endif

" Restore Cursor Position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ====================
" ===   Mappings   ===
" ====================
" ===
" === Basic Mappings
" ===
let mapleader=" "

" Save & quit
noremap <LEADER>q :q<CR>
noremap <C-q> :qa<CR>

" Open the vimrc file anytime
noremap <LEADER>sr :e ~/.config/nvim/init.vim<CR>

" Indentation
nnoremap < <<
nnoremap > >>

" Search
noremap <LEADER><CR> :nohlsearch<CR>


" ===
" === Cursor Movement
" ===
noremap <C-k> 5k
noremap <C-j> 5j


" ===
" === Insert Mode Cursor Movement
" ===
inoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <PageUp>
inoremap <C-f> <PageDown>

inoremap <C-a> <ESC>A
" inoremap <C-f> <ESC>0<insert>

" ===
" === Command Mode Cursor Movement
" ===
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-w> <S-Right>


" ===
" === Window management
" ===
" Use <space> + arrow keys for moving the cursor around windows
noremap <LEADER>h <C-w>h
noremap <LEADER>j <C-w>j
noremap <LEADER>k <C-w>k
noremap <LEADER>l <C-w>l

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap so <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H


" ===
" === Tab/Buffer management
" ===
" Buffers
" nnoremap <silent> tl :ls<CR>
nnoremap <silent> <LEADER>b :enew<CR>
nnoremap <silent> Q :bdelete<CR>
" Create a new tab with tu
noremap tu :tabe<CR>
noremap tU :tab split<CR>
" Move around tabs with tn and ti
noremap tn :-tabnext<CR>
noremap ti :+tabnext<CR>
" Move the tabs with tmn and tmi
noremap tmn :-tabmove<CR>
noremap tmi :+tabmove<CR>

" ===
" === Others useful stuff
" ===
" noremap <LEADER>W :%s/\s\+$//<CR>:let @/=''<CR>
noremap <LEADER>w :w<CR>
noremap <LEADER>m :marks<CR>

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +5<CR>:term<CR>
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>

" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>

" Call figlet
noremap tx :r !figlet 

" find and replace
noremap \s :%s//g<left><left>

" set wrap
noremap <LEADER>sw :set wrap<CR>

" press f10 to show hlgroup
function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
map <F10> :call SynGroup()<CR>


" ====================
" === Plug Install ===
" ====================
" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ===
" === Install Plugins with Vim-Plug
" ===
call plug#begin('~/.config/nvim/plugged')
" enhacement tools
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'


" display
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'octol/vim-cpp-enhanced-highlight'


" Programming
" Plug 'tpope/vim-commentary'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'dense-analysis/ale'
Plug 'lambdalisue/vim-manpager'
Plug 'gauteh/vim-cppman'
Plug 'sbdchd/neoformat'
" Plug 'Chiel92/vim-autoformat'


"markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'mzlogin/vim-markdown-toc'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'ferrine/md-img-paste.vim'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'

call plug#end()

" ===================== Start of Plugin Settings =====================

" ===
" === NERDTree
" ===
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let NERDTreeIgnore = ['\.out$','\.o$']
let g:NERDTreeHidden=0

nnoremap <C-n> :NERDTreeToggle<CR>


" ===
" === startify
" ===
let g:startify_change_to_dir = 0

" ===
" === Undotree
" ===
nnoremap <F5> :UndotreeToggle<CR>


" ===
" === fzf
" ===
let g:fzf_action = { 'ctrl-e': 'edit' }

nmap <C-p> :Files<CR>
nmap <C-e> :Buffers<CR>

let g:fzf_preview_window = ['up:45%', 'ctrl-/']

" Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'})
      \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}),
      \   <bang>0)

" \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
" \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
" Fzf layout
let g:fzf_layout = {'window': {'width': 1, 'height': 1 }}

noremap <LEADER>H  :History<CR>
noremap <LEADER>r  :Rg<CR>
" noremap fs  :Lines<CR>
" noremap bb  :Buffers<CR>


" ===
" === easymotion
" ===
nmap <Leader>ss <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1


" ===
" === tagbar
" ===
set tags=./.tags;,.tags

nmap <F8> :TagbarToggle<CR>

" vim-gutentags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']


" ===
" === vim-airline
" ===
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab

let g:airline#extensions#tabline#buffer_idx_format = {
      \ '0': '⓪ ',
      \ '1': '① ',
      \ '2': '② ',
      \ '3': '③ ',
      \ '4': '④ ',
      \ '5': '⑤ ',
      \ '6': '⑥ ',
      \ '7': '⑦ ',
      \ '8': '⑧ ',
      \ '9': '⑨ ',
      \}

" airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = 'C:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' L:'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

let g:airline#extensions#whitespace#enabled = 0


" ===
" === rainbow
" ===
let g:rainbow_active = 1


" ===
" === indentLine
" ===
autocmd FileType json,markdown let g:indentLine_conceallevel = 0
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进


" ===
" === vim-cpp-highlight
" ===
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1


" ===
" === NERD Commenter
" ===
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
      \'c': { 'left': '/**','right': '*/' },
      \ 'cpp': { 'left': '/**', 'right': '*/' },
      \ 'h': { 'left': '/**', 'right': '*/' }}

let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1


" ===
" === coc
" ===
let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-snippets',
      \ 'coc-json',
      \ 'coc-pairs']

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" noremap <F3> :call CocAction('format')<CR>
noremap <F2> :CocCommand clangd.switchSourceHeader<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <LEADER>e :CocDiagnostics<CR>


" ===
" === Ultisnips
" ===
" let g:tex_flavor = "latex"
" inoremap <c-n> <nop>
" let g:UltiSnipsExpandTrigger="<c-e>"
" let g:UltiSnipsJumpForwardTrigger="<c-p>"
" let g:UltiSnipsJumpBackwardTrigger="<c-n>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']
" silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>
" " Solve extreme insert-mode lag on macOS (by disabling autotrigger)
" augroup ultisnips_no_auto_expansion
"     au!
"     au VimEnter * au! UltiSnips_AutoTrigger
" augroup END


" ===
" === ale
" ===
" set fenc=
let g:ale_linters = {
      \   'cpp': ['g++'],
      \   'c': ['gcc'],
      \}
let g:ale_disable_lsp = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
nmap <Leader>s :ALEToggle<CR>
nmap <Leader>d :ALEDetail<CR>


" ===
" === manpager
" ===
function! s:show_Manual()
  execute 'Man '.expand('<cword>')
endfunction

nnoremap <silent> MM :call <SID>show_Manual()<CR>


" ===
" === cppman
" ===
function! s:show_CPPManual()
  execute 'Cppman '.expand('<cword>')
endfunction

nnoremap <silent> MN :call <SID>show_CPPManual()<CR>


" ===
" === neoformat
" ===
noremap <F3> :Neoformat<CR>
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_c_clangformat = {
      \ 'exe': 'clang-format',
      \ 'args': ['-style="{ReflowComments: false}"'],
      \ }
let g:neoformat_cpp_clangformat = {
      \ 'exe': 'clang-format',
      \ 'args': ['-style="{ReflowComments: false}"'],
      \}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']


" ===
" === autoformat
" ===
" autocmd FileType c,cpp autocmd BufWritePre * :Autoformat
" noremap <F3> :Autoformat<CR>
" let g:autoformat_verbosemode=1
" let g:formatdef_allman = '"astyle --style=allman --pad-oper --indent=spaces=2"'
" let g:formatters_cpp = ['allman']
" let g:formatters_c = ['allman']

" autoformat
" nnoremap <leader>ff :call FormatCode("", "file")<CR>
" vnoremap <leader>ff :call FormatCode(visualmode(), "file")<CR>
" nnoremap <leader>gf :call FormatCode("", "Google")<CR>
" vnoremap <leader>gf :call FormatCode(visualmode(), "Google")<CR>
" nnoremap <leader>cf :call FormatCode("", "Chromium")<CR>
" vnoremap <leader>cf :call FormatCode(visualmode(), "Chromium")<CR>
" nnoremap <leader>lf :call FormatCode("", "LLVM")<CR>
" vnoremap <leader>lf :call FormatCode(visualmode(), "LLVM")<CR>
"
" func! FormatCode(exe_mode, style) range
"   if a:exe_mode == ""
"     let firstline_no = 1
"     let lastline_no = line("$")
"   else
"     let firstline_no = a:firstline
"     let lastline_no = a:lastline
"   endif
"   let l:save_formatdef = g:formatdef_clangformat
"   let l:tmpa = join(["clang-format --lines=", firstline_no, ":", lastline_no], "")
"   let g:formatdef_clangformat = "'" . l:tmpa . " --assume-filename=' . bufname('%') . ' -style=" . a:style . "'"
"   let formatcommand = ":Autoformat"
"   exec formatcommand
"   let g:formatdef_clangformat = l:save_formatdef
" endfunc


" ===
" === markdown
" ===
" md-img-paste
let g:mdip_imgdir = 'pic'
let g:mdip_imgname = 'image'
autocmd FileType markdown nnoremap <silent> <C-p> :call mdip#MarkdownClipboardImage()<CR>

" vim-markdown-toc
let g:vmt_auto_update_on_save = 0

function RToc()
  exe "/-toc .* -->"
  let lstart=line('.')
  exe "/-toc -->"
  let lnum=line('.')
  execute lstart.",".lnum."g/           /d"
endfunction

let g:bullets_enabled_file_types = [
      \ 'markdown',
      \ 'text',
      \ 'gitcommit',
      \ 'scratch'
      \]

" vim-table-mode
noremap <LEADER>tm :TableModeToggle<CR>
" let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'

" ===================== End of Plugin Settings =====================
