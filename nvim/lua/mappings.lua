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
nmap("<C-R>", "q:")
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

-- Telescope
nmap("<space>b", "<CMD>lua require('telescope.builtin').buffers{}<CR>", { desc = "Buffers" })
nmap("<space>f", "<CMD>Telescope find_files<CR>", { desc = "Open file picker" })
nmap("<space>g", "<CMD>Telescope live_grep<CR>", { desc = "Live grep" })
nmap("<space>h", "<CMD>Telescope help_tags<CR>", { desc = "Search help tags" })
nmap("<space>j", "<CMD>Telescope jumplist<CR>", { desc = "Jumplist" })
nmap("<space>d", "<CMD>Telescope diagnostics<CR>", { desc = "Diagnostics" })
nmap("<space>'", "<CMD>Telescope resume<CR>", { desc = "Open last picker" })
nmap("<space>s", "<CMD>lua require('telescope.builtin').lsp_document_symbols{}<CR>", { desc = "Document symbols" })
nmap("<space>S", "<CMD>Navbuddy<CR>", { desc = "Workspace symbols" })
nmap("<space>a", "<CMD>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
nmap("gr", "<CMD>lua require('telescope.builtin').lsp_references{}<CR>", { desc = "Goto references" })
nmap("<space>z", "<CMD>lua require('telescope.builtin').spell_suggest{}<CR>", { desc = "Show spelling suggestions" })
nmap("gd", "<CMD>lua require('telescope.builtin').lsp_definitions{}<CR>", { desc = "Goto definition" })
nmap(
    "gD",
    "<CMD>lua require('telescope.builtin').lsp_definitions{jump_type='vsplit'}<CR>",
    { desc = "Goto definition in new vsplit" }
)
nmap("<space>m", "<CMD>lua require('telescope.builtin').treesitter{}<CR>", { desc = "Treesitter Symbols" })

-- nvim.notify
nmap("<space>nn", "<CMD>Telescope notify<CR>")
nmap("<space>nd", "<CMD>lua require('notify').dismiss()<CR>")

-- Find and replace under cursor
nmap("<leader>s", ":%s/<C-r><C-w>/", { desc = "Find and replace under cursor" })
vmap("<leader>s", '"ry:%s/<C-r>r/', { desc = "Find and replace under cursor" })

-- Clear hightlight after search
nmap("<C-_>", "<CMD>nohlsearch<CR>")

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
nmap("<space>l", "<CMD>TSToggle highlight<CR>", { desc = "Toggle Treesitter highlight" })

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
nmap("<C-n>", "<CMD>NvimTreeToggle<CR>", { desc = "Open file explorer" })
nmap("<space>e", "<CMD>NvimTreeToggle<CR>", { desc = "Open file explorer" })

-- gitsigns
nmap("]c", "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", { expr = true })
nmap("[c", "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", { expr = true })

-- Trouble
nmap("<space>t", "<cmd>TroubleToggle<cr>", { desc = "Trouble" })
nmap("<space>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace" })
nmap("<space>td", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document" })
nmap("<space>tq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix" })
nmap("<space>tl", "<cmd>TroubleToggle loclist<cr>", { desc = "Loclist" })

-- Format
nmap("<C-f>", "<CMD>Format<CR>", { desc = "Format buffer" })

-- Lualine
nmap("<C-w>,", ":LualineRenameTab ", { desc = "Rename tab" })

-- write quit all
nmap("<C-x>", ":xa<CR>")

-- quick save
nmap("<C-f>", "<ESC>:wa<CR>")
imap("<C-f>", "<ESC>:wa<CR>")

-- vsnip
vim.cmd([[
    imap <expr> <TAB> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<TAB>'
    smap <expr> <TAB> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<TAB>'
    imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
    smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
]])

-- specs
nmap("<Space><Space>", '<CMD>lua require("specs").show_specs()<CR>', { desc = "Show cursor location" })
nmap("n", 'n<CMD>lua require("specs").show_specs()<CR>')
nmap("N", 'N<CMD>lua require("specs").show_specs()<CR>')

local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        { mode = "n", keys = "<C-w>" },
        { mode = "n", keys = "<Leader>" },
        { mode = "n", keys = "<Space>" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
        { mode = "n", keys = "c" },
        { mode = "n", keys = "cr" },
        { mode = "n", keys = "g" },
        { mode = "n", keys = "m" },
        { mode = "n", keys = "z" },
        { mode = "n", keys = '"' },

        { mode = "v", keys = "g" },
        { mode = "v", keys = "m" },
    },
    clues = {
        miniclue.gen_clues.builtin_completion(),
        -- miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),

        -- g
        miniclue.set_mapping_desc("n", "gc", "Comment"),
        miniclue.set_mapping_desc("n", "gcc", "Toggle comment"),

        -- [ ]
        miniclue.set_mapping_desc("n", "[c", "Previous hunk"),
        miniclue.set_mapping_desc("n", "]c", "Next hunk"),

        -- cr
        miniclue.set_mapping_desc("n", "cr", "Coerse"),
        -- miniclue.set_mapping_desc("n", "crc", "Coerse to camelCase"),
        -- miniclue.set_mapping_desc("n", "crm", "Coerce to MixedCase"),
        -- miniclue.set_mapping_desc("n", "crs", "Coerse to snake_case"),
        -- miniclue.set_mapping_desc("n", "crt", "Coerse to Title Case"),
        -- miniclue.set_mapping_desc("n", "cru", "Coerse to UPPER_SNAKE_CASE"),
        -- miniclue.set_mapping_desc("n", "cr-", "Coerse to dash-case"),
        -- miniclue.set_mapping_desc("n", "cr.", "Coerse to dot.case"),
        -- miniclue.set_mapping_desc("n", "cr ", "Coerse to space case"),

        -- z
        miniclue.set_mapping_desc("n", "zt", "Scroll cursor to top of screen"),
        miniclue.set_mapping_desc("n", "zz", "Center cursor on screen"),
        miniclue.set_mapping_desc("n", "zb", "Scroll cursor to bottom of screen"),
    },
    window = {
        delay = 250,
        config = {
            width = "auto",
        },
    },
})
