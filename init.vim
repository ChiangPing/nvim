" ==================== Editor behavior ====================
let &t_ut=''
set clipboard=unnamedplus
" avoid the background error
set noautochdir
set mouse=a

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
set colorcolumn=105
set list
set listchars=tab:▸\ ,trail:•
set wrap
set tw=0

" delay
set ttimeoutlen=0
set notimeout
set updatetime=200

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
set cmdheight=1

" other
set completeopt=longest,noinsert,menuone,noselect,preview
set viewoptions=cursor,folds,slash,unix
set ttyfast "should make scrolling faster"
set lazyredraw "same as above"

" sessions, undo, backup
silent !mkdir -p ~/.config/nvim/tmp/sessions

silent !mkdir -p ~/.config/nvim/tmp/undo
if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo,.
endif

set nobackup
set nowritebackup
" silent !mkdir -p ~/.config/nvim/tmp/backup
" set backupdir=~/.config/nvim/tmp/backup,.
" set directory=~/.config/nvim/tmp/backup,.

" Grep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
set grepformat^=%f:%l:%c:%m
command! -nargs=+ Grep execute 'silent grep! <args>' | copen

" Restore Cursor Position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Basic Mappings
" ===
let mapleader=" "
" Save & Quit
noremap <leader>w :w<CR>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
noremap <leader>q :q<CR>
noremap <C-q> :qa<CR>

" ===
" === Insert Mode Cursor Movement
" ===
inoremap <A-l> <Right>
inoremap <A-h> <Left>
inoremap <A-k> <Up>
inoremap <A-j> <Down>
inoremap <A-b> <S-Left>
inoremap <A-w> <S-Right>
inoremap <C-a> <ESC>A

" ===
" === Command Mode Cursor Movement
" ===
cnoremap <A-k> <Up>
cnoremap <A-j> <Down>
cnoremap <A-h> <Left>
cnoremap <A-l> <Right>
cnoremap <A-b> <S-Left>
cnoremap <A-w> <S-Right>

" ===
" === Window management
" ===
noremap <leader>h <C-w>h
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l

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

" Place the two screens up and down, side by side
noremap tk <C-w>t<C-w>K
noremap th <C-w>t<C-w>H

" Rotate screens
noremap bk <C-w>b<C-w>K
noremap bh <C-w>b<C-w>H

" ===
" === Others useful stuff
" ===
" nnoremap < <<
" nnoremap > >>

noremap <C-k> 5k
noremap <C-j> 5j
noremap <leader>m :marks<CR>
noremap <leader><CR> :nohlsearch<CR>
noremap <leader>sr :e ~/.config/nvim/init.vim<CR>
noremap <leader>sc :set spell!<CR>
noremap <leader>sw :set wrap<CR>
noremap \s :%s//g<left><left>

" Terminal window
noremap <leader>/ :set splitbelow<CR>:split<CR>:res +3<CR>:term<CR>
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>

" F10 to show hlgroup
function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
map <F10> :call SynGroup()<CR>


" ==================== Auto load for first time uses ====================
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" let g:nvim_plugins_installation_completed=1
" if empty(glob($HOME.'/.config/nvim/plugged/wildfire.vim/autoload/wildfire.vim'))
"   let g:nvim_plugins_installation_completed=0
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

" ===
" === Install Plugins with Vim-Plug
" ===
call plug#begin('~/.config/nvim/plugged')
" enhacement tools
Plug 'kyazdani42/nvim-tree.lua'
Plug 'mbbill/undotree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'

" display
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'petertriho/nvim-scrollbar'
Plug 'karb94/neoscroll.nvim'
Plug 'tpope/vim-surround'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'

" Programming
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'windwp/nvim-autopairs'
Plug 'preservim/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'RRethy/vim-illuminate'
Plug 'folke/trouble.nvim'
" Plug 'SirVer/ultisnips'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" markdown
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
" === NvimTree
" ===
lua << EOF
vim.g.nvim_tree_root_folder_modifier = ":e"
vim.g.nvim_tree_icon_padding = " "
vim.g.nvim_tree_symlink_arror = "  "
vim.g.nvim_tree_respect_buf_cwd = 1

