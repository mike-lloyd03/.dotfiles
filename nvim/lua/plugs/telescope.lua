return {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
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

            require("telescope").load_extension("notify")
            require("telescope").load_extension("fzf")
        end,
    },
}
