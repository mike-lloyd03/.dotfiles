local function nmap(shortcut, command, opts)
    opts = opts or { noremap = true }
    vim.api.nvim_set_keymap("n", shortcut, command, opts)
end

local function vmap(shortcut, command, opts)
    opts = opts or { noremap = true }
    vim.api.nvim_set_keymap("v", shortcut, command, opts)
end

local function imap(shortcut, command, opts)
    opts = opts or { noremap = true }
    vim.api.nvim_set_keymap("i", shortcut, command, opts)
end

local function omap(shortcut, command, opts)
    opts = opts or { noremap = true }
    vim.api.nvim_set_keymap("o", shortcut, command, opts)
end

-- This always screws me up
nmap("q:", "")

-- Better indentation
vmap(".", ">gv", { desc = "Indent line" })
vmap(",", "<gv", { desc = "Outdent line" })
nmap(".", ">>", { desc = "Indent line" })
nmap(",", "<<", { desc = "Outdent line" })

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

-- nvim.notify
nmap("<space>n", "<CMD><CR>", { desc = "Notifications" })
nmap("<space>nn", "<CMD>Telescope notify<CR>")
nmap("<space>nd", "<CMD>lua require('notify').dismiss()<CR>")

-- Find and replace under cursor
nmap("<leader>s", ":%s/<C-r><C-w>/", { desc = "Find and replace under cursor" })
vmap("<leader>s", '"ry:%s/<C-r>r/', { desc = "Find and replace under cursor" })

-- Clear hightlight after search
nmap("<C-_>", "<CMD>nohlsearch<CR>")
-- nmap("<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- LSP/Diagnostics
nmap("[g", "<CMD>lua vim.diagnostic.goto_prev()<CR>", { desc = "Previous diagnostic" })
nmap("]g", "<CMD>lua vim.diagnostic.goto_next()<CR>", { desc = "Next diagnostic" })
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

-- NvimTree
-- nmap("<C-n>", "<CMD>NvimTreeToggle<CR>", { desc = "Open file explorer" })
-- nmap("<space>e", "<CMD>NvimTreeToggle<CR>", { desc = "Open file explorer" })

-- gitsigns
nmap("]c", "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", { expr = true, desc = "Next hunk" })
nmap("[c", "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", { expr = true, desc = "Previous hunk" })

-- Trouble
nmap("<space>t", "<cmd><cr>", { desc = "Trouble" })
nmap("<space>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace" })
nmap("<space>td", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document" })
nmap("<space>tq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix" })
nmap("<space>tl", "<cmd>TroubleToggle loclist<cr>", { desc = "Loclist" })

-- Format
nmap("<C-f>", "<CMD>Format<CR>", { desc = "Format buffer" })

-- Lualine
nmap("<C-w>,", ":LualineRenameTab ", { desc = "Rename tab" })

-- How do I exit?
nmap("<space>xx", "<CMD>xa<CR>", { desc = "Write quit all" })
nmap("<space>qq", "<CMD>qa<CR>", { desc = "Quit all" })
nmap("<space>QQ", "<CMD>qa!<CR>", { desc = "Quit all without saving" })
nmap("<space>ww", "<CMD>wa<CR>", { desc = "Write all" })

-- -- specs
-- nmap("<Space><Space>", '<CMD>lua require("specs").show_specs()<CR>', { desc = "Show cursor location" })
-- nmap("n", 'n<CMD>lua require("specs").show_specs()<CR>')
-- nmap("N", 'N<CMD>lua require("specs").show_specs()<CR>')

-- todo-comments
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

nmap("<Space>xt", "<CMD>TodoTelescope<CR>", { desc = "Todo List" })

-- auto-session
nmap("<Space>q", "<CMD><CR>", { desc = "Session" })
nmap("<Space>qr", "<CMD>SessionRestore<CR>", { desc = "Restore session" })
nmap("<Space>qd", "<CMD>SessionDelete<CR>", { desc = "Delete session" })
nmap("<Space>qs", "<CMD>SessionSave<CR>", { desc = "Save session" })

-- UI settings
nmap("<Space>u", "", { desc = "UI Settings" })
nmap("<Space>us", "", { desc = "Scrollbind" })
nmap("<Space>use", "<CMD>set scrollbind<CR>", { desc = "Enable" })
nmap("<Space>usd", "<CMD>set noscrollbind<CR>", { desc = "Disable" })
nmap("<Space>uc", "", { desc = "Cursorbind" })
nmap("<Space>uce", "<CMD>set cursorbind<CR>", { desc = "Enable" })
nmap("<Space>ucd", "<CMD>set nocursorbind<CR>", { desc = "Disable" })
nmap("<Space>un", "", { desc = "Line number" })
nmap("<Space>une", "<CMD>set number<CR>", { desc = "Enable" })
nmap("<Space>und", "<CMD>set nonumber<CR>", { desc = "Disable" })
nmap("<Space>ur", "", { desc = "Relative line number" })
nmap("<Space>ure", "<CMD>set relativenumber<CR>", { desc = "Enable" })
nmap("<Space>urd", "<CMD>set norelativenumber<CR>", { desc = "Disable" })
nmap("<Space>ut", "<CMD>lua ToggleTransparency()<CR>", { desc = "Toggle Transparency" })

function ToggleTransparency()
    local isTransparent = vim.g.onedark_config.transparent
    require("onedark").setup({ transparent = not isTransparent })
    require("onedark").setup({ lualine = { transparent = not isTransparent } })
    require("onedark").load()
    vim.api.nvim_set_hl(0, "FoldColumn", {}) -- Clear the FoldColumn HL group so it's bg is transparent
end
