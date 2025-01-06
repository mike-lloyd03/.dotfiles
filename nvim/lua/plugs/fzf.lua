return {
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
        opts = {
            "default-title",
            winopts = {
                backdrop = 60,
                -- title_pos = "center",
            },
            -- hls = {
            --     buf_nr = "FzfLuaFzfInfo",
            -- },
            fzf_colors = {
                true,
                ["prompt"] = { "fg", "Directory" },
                ["pointer"] = { "fg", "Directory" },
                ["gutter"] = "-1",
                ["fg+"] = { "fg", "Directory" },
                ["header"] = { "fg", "NonText" },
            },
            lsp = {
                code_actions = {
                    previewer = "codeaction_native",
                    winopts = {
                        preview = {
                            layout = "vertical",
                            vertical = "down:70%",
                        },
                    },
                },
            },
        },
        keys = function()
            local fzf_lua = require("fzf-lua")
            return {
                { "<space>f", "<cmd>FzfLua files<cr>", desc = "File picker" },
                { "<space>g", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
                { "<space>s", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
                { "<space>D", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
                { "<space>d", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
                { "<space>b", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
                { "<space>a", mode = { "n", "x", "o" }, "<cmd>FzfLua lsp_code_actions<cr>", desc = "Code actions" },
                { '<space>"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
                { "<space>h", "<cmd>FzfLua helptags<cr>", desc = "Help" },
                { "<space>z", "<cmd>FzfLua spell_suggest<cr>", desc = "Spelling suggestions" },
                { "<space>'", "<cmd>FzfLua resume<cr>", desc = "Last picker" },
                { "gr", "<cmd>FzfLua lsp_references<cr>", desc = "References" },
                {
                    "gd",
                    function()
                        fzf_lua.lsp_definitions({ jump_to_single_result = true })
                    end,
                    desc = "Definitions",
                },
                {
                    "gD",
                    function()
                        fzf_lua.lsp_definitions({
                            jump_to_single_result = true,
                            jump_to_single_result_action = require("fzf-lua.actions").file_vsplit,
                        })
                    end,
                    desc = "Definitions (vsplit)",
                },
            }
        end,
    },
}
