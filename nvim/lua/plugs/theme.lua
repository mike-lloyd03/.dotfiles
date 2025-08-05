return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "deep",
            transparent = false,
            toggle_style_key = "<leader>ts",
            lualine = {
                transparent = true,
            },
            highlights = {
                MatchParen = { fg = "$red", bg = "$none", fmt = "underline" },

                CurSearch = { bg = "$fg" },
                IncSearch = { bg = "$fg" },
                Search = { bg = "$blue" },

                ["@operator.rust"] = { fg = "$red" },
                ["@operator.@punctuation.bracket.rust"] = { fg = "$purple" },

                FoldColumn = { bg = "$bg0" },

                SnacksDashboardHeader = { fg = "$blue" },
                SnacksDashboardDesc = { fg = "$fg" },
                SnacksDashboardIcon = { fg = "$blue" },
                SnacksDashboardKey = { fg = "$red", fmt = "bold" },

                SnacksPickerBorder = { fg = "$light_grey" },
                SnacksPickerTitle = { fg = "$blue" },
                SnacksPickerMatch = { fg = "$red" },
            },
            diagnostics = {
                darker = true,
                undercurl = true,
            },
        },
        config = function(_, opts)
            require("onedark").setup(opts)
            vim.cmd([[colorscheme onedark]])
        end,
    },
}
