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
vmap(".", ">gv")
vmap(",", "<gv")
nmap(".", ">>")
nmap(",", "<<")

-- Helix inspiration
nmap("gh", "0")
nmap("gl", "$")
nmap("gs", "_")
nmap("ge", "G")
nmap("g.", "g;")

vmap("gh", "0")
vmap("gl", "$")
vmap("gs", "_")
vmap("ge", "G")

omap("gh", "0")
omap("gl", "$")
omap("gs", "_")
omap("ge", "G")

nmap("<space>w", "<C-w>")
nmap("U", "<C-r>")
vmap(">", ">gv")
vmap("<", "<gv")
vmap("<space>y", '"+y')
nmap("<space>y", '"+y')
nmap("<space>p", '"+p')
nmap("<space>P", '"+P')
vmap("<space>p", '"+p')
vmap("<space>P", '"+P')
nmap("mm", "%")
vmap("mm", "%")
nmap("<space>ya", "<CMD>%y+<CR>")

-- Telescope
nmap("<space>b", "<CMD>lua require('telescope.builtin').buffers{}<CR>")
nmap("<space>f", "<CMD>Telescope find_files<CR>")
nmap("<space>g", "<CMD>Telescope live_grep<CR>")
nmap("<space>h", "<CMD>Telescope help_tags<CR>")
nmap("<space>j", "<CMD>Telescope jumplist<CR>")
nmap("<space>d", "<CMD>Telescope diagnostics<CR>")
nmap("<space>'", "<CMD>Telescope resume<CR>")
nmap("<space>s", "<CMD>lua require('telescope.builtin').lsp_document_symbols{}<CR>")
nmap("<space>S", "<CMD>Navbuddy<CR>")
nmap("<space>a", "<CMD>lua vim.lsp.buf.code_action()<CR>")
vmap("<space>a", "<CMD>lua vim.lsp.buf.code_action()<CR>")
nmap("gr", "<CMD>lua require('telescope.builtin').lsp_references{}<CR>")
nmap("<space>z", "<CMD>lua require('telescope.builtin').spell_suggest{}<CR>")
nmap("gd", "<CMD>lua require('telescope.builtin').lsp_definitions{}<CR>")
nmap("gD", "<CMD>lua require('telescope.builtin').lsp_definitions{jump_type='vsplit'}<CR>")
nmap("<leader>sv", "<CMD>source ~/.config/nvim/init.lua<CR>")
nmap("<space>m", "<CMD>lua require('telescope.builtin').treesitter{}<CR>")

-- nvim.notify
nmap("<space>nn", "<CMD>Telescope notify<CR>")
nmap("<space>nd", "<CMD>lua require('notify').dismiss()<CR>")

-- Find and replace under cursor
nmap("<leader>s", ":%s/<C-r><C-w>/")
vmap("<leader>s", '"ry:%s/<C-r>r/')

-- Clear hightlight after search
nmap("<C-_>", "<CMD>nohlsearch<CR>")