vim.g.nvim_tree_icons = {
  ["default"] = "", --
  ["symlink"] = "",
  ["git"] = {
    ["unstaged"] = "",
    ["staged"] = "", --
    ["unmerged"] = "שׂ",
    ["renamed"] = "", --
    ["untracked"] = "ﲉ",
    ["deleted"] = "",
    ["ignored"] = "", --◌
  },
  ["folder"] = {
    -- ['arrow_open'] = "",
    -- ['arrow_closed'] = "",
    ["arrow_open"] = "",
    ["arrow_closed"] = "",
    ["default"] = "",
    ["open"] = "",
    ["empty"] = "",
    ["empty_open"] = "",
    ["symlink"] = "",
    ["symlink_open"] = "",
  },
}

require("nvim-tree").setup({
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = true,
  view = {
    width = 30,
    height = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    hide_root_folder = false,
  },
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  filters = {
    dotfiles = false,
    custom = { ".DS_Store", ".git" },
    exclude = {},
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
})
EOF
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>


" ===
" === Undotree
" ===
nnoremap <leader>u :UndotreeToggle<CR>


" ===
" === telescope
" ===
lua << EOF
require('telescope').setup{
  defaults = {
    prompt_prefix = "  ",
    layout_strategy = 'vertical',
    layout_config = { height = 0.99 },
    file_ignore_patterns = {},
  },
}
EOF
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>


" ===
" === easymotion
" ===
nmap <Leader>ss <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1


" ===
" === tagbar
" ===
set tags=./.tags;,.tags
nmap <A-n> :TagbarToggle<CR>
" vim-gutentags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q', '--c++-kinds=+px', '--c-kinds=+px']


" ===
" === colorscheme
" ===
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg
colorscheme catppuccin


" ===
" === bufferline
" ===
lua << EOF
require("bufferline").setup({
  options = {
    numbers = "ordinal",
    modified_icon = "✥",
    buffer_close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    show_buffer_close_icons = true,
    show_buffer_icons = true,
    show_tab_indicators = true,
    diagnostics = "coc",
    always_show_bufferline = true,
    separator_style = "thin",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        padding = 1,
      },
    },
  },
})
EOF
nnoremap <silent><leader>= :BufferLineCycleNext<CR>
nnoremap <silent><leader>- :BufferLineCyclePrev<CR>
nnoremap <silent><leader>1 :BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 :BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 :BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 :BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 :BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 :BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 :BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 :BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 :BufferLineGoToBuffer 9<CR>
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>
nnoremap <silent>bq :bdelete<CR>
nnoremap <silent>bw :bwipeout<CR>


" ===
" === lualine
" ===
lua << EOF
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = "|",
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {
      {
        'filename',
        file_status = true,
        symbols = {
          readonly = ' ',
          unnamed = '[No Name]',
          modified = ''
        }
      }
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
      },
    },
    lualine_y = {
      {
        "filetype",
        "encoding",
      },
      {
        "fileformat",
        icons_enabled = true,
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
    },
    lualine_z = {'progress', 'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
})
EOF


" ===
" === scrollbar
" ===
lua << EOF
require("scrollbar").setup()
EOF


" ===
" === neoscroll
" ===
lua << EOF
require('neoscroll').setup({
  mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb'},
  hide_cursor = true,          -- Hide cursor while scrolling
  stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = nil,       -- Default easing function
  pre_hook = nil,              -- Function to run before the scrolling animation starts
  post_hook = nil,             -- Function to run after the scrolling animation ends
  performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})
EOF


" ===
" === rainbow
" ===
let g:rainbow_active = 1


" ===
" === indentLine
" ===
autocmd FileType json,markdown let g:indentLine_conceallevel = 0
let g:indent_guides_guide_size = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level = 2  " 从第二层开始可视化显示缩进


