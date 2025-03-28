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

                TelescopeBorder = { fg = "$light_grey" },
                TelescopePromptBorder = { fg = "$light_grey" },
                TelescopeResultsBorder = { fg = "$light_grey" },
                TelescopePreviewBorder = { fg = "$light_grey" },
                TelescopeMatching = { fg = "$orange", fmt = "bold" },
                TelescopePromptPrefix = { fg = "$red" },
                TelescopeTitle = { fg = "$blue", fmt = "bold" },

                CurSearch = { bg = "$fg" },
                IncSearch = { bg = "$fg" },
                Search = { bg = "$blue" },

                ["@operator.rust"] = { fg = "$red" },
                ["@operator.@punctuation.bracket.rust"] = { fg = "$purple" },

                FoldColumn = { bg = "$bg0" },
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