-- LSP/Diagnostics
nmap("[g", "<CMD>lua vim.diagnostic.goto_prev()<CR>")
nmap("]g", "<CMD>lua vim.diagnostic.goto_next()<CR>")
nmap("<space>k", "<CMD>lua vim.lsp.buf.hover()<CR>")
nmap("gi", "<CMD>lua vim.lsp.buf.implementation()<CR>")
nmap("<space>wa", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>")
nmap("<space>wr", "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>")
nmap("<space>wp", "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
nmap("<space>D", "<CMD>lua vim.lsp.buf.type_definition()<CR>")
nmap("<space>r", "<CMD>lua vim.lsp.buf.rename()<CR>")
nmap("<space>l", "<CMD>TSToggle highlight<CR>")

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

nmap("gi", "<CMD>lua FormatAndOrgImports(1000)<CR>")

-- NvimTree
nmap("<C-n>", "<CMD>NvimTreeToggle<CR>")

-- gitsigns
nmap("]c", "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", { expr = true })
nmap("[c", "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", { expr = true })

-- Trouble
nmap("<space>t", "<cmd>TroubleToggle<cr>")
nmap("<space>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
nmap("<space>td", "<cmd>TroubleToggle document_diagnostics<cr>")
nmap("<space>tq", "<cmd>TroubleToggle quickfix<cr>")
nmap("<space>tl", "<cmd>TroubleToggle loclist<cr>")

-- Format
nmap("<C-f>", "<CMD>Format<CR>")

-- Lualine
nmap("<C-w>,", ":LualineRenameTab ")

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
nmap("<Space><Space>", '<CMD>lua require("specs").show_specs()<CR>')
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

        -- <Space>
        miniclue.set_mapping_desc("n", "<Space>'", "Open last picker"),
        miniclue.set_mapping_desc("n", "<Space>D", "Type definition"),
        miniclue.set_mapping_desc("n", "<Space>P", "Paste system clipboard before cursor"),
        miniclue.set_mapping_desc("n", "<Space>S", "Workspace symbols"),
        miniclue.set_mapping_desc("n", "<Space>a", "Code actions"),
        miniclue.set_mapping_desc("n", "<Space>b", "Buffers"),
        miniclue.set_mapping_desc("n", "<Space>f", "Open file picker"),
        miniclue.set_mapping_desc("n", "<Space>g", "Live grep"),
        miniclue.set_mapping_desc("n", "<Space>d", "Diagnostics"),
        miniclue.set_mapping_desc("n", "<Space>j", "Jumplist"),
        miniclue.set_mapping_desc("n", "<Space>h", "Search help tags"),
        miniclue.set_mapping_desc("n", "<Space>k", "Show docs for item under cursor"),
        miniclue.set_mapping_desc("n", "<Space>l", "Toggle Treesitter highlight"),
        miniclue.set_mapping_desc("n", "<Space>m", "Treesitter Symbols"),
        miniclue.set_mapping_desc("n", "<Space>p", "Paste system clipboard after cursor"),
        miniclue.set_mapping_desc("n", "<Space>r", "Rename"),
        miniclue.set_mapping_desc("n", "<Space>s", "Document symbols"),
        miniclue.set_mapping_desc("n", "<Space>t", "Trouble"),
        miniclue.set_mapping_desc("n", "<Space>td", "Document"),
        miniclue.set_mapping_desc("n", "<Space>tl", "Loclist"),
        miniclue.set_mapping_desc("n", "<Space>tq", "Quickfix"),
        miniclue.set_mapping_desc("n", "<Space>tw", "Workspace"),
        miniclue.set_mapping_desc("n", "<Space>w", "Window"),
        miniclue.set_mapping_desc("n", "<Space>wa", "Add workspace folder"),
        miniclue.set_mapping_desc("n", "<Space>wp", "Print workspace folders"),
        miniclue.set_mapping_desc("n", "<Space>wr", "Remove workspace folders"),
        miniclue.set_mapping_desc("n", "<Space>y", "Yank selection to system clipboard"),
        miniclue.set_mapping_desc("n", "<Space>z", "Show spelling suggestions"),

        -- g
        miniclue.set_mapping_desc("n", "g.", "Goto last modification"),
        miniclue.set_mapping_desc("n", "gD", "Goto definition in new vsplit"),
        miniclue.set_mapping_desc("n", "gc", "Comment"),
        miniclue.set_mapping_desc("n", "gcc", "Toggle comment"),
        miniclue.set_mapping_desc("n", "gd", "Goto definition"),
        miniclue.set_mapping_desc("n", "ge", "Goto last line"),
        miniclue.set_mapping_desc("n", "gh", "Goto line start"),
        miniclue.set_mapping_desc("n", "gi", "Goto implementation"),
        miniclue.set_mapping_desc("n", "gl", "Goto line end"),
        miniclue.set_mapping_desc("n", "gr", "Goto references"),
        miniclue.set_mapping_desc("n", "gs", "Goto first non-blank in line"),

        -- [ ]
        miniclue.set_mapping_desc("n", "[c", "Previous hunk"),
        miniclue.set_mapping_desc("n", "[g", "Previous diagnostic"),
        miniclue.set_mapping_desc("n", "]c", "Next hunk"),
        miniclue.set_mapping_desc("n", "]g", "Next diagnostic"),

        -- <Leader>
        -- miniclue.set_mapping_desc("n", "<Leader>s", "Find and replace under cursor"),

        -- m
        miniclue.set_mapping_desc("n", "mm", "Goto matching bracket"),
        miniclue.set_mapping_desc("n", "ms", "Surround add"),
        miniclue.set_mapping_desc("n", "mr", "Surround replace"),
        miniclue.set_mapping_desc("n", "md", "Surround delete"),
        miniclue.set_mapping_desc("v", "mm", "Goto matching bracket"),
        miniclue.set_mapping_desc("v", "ms", "Surround add"),

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
