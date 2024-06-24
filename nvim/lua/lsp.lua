vim.opt.completeopt = "menuone,noselect,noinsert"
vim.opt.shortmess = vim.opt.shortmess + "c" -- Avoid showing extra messages when using completion

vim.diagnostic.config({
    virtual_text = false, -- Disable virtual text
    severity_sort = true,
})

local python_venv = "$HOME/.config/nvim/venv-nvim"

vim.g.python3_host_prog = python_venv .. "/bin/python"

local signs = { Error = "● ", Warn = "● ", Info = "● ", Hint = "● " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local function navic_attach(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
        -- require("nvim-navbuddy").attach(client, bufnr)
    end
end

----------------------------
-- Defaul LSP Config
----------------------------
require("lspconfig").bashls.setup({
    -- on_attach = navic_attach,
})
require("lspconfig").gopls.setup({
    on_attach = navic_attach,
})
require("lspconfig").pyright.setup({
    on_attach = navic_attach,
})
require("lspconfig").svelte.setup({
    on_attach = navic_attach,
})
require("lspconfig").tsserver.setup({
    on_attach = navic_attach,
})
require("lspconfig").eslint.setup({})
require("lspconfig").jsonls.setup({
    on_attach = navic_attach,
})
require("lspconfig").ccls.setup({})
require("lspconfig").kotlin_language_server.setup({})
require("lspconfig").nil_ls.setup({})
require("lspconfig").typst_lsp.setup({})

-- local MY_FQBN = "arduino:avr:mega"
-- require("lspconfig").arduino_language_server.setup({
--     cmd = {
--         "arduino-language-server",
--         "-cli-config",
--         "~/.arduino15/arduino-cli.yaml",
--         "-fqbn",
--         MY_FQBN,
--         "-log",
--         "-logpath",
--         "/home/mike/als_log",
--     },
-- })

require("lspconfig").arduino_language_server.setup({})

----------------------------
-- Lua Config
----------------------------
require("lspconfig").lua_ls.setup({
    on_attach = navic_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

----------------------------
-- Ansible Config
----------------------------
require("lspconfig").ansiblels.setup({
    settings = {
        ansible = {
            ansible = {
                useFullyQualifiedCollectionNames = false,
            },
            ansibleLint = {
                arguments = "-x fqcn-builtins",
            },
        },
    },
})

----------------------------
-- null-ls Config
----------------------------
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.revive.with({
            args = { "-formatter", "json", "-config", "/home/mike/.config/revive.toml", "./..." },
        }),
    },
})