" ===
" === trouble
" ===
lua <<EOF
require("trouble").setup({
  position = "bottom", -- position of the list can be: bottom, top, left, right
  height = 10, -- height of the trouble list when position is top or bottom
  width = 50, -- width of the list when position is left or right
  icons = true, -- use devicons for filenames
  mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open = "", -- icon used for open folds
  fold_closed = "", -- icon used for closed folds
  action_keys = {
    -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping, for example:
    -- close = {},
    close = "q", -- close the list
    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r", -- manually refresh
    jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
    open_split = { "<c-x>" }, -- open buffer in new split
    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
    open_tab = { "<c-t>" }, -- open buffer in new tab
    jump_close = { "o" }, -- jump to the diagnostic and close the list
    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P", -- toggle auto_preview
    hover = "K", -- opens a small popup with the full multiline message
    preview = "p", -- preview the diagnostic location
    close_folds = { "zM", "zm" }, -- close all folds
    open_folds = { "zR", "zr" }, -- open all folds
    toggle_fold = { "zA", "za" }, -- toggle fold of current file
    previous = "k", -- preview item
    next = "j", -- next item
  },
  indent_lines = true, -- add an indent guide below the fold icons
  auto_open = false, -- automatically open the list when you have diagnostics
  auto_close = false, -- automatically close the list when you have no diagnostics
  auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold = false, -- automatically fold a file trouble list at creation
  signs = {
    -- icons / text used for a diagnostic
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠",
  },
  use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})
EOF


" ===
" === lsp-config
" ===
lua << EOF
require("nvim-lsp-installer").setup({
  ensure_installed = { "clangd" }, -- ensure these servers are always installed
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})
EOF

" ===
" === nvim-cmp
" ===
set completeopt=menu,menuone,noselect
lua <<EOF
vim.cmd([[highlight CmpItemAbbrDeprecated guifg=#D8DEE9 guibg=NONE gui=strikethrough]])
vim.cmd([[highlight CmpItemKindSnippet guifg=#BF616A guibg=NONE]])
vim.cmd([[highlight CmpItemKindUnit guifg=#D08770 guibg=NONE]])
vim.cmd([[highlight CmpItemKindProperty guifg=#A3BE8C guibg=NONE]])
vim.cmd([[highlight CmpItemKindKeyword guifg=#EBCB8B guibg=NONE]])
vim.cmd([[highlight CmpItemAbbrMatch guifg=#5E81AC guibg=NONE]])
vim.cmd([[highlight CmpItemAbbrMatchFuzzy guifg=#5E81AC guibg=NONE]])
vim.cmd([[highlight CmpItemKindVariable guifg=#8FBCBB guibg=NONE]])
vim.cmd([[highlight CmpItemKindInterface guifg=#88C0D0 guibg=NONE]])
vim.cmd([[highlight CmpItemKindText guifg=#81A1C1 guibg=NONE]])
vim.cmd([[highlight CmpItemKindFunction guifg=#B48EAD guibg=NONE]])
vim.cmd([[highlight CmpItemKindMethod guifg=#B48EAD guibg=NONE]])

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      -- require("cmp-under-comparator").under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
   },
  formatting = {
    format = function(entry, vim_item)
      local lspkind_icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }
      -- load lspkind icons
    vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)

    vim_item.menu = ({
      -- cmp_tabnine = "[TN]",
      buffer = "[BUF]",
      orgmode = "[ORG]",
      nvim_lsp = "[LSP]",
      nvim_lua = "[LUA]",
      path = "[PATH]",
      tmux = "[TMUX]",
      vsnip = "[SNIP]",
      spell = "[SPELL]",
    })[entry.source.name]

      return vim_item
    end,
  },
    -- You can set mappings if you want
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      --require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "vsnip" },
    { name = "path" },
    { name = "spell" },
    { name = "tmux" },
    { name = "orgmode" },
    { name = "buffer" },
    { name = "latex_symbols" },
    -- {name = 'cmp_tabnine'}
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}
EOF


" ===
" === nerdcommenter
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
" === illuminate
" ===
lua << EOF
require'lspconfig'.gopls.setup {
  on_attach = function(client)
    vim.g.Illuminate_highlightUnderCursor = 0
    vim.g.Illuminate_ftblacklist = {
      "help",
      "dashboard",
      "alpha",
      "packer",
      "norg",
      "DoomInfo",
      "NvimTree",
      "Outline",
      "toggleterm",
    }
    require 'illuminate'.on_attach(client)
  end,
}
EOF


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
noremap <leader>tm :TableModeToggle<CR>
" let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'

" ===================== End of Plugin Settings =====================
