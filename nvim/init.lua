require("config.lazy")
require("lsp")
require("mappings")
require("statusline")

-- Command mode zsh-like autocompletion
vim.opt.signcolumn = "yes"
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore = "*.o,*~"

-- Split panes open on the right or below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Break lines at word boundaries when wrapping and wrap to previous indent
vim.opt.linebreak = true
vim.opt.breakindent = true

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- autoindent and tab options
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- put a line under the cursor
vim.opt.cursorline = true

-- Smart case when searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.spell = true

-- -- ufo syntax folding
-- vim.opt.foldcolumn = "1"
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldenable = true
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.o.fillchars = [[eob: ]]

-- Disable mouse
vim.opt.mouse = ""

-----------
-- Auto Commands
-----------
-- Markdown bindings
vim.cmd([[
  autocmd FileType markdown,typst noremap <buffer> <silent> k gk
  autocmd FileType markdown,typst noremap <buffer> <silent> j gj
  autocmd FileType markdown,typst noremap <buffer> <silent> 0 g0
  autocmd FileType markdown,typst noremap <buffer> <silent> $ g$
  autocmd FileType markdown,typst setlocal spell spelllang=en_us
  autocmd FileType markdown call lexical#init()
]])

-- Format on Save
vim.cmd([[
    autocmd BufWritePost * FormatWrite
]])
