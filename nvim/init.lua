require("config.lazy")
require("mappings")

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
vim.opt.showtabline = 1

-- put a line under the cursor i like
vim.opt.cursorline = true
vim.o.guicursor = "n-v-sm:block,i-ci-c:ver20,r-cr-o:hor10,a:blinkwait700-blinkoff375-blinkon375-Cursor/lCursor"

-- Smart case when searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.spell = true

vim.api.nvim_set_hl(0, "SpellBad", { underdouble = true, sp = "#8B0000" })

vim.o.fillchars = [[eob: ]]

-- Disable mouse
vim.opt.mouse = ""

-- Hyprlang config
vim.filetype.add({
    pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

-----------
-- Diagnostics
-----------
vim.opt.completeopt = "menuone,noselect,noinsert"
vim.opt.shortmess = vim.opt.shortmess + "c" -- Avoid showing extra messages when using completion

vim.diagnostic.config({
    virtual_text = false, -- Disable virtual text
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "● ",
            [vim.diagnostic.severity.WARN] = "● ",
            [vim.diagnostic.severity.INFO] = "● ",
            [vim.diagnostic.severity.HINT] = "● ",
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
    },
})

-- Set floating window border highlight to match FzfLua
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })

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
  " autocmd FileType markdown call lexical#init()
]])

if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono NFM:h10"
end
