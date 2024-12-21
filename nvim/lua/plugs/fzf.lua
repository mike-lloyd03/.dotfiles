return {
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({})
        end,
        keys = {
            { "<space>f", "<cmd>FzfLua files<cr>", desc = "File picker" },
            { "<space>g", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
            { "<space>s", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
            { "<space>D", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
            { "<space>d", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
            { "<space>b", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
            { "<space>a", "<cmd>FzfLua lsp_code_actions<cr>", desc = "Code actions" },
            { '<space>"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
            { "<space>h", "<cmd>FzfLua helptags<cr>", desc = "Help" },
            { "<space>z", "<cmd>FzfLua spell_suggest<cr>", desc = "Spelling suggestions" },
            { "<space>'", "<cmd>FzfLua resume<cr>", desc = "Last picker" },
            { "gr", "<cmd>FzfLua lsp_references<cr>", desc = "References" },
            { "gd", "<cmd>FzfLua lsp_definitions<cr>", desc = "Definitions" },
        },
    },
}
