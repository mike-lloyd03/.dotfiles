return {
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
                        hint = "floating-letter",
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
            event_handlers = {
                {
                    event = "neo_tree_window_after_open",
                    handler = function(args)
                        if args.position == "left" or args.position == "right" then
                            vim.cmd("wincmd =")
                        end
                    end,
                },
                {
                    event = "neo_tree_window_after_close",
                    handler = function(args)
                        if args.position == "left" or args.position == "right" then
                            vim.cmd("wincmd =")
                        end
                    end,
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
                sources = {},
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
            { "<space>a", vim.lsp.buf.code_action, desc = "Code actions", mode = { "n", "v" } },
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
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                names = false,
                tailwind = true,
            },
        },
    },
    {
        "jackplus-xyz/player-one.nvim",
        opts = {
            is_enabled = false,
        },
        keys = {
            { "<Space>ua", "", desc = "Audio" },
            { "<Space>uae", "<cmd>PlayerOneEnable<cr>", desc = "Enable" },
            { "<Space>uad", "<cmd>PlayerOneDisable<cr>", desc = "Disable" },
        },
    },
}
