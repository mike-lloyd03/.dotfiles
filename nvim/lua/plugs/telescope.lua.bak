return {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    prompt_prefix = "❯ ",
                    mappings = {
                        i = {
                            ["<esc>"] = require("telescope.actions").close,
                            ["<C-j>"] = require("telescope.actions").preview_scrolling_down,
                            ["<C-k>"] = require("telescope.actions").preview_scrolling_up,
                        },
                    },
                    layout_config = {
                        cursor = {
                            width = 60,
                            height = 10,
                        },
                        scroll_speed = 1,
                    },
                    file_ignore_patterns = {
                        "\\.git",
                    },
                },
                pickers = {
                    spell_suggest = {
                        layout_strategy = "cursor",
                        sorting_strategy = "ascending",
                    },
                    buffers = {
                        sort_lastused = true,
                        mappings = {
                            i = {
                                ["<C-b>"] = require("telescope.actions").delete_buffer,
                            },
                        },
                    },
                },
            })

            -- require("telescope").load_extension("notify")
            require("telescope").load_extension("fzf")
        end,
        keys = {
            {
                "<space>b",
                mode = { "n" },
                function()
                    require("telescope.builtin").buffers({})
                end,
                desc = "Buffers",
            },
            {
                "<space>f",
                mode = { "n" },
                function()
                    require("telescope.builtin").find_files({
                        find_command = {
                            "rg",
                            "--files",
                            "--color",
                            "never",
                            "--no-config",
                            "--hidden",
                            "--glob=!.git",
                            "--glob=!.svelte-kit",
                            "--glob=!node_modules",
                        },
                    })
                end,
                desc = "File picker",
            },
            {
                "<space>g",
                mode = { "n" },
                function()
                    require("telescope.builtin").live_grep({
                        additional_args = {
                            "--hidden",
                            "--glob=!.git",
                            "--glob=!.svelte-kit",
                            "--glob=!node_modules",
                        },
                    })
                end,
                desc = "Live grep",
            },
            { "<space>h", mode = { "n" }, "<CMD>Telescope help_tags<CR>", desc = "Help tags" },
            { "<space>j", mode = { "n" }, "<CMD>Telescope jumplist<CR>", desc = "Jumplist" },
            { "<space>d", mode = { "n" }, "<CMD>Telescope diagnostics<CR>", desc = "Diagnostics" },
            { "<space>'", mode = { "n" }, "<CMD>Telescope resume<CR>", desc = "Open last picker" },
            { '<space>"', mode = { "n" }, "<CMD>Telescope registers<CR>", desc = "Registers" },
            {
                "<space>s",
                mode = { "n" },
                function()
                    require("telescope.builtin").lsp_document_symbols({})
                end,
                desc = "Document symbols",
            },
            {
                "<space>a",
                mode = { "n", "v" },
                function()
                    vim.lsp.buf.code_action()
                end,
                desc = "Code actions",
            },
            {
                "gr",
                mode = { "n" },
                function()
                    require("telescope.builtin").lsp_references({})
                end,
                desc = "Goto references",
            },
            {
                "gd",
                mode = { "n" },
                function()
                    require("telescope.builtin").lsp_definitions({})
                end,
                desc = "Goto definition",
            },
            {
                "gD",
                mode = { "n" },
                function()
                    require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
                end,
                desc = "Goto definition in new vsplit",
            },
            {
                "<space>z",
                mode = { "n" },
                function()
                    require("telescope.builtin").spell_suggest({})
                end,
                desc = "Spelling suggestions",
            },
            -- {
            --     "<space>nn",
            --     mode = { "n" },
            --     "<CMD>Telescope notify<CR>",
            --     desc = "Notifications",
            -- },
            -- {
            --     "<space>nd",
            --     mode = { "n" },
            --     function()
            --         require("notify").dismiss()
            --     end,
            --     desc = "Dismiss notifications",
            -- },
        },
    },
}
