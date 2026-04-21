return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            vim.opt.termguicolors = true
        end,
        opts = {
            style = "deep",
            transparent = false,
            toggle_style_key = "<leader>ts",
            lualine = {
                transparent = false,
            },
            highlights = {
                -- MatchParen = { fg = "$red", bg = "$none", fmt = "underline" },
                --
                -- CurSearch = { bg = "$fg" },
                -- IncSearch = { bg = "$fg" },
                -- Search = { bg = "$blue" },
                --
                -- ["@operator.rust"] = { fg = "$red" },
                -- ["@operator.@punctuation.bracket.rust"] = { fg = "$purple" },
                --
                -- FoldColumn = { bg = "$bg0" },
                --
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
    },
    -- {
    --     "olimorris/onedarkpro.nvim",
    --     priority = 1000,
    --     init = function()
    --         vim.opt.termguicolors = true
    --     end,
    --     opts = {
    --         highlights = {
    --             Cursor = { bg = "${blue}", fg = "${white}" },
    --             CursorLineNr = { fg = "${blue}" },
    --         },
    --     },
    -- },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
    },
}
