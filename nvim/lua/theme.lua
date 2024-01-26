-- Color scheme config
require("onedark").setup({
    style = "deep",
    transparent = true,
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
})
require("onedark").load()

-- Fix nvim slowing down when a search highlight is active
vim.cmd("hi! link CurSearch Search")
