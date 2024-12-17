return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        event = "VeryLazy",
        opts = function()
            vim.cmd("set showtabline=1")

            local function session_status()
                if require("auto-session-library").current_session_name() then
                    return "tracking"
                end
                return "no session"
            end

            return {
                options = {
                    icons_enabled = true,
                    theme = "onedark",
                    -- component_separators = { left = "", right = "" },
                    -- section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = { "neo-tree" },
                    always_divide_middle = true,
                    -- globalstatus = true,
                    refresh = {
                        statusline = 100,
                        winbar = 100,
                    },
                },
                sections = {
                    lualine_a = { { "mode", color = { gui = "bold" } } },
                    lualine_b = {
                        {
                            "filename",
                            file_status = true,
                            path = 1,
                        },
                    },
                    lualine_c = {
                        {
                            "branch",
                            icon = { "", color = { fg = "#DB61DB" } },
                        },
                        {
                            "diagnostics",
                            symbols = { error = "● ", warn = "● ", info = "● ", hint = "● " },
                            update_in_insert = true,
                        },
                    },
                    lualine_x = {
                        session_status,
                        "encoding",
                        "fileformat",
                        { "filetype", colored = true },
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                        },
                    },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {
                    lualine_a = {
                        {
                            "tabs",
                            mode = 1,
                            tabs_color = {
                                active = "lualine_a_insert", -- Color for active tab.
                                inactive = "lualine_b_normal", -- Color for inactive tab.
                            },
                        },
                    },
                },
                winbar = {
                    lualine_c = {
                        {
                            "navic",
                            color_correction = "static",
                            navic_opts = { highlight = true },
                            padding = {
                                right = 0,
                            },
                            draw_empty = true,
                            separator = "",
                        },
                        {
                            function()
                                return " "
                            end,
                        },
                    },
                    lualine_x = {
                        {
                            separator = nil,
                            "lsp_progress",
                            spinner_symbols = { "⣾ ", "⣽ ", "⣻ ", "⢿ ", "⡿ ", "⣟ ", "⣯ ", "⣷ " },
                            timer = {
                                spinner = 100,
                            },
                            color = { bg = nil },
                        },
                    },
                },
                inactive_winbar = {
                    lualine_c = {
                        {
                            function()
                                return " "
                            end,
                        },
                    },
                },
            }
        end,
        keys = {
            { "<C-w>,", ":LualineRenameTab ", desc = "Rename tab" },
        },
    },
}
