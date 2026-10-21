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
        config = function(_, opts)
            require("onedark").setup(opts)
            -- onedark keeps style = "light" after background goes back to dark, so reset it on every change
            vim.api.nvim_create_autocmd("OptionSet", {
                pattern = "background",
                callback = function()
                    require("onedark").set_options("style", vim.o.background == "light" and "light" or "deep")
                    vim.cmd.colorscheme("onedark")
                end,
            })
        end,
        keys = {
            {
                "<space>ut",
                function()
                    require("onedark").toggle()
                end,
                desc = "Toggle Theme",
            },
        },
    },
    { "shaunsingh/nord.nvim", priority = 1000 },
}
