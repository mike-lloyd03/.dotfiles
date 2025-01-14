return {
    -- {
    --     "nvim-lualine/lualine.nvim",
    --     dependencies = {
    --         "kyazdani42/nvim-web-devicons",
    --     },
    --     keys = {
    --         { "<C-w>", ":LualineRenameTab ", desc = "Rename tab" },
    --     },
    -- },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            {
                "s1n7ax/nvim-window-picker",
                config = function()
                    require("window-picker").setup({
                        selection_chars = "ABCDEFG",
                        filter_rules = {
                            include_current_win = false,
                            autoselect_one = true,
                            bo = {
                                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                                buftype = { "terminal", "quickfix" },
                            },
                        },
                        highlights = {
                            statusline = {
                                unfocused = {
                                    fg = "#1a212e",
                                    bg = "#41a7fc",
                                    bold = true,
                                },
                            },
                        },
                    })
                end,
            },
        },
        opts = {
            popup_border_style = "rounded",
            window = {
                mappings = {
                    ["<CR>"] = "open_with_window_picker",
                    ["o"] = "open",
                    ["s"] = "vsplit_with_window_picker",
                    ["h"] = "split_with_window_picker",
                },
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    never_show = {
                        ".git",
                        ".svelte-kit",
                    },
                },
                use_libuv_file_watcher = true,
                follow_current_file = {
                    enabled = true,
                },
            },
        },
        keys = {
            { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                vim.keymap.set("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, { desc = "Next hunk", buffer = buffer })

                vim.keymap.set("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, { desc = "Previous hunk", buffer = buffer })
            end,
        },
        -- keys = {
        --     {
        --         "]c",
        --         mode = { "n" },
        --         "<CMD>Gitsigns next_hunk<CR>",
        --         desc = "Next hunk",
        --         -- expr = true,
        --     },
        --     {
        --         "[c",
        --         mode = { "n" },
        --         "<CMD>Gitsigns prev_hunk<CR>",
        --         desc = "Previous hunk",
        --         -- expr = true,
        --     },
        -- },
    },
    {
        "echasnovski/mini.move",
        version = false,
        opts = {
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
    {
        "stevearc/dressing.nvim",
        opts = {
            input = {
                enabled = false,
            },
        },
    },
    -- {
    --     "rcarriga/nvim-notify",
    --     opts = function()
    --         vim.notify = require("notify")
    --         return {
    --             max_width = 80,
    --             top_down = true,
    --             background_colour = "#000000",
    --             on_open = function(win)
    --                 vim.api.nvim_win_set_config(win, { zindex = 100 })
    --             end,
    --         }
    --     end,
    -- },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            indent = {
                animate = {
                    duration = {
                        step = 40,
                    },
                },
            },
            dashboard = {
                preset = {
                    header = [[
      █  █     
      ███ ██     
      █████     
      ██ ███     
      █  █     

N  E  O  V  I  M
                    ]],
                },
            },
            notifier = {},
            scroll = {},
            input = {},
            toggle = {},
            zen = {},
            picker = {
                win = {
                    input = {
                        keys = {
                            ["<Esc>"] = { "close", mode = { "n", "i" } },
                        },
                    },
                },
            },
            styles = {
                input = {
                    wo = {
                        winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:TelescopeBorder,FloatTitle:TelescopeTitle",
                    },
                },
            },
        },
        keys = {
            { "<space>nn", "<CMD>lua Snacks.notifier.show_history()<CR>", desc = "Show notifications" },
            { "<space>nd", "<CMD>lua Snacks.notifier.hide()<CR>", desc = "Hide notification" },
            { "<c-w>z", "<CMD>lua Snacks.zen.zoom()<CR>", desc = "Toggle zoom" },
            { "<space>uz", "<CMD>lua Snacks.zen()<CR>", desc = "Toggle zen mode" },
            {
                "<space>f",
                function()
                    Snacks.picker.files()
                end,
                desc = "File picker",
            },
            {
                "<space>g",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Live grep",
            },
            {
                "<space>s",
                function()
                    Snacks.picker.lsp_symbols()
                end,
                desc = "Document symbols",
            },
            {
                "<space>d",
                function()
                    Snacks.picker.diagnostics()
                end,
                desc = "Diagnostics",
            },
            {
                "<space>b",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<space>a",
                mode = { "n", "x", "o" },
                function()
                    vim.lsp.buf.code_action()
                end,
                desc = "Code actions",
            },
            {
                '<space>"',
                function()
                    Snacks.picker.registers()
                end,
                desc = "Registers",
            },
            {
                "<space>h",
                function()
                    Snacks.picker.help()
                end,
                desc = "Help",
            },
            -- Spelling suggestions does not exist
            -- {
            --     "<space>z",
            --     function()
            --         Snacks.picker.spell()
            --     end,
            --     desc = "Spelling suggestions",
            -- },
            {
                "<space>'",
                function()
                    Snacks.picker.resume()
                end,
                desc = "Last picker",
            },
            {
                "gr",
                function()
                    Snacks.picker.lsp_references()
                end,
                desc = "References",
            },
            {
                "gd",
                function()
                    Snacks.picker.lsp_definitions()
                end,
                desc = "Definitions",
            },
            {
                "gD",
                function()
                    Snacks.picker.lsp_definitions()
                end,
                desc = "Definitions",
            },
        },
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
                notify = {
                    enabled = false,
                },
            }
        end,
    },
    -- {
    --     "goolord/alpha-nvim",
    --     event = "VimEnter",
    --     enabled = true,
    --     init = false,
    --     opts = function()
    --         local dashboard = require("alpha.themes.dashboard")
    --         vim.api.nvim_set_hl(0, "DashboardLogo1", { fg = "#41a7fc" }) -- fg: Blue
    --         vim.api.nvim_set_hl(0, "DashboardLogo2", { fg = "#8bcd5b", bg = "#41a7fc" }) -- fg: Green bg: Blue
    --         vim.api.nvim_set_hl(0, "DashboardLogo3", { fg = "#8bcd5b" }) -- fg: Green
    --         vim.api.nvim_set_hl(0, "DashboardLogoText", { fg = "#93a4c3", bold = true })
    --
    --         dashboard.section.header.val = {
    --             --0123456789
    --             [[     █  █     ]],
    --             [[     ██ ██     ]],
    --             [[     █████     ]],
    --             [[     ██ ███     ]],
    --             [[     █  █     ]],
    --             [[]],
    --             [[N  E  O  V  I  M]],
    --         }
    --         dashboard.section.header.opts.hl = {
    --             { { "DashboardLogo1", 5, 6 }, { "DashboardLogo3", 6, 20 } },
    --             {
    --                 { "DashboardLogo1", 5, 6 },
    --                 { "DashboardLogo2", 6, 10 },
    --                 { "DashboardLogo3", 10, 24 },
    --             },
    --             { { "DashboardLogo1", 5, 10 }, { "DashboardLogo3", 10, 26 } },
    --             { { "DashboardLogo1", 5, 10 }, { "DashboardLogo3", 10, 24 } },
    --             { { "DashboardLogo1", 5, 10 }, { "DashboardLogo3", 10, 22 } },
    --             {},
    --             { { "DashboardLogoText", 0, 26 } },
    --         }
    --         dashboard.section.buttons.val = {
    --             dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
    --             dashboard.button(
    --                 "c",
    --                 " " .. " Open config",
    --                 "<cmd> cd ~/.config/nvim | e ~/.config/nvim/init.lua <cr>"
    --             ),
    --             dashboard.button("s", " " .. " Restore session", "<cmd> SessionRestore <cr>"),
    --             dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
    --         }
    --         for _, button in ipairs(dashboard.section.buttons.val) do
    --             button.opts.hl = "AlphaButtons"
    --             button.opts.hl_shortcut = "AlphaShortcut"
    --         end
    --         dashboard.section.buttons.opts.hl = "AlphaButtons"
    --         dashboard.section.footer.opts.hl = "AlphaFooter"
    --         dashboard.opts.layout[1].val = 4
    --         return dashboard
    --     end,
    --     config = function(_, dashboard)
    --         -- close Lazy and re-open when the dashboard is ready
    --         if vim.o.filetype == "lazy" then
    --             vim.cmd.close()
    --             vim.api.nvim_create_autocmd("User", {
    --                 once = true,
    --                 pattern = "AlphaReady",
    --                 callback = function()
    --                     require("lazy").show()
    --                 end,
    --             })
    --         end
    --
    --         require("alpha").setup(dashboard.opts)
    --
    --         vim.api.nvim_create_autocmd("User", {
    --             once = true,
    --             pattern = "LazyVimStarted",
    --             callback = function()
    --                 local stats = require("lazy").stats()
    --                 local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    --                 dashboard.section.footer.val = "⚡ Neovim loaded "
    --                     .. stats.loaded
    --                     .. "/"
    --                     .. stats.count
    --                     .. " plugins in "
    --                     .. ms
    --                     .. "ms"
    --                 pcall(vim.cmd.AlphaRedraw)
    --             end,
    --         })
    --     end,
    -- },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                names = false,
                tailwind = true,
            },
        },
    },
}
