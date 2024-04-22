return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
    },
    "kyazdani42/nvim-tree.lua",
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
    {
        "echasnovski/mini.move",
        version = false,
        config = {
            mappings = {
                left = "<M-S-h>",
                right = "<M-S-l>",
                up = "<M-S-k>",
                down = "<M-S-j>",
                line_left = "<M-S-h>",
                line_right = "<M-S-l>",
                line_up = "<M-S-k>",
                line_down = "<M-S-j>",
            },
        },
    },
    "stevearc/dressing.nvim",
    {
        "rcarriga/nvim-notify",
        opts = function()
            vim.notify = require("notify")
            return {
                max_width = 80,
                top_down = true,
                background_colour = "#000000",
                on_open = function(win)
                    vim.api.nvim_win_set_config(win, { zindex = 100 })
                end,
            }
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = {
                enabled = false,
            },
            indent = {
                char = "│",
                -- highlight = "VertSplit",
            },
            exclude = {
                filetypes = {
                    "alpha",
                    "lazy",
                    "trouble",
                    "Trouble",
                },
            },
        },
    },
    {
        "echasnovski/mini.indentscope",
        version = false,
        opts = function()
            vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "MoreMsg" })
            return {
                symbol = "│",
                options = { try_as_border = true },
            }
        end,
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "alpha",
                    "lazy",
                    "trouble",
                    "Trouble",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = function()
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { link = "TelescopeBorder" })
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { link = "TelescopeTitle" })
            vim.api.nvim_set_hl(0, "NoiceCmdlineIconCmdline", { link = "TelescopePromptPrefix" })
            return {
                views = {
                    mini = {
                        win_options = {
                            winblend = 0,
                        },
                    },
                },
                cmdline = {
                    format = {
                        cmdline = { pattern = "^:", icon = "❯", lang = "vim" },
                    },
                },
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                messages = {
                    enabled = false,
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                            },
                        },
                        view = "mini",
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    inc_rename = true,
                },
            }
        end,
    },
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        enabled = true,
        init = false,
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            vim.api.nvim_set_hl(0, "DashboardLogo1", { fg = "#41a7fc" })
            vim.api.nvim_set_hl(0, "DashboardLogo2", { fg = "#8bcd5b", bg = "#41a7fc" })
            vim.api.nvim_set_hl(0, "DashboardLogo3", { fg = "#8bcd5b" })
            vim.api.nvim_set_hl(0, "DashboardLogoText", { fg = "#93a4c3", bold = true })

            dashboard.section.header.val = {
                [[     █  █     ]],
                [[     ██ ██     ]],
                [[     █████     ]],
                [[     ██ ███     ]],
                [[     █  █     ]],
                [[]],
                [[N  E  O  V  I  M]],
            }
            dashboard.section.header.opts.hl = {
                { { "DashboardLogo1", 6, 8 }, { "DashboardLogo3", 9, 22 } },
                {
                    { "DashboardLogo1", 6, 8 },
                    { "DashboardLogo2", 9, 11 },
                    { "DashboardLogo3", 12, 24 },
                },
                { { "DashboardLogo1", 6, 11 }, { "DashboardLogo3", 12, 26 } },
                { { "DashboardLogo1", 6, 11 }, { "DashboardLogo3", 12, 24 } },
                { { "DashboardLogo1", 6, 11 }, { "DashboardLogo3", 12, 22 } },
                {},
                { { "DashboardLogoText", 0, 26 } },
            }
            dashboard.section.buttons.val = {
                dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
                dashboard.button(
                    "c",
                    " " .. " Open config",
                    "<cmd> cd ~/.config/nvim | e ~/.config/nvim/init.lua <cr>"
                ),
                dashboard.button("s", " " .. " Restore session", "<cmd> SessionRestore <cr>"),
                dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"
            dashboard.opts.layout[1].val = 4
            return dashboard
        end,
        config = function(_, dashboard)
            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    once = true,
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                once = true,
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded "
                        .. stats.loaded
                        .. "/"
                        .. stats.count
                        .. " plugins in "
                        .. ms
                        .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },
}
