local function map(mode, shortcut, command, opts)
    opts = opts or { noremap = true }
    vim.api.nvim_set_keymap(mode, shortcut, command, opts)
end

local function nmap(shortcut, command, opts)
    map("n", shortcut, command, opts)
end

local function vmap(shortcut, command, opts)
    map("v", shortcut, command, opts)
end

local function imap(shortcut, command, opts)
    map("i", shortcut, command, opts)
end

local function omap(shortcut, command, opts)
    map("o", shortcut, command, opts)
end

local function xmap(shortcut, command, opts)
    map("x", shortcut, command, opts)
end

-- This always screws me up
nmap("q:", "")

-- Better indentation
vmap(".", ">gv", { desc = "Indent line" })
vmap(",", "<gv", { desc = "Outdent line" })
nmap(".", ">>", { desc = "Indent line" })
nmap(",", "<<", { desc = "Outdent line" })

-- Scrolling
nmap("<c-k>", "10<c-y>")
nmap("<c-j>", "10<c-e>")
omap("<c-k>", "10<c-y>")
omap("<c-j>", "10<c-e>")
xmap("<c-k>", "10<c-y>")
xmap("<c-j>", "10<c-e>")

-- Helix inspiration
nmap("gh", "0", { desc = "Goto line start" })
nmap("gl", "$", { desc = "Goto line end" })
nmap("gs", "_", { desc = "Goto first non-blank in line" })
nmap("ge", "G", { desc = "Goto last line" })
nmap("g.", "g;", { desc = "Goto last modification" })

vmap("gh", "0")
vmap("gl", "$")
vmap("gs", "_")
vmap("ge", "G")

omap("gh", "0")
omap("gl", "$")
omap("gs", "_")
omap("ge", "G")

nmap("<space>w", "<C-w>", { desc = "Window" })
nmap("U", "<C-r>", { desc = "Redo" })
vmap(">", ">gv", { desc = "Indent line" })
vmap("<", "<gv", { desc = "Outdent line" })
vmap("<space>y", '"+y', { desc = "Yank to system clipboard" })
nmap("<space>y", '"+y', { desc = "Yank to system clipboard" })
nmap("<space>p", '"+p', { desc = "Paste system clipboard after cursor" })
nmap("<space>P", '"+P', { desc = "Paste system clipboard before cursor" })
vmap("<space>p", '"+p', { desc = "Paste system clipboard after cursor" })
vmap("<space>P", '"+P', { desc = "Paste system clipboard before cursor" })
nmap("mm", "%", { desc = "Goto matching bracket" })
vmap("mm", "%", { desc = "Goto matching bracket" })
nmap("<space>ya", "<CMD>%y+<CR>")

-- Find and replace under cursor
nmap("<leader>s", ":%s/<C-r><C-w>/", { desc = "Find and replace under cursor" })
vmap("<leader>s", '"ry:%s/<C-r>r/', { desc = "Find and replace under cursor" })

-- Clear hightlight after search
nmap("<space>/", "<CMD>nohlsearch<CR>", { desc = "Escape and Clear hlsearch" })

-- LSP/Diagnostics
nmap("[g", "<CMD>lua vim.diagnostic.goto_prev({float = false})<CR>", { desc = "Previous diagnostic" })
nmap("]g", "<CMD>lua vim.diagnostic.goto_next({float = false})<CR>", { desc = "Next diagnostic" })
nmap("<space>k", "<CMD>lua vim.lsp.buf.hover()<CR>", { desc = "Show docs for item under cursor" })
nmap("<space>wa", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>", { desc = "Add workspace folder" })
nmap("<space>wr", "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>", { desc = "Remove workspace folders" })
nmap(
    "<space>wp",
    "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    { desc = "Print workspace folders" }
)
nmap("<space>D", "<CMD>lua vim.lsp.buf.type_definition()<CR>", { desc = "Type definition" })
nmap("<space>r", "<CMD>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })

-- Motions
omap("ir", "i[")
omap("ar", "a[")
omap("ia", "i<")
omap("aa", "a<")
omap("iq", 'i"')
omap("aq", 'a"')
vmap("ir", "i[")
vmap("ar", "a[")
vmap("ia", "i<")
vmap("aa", "a<")
vmap("iq", 'i"')
vmap("aq", 'a"')

-- Go Imports
function FormatAndOrgImports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

nmap("gi", "<CMD>lua FormatAndOrgImports(1000)<CR>", { desc = "Format imports (Go)" })

-- How do I exit?
nmap("<space>xx", "<CMD>xa<CR>", { desc = "Write quit all" })
nmap("<space>qq", "<CMD>qa<CR>", { desc = "Quit all" })
nmap("<space>QQ", "<CMD>qa!<CR>", { desc = "Quit all without saving" })
nmap("<space>ww", "<CMD>wa<CR>", { desc = "Write all" })

-- UI settings
nmap("<space>u", "", { desc = "UI Settings" })
nmap("<space>us", "", { desc = "Scrollbind" })
nmap("<space>use", "<CMD>set scrollbind<CR>", { desc = "Enable" })
nmap("<space>usd", "<CMD>set noscrollbind<CR>", { desc = "Disable" })
nmap("<space>uc", "", { desc = "Cursorbind" })
nmap("<space>uce", "<CMD>set cursorbind<CR>", { desc = "Enable" })
nmap("<space>ucd", "<CMD>set nocursorbind<CR>", { desc = "Disable" })
nmap("<space>un", "", { desc = "Line number" })
nmap("<space>une", "<CMD>set number<CR>", { desc = "Enable" })
nmap("<space>und", "<CMD>set nonumber<CR>", { desc = "Disable" })
nmap("<space>ur", "", { desc = "Relative line number" })
nmap("<space>ure", "<CMD>set relativenumber<CR>", { desc = "Enable" })
nmap("<space>urd", "<CMD>set norelativenumber<CR>", { desc = "Disable" })
nmap("<space>ut", "<CMD>lua ToggleTransparency()<CR>", { desc = "Toggle Transparency" })

function ToggleTransparency()
    local isTransparent = vim.g.onedark_config.transparent
    require("onedark").setup({ transparent = not isTransparent })
    require("onedark").setup({ lualine = { transparent = not isTransparent } })
    require("onedark").load()
    vim.api.nvim_set_hl(0, "FoldColumn", {}) -- Clear the FoldColumn HL group so it's bg is transparent
end
