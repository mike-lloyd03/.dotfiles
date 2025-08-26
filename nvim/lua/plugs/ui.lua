return {
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
            image = {},
            toggle = {},
            zen = {},
            lazygit = {},
            picker = {
                win = {
                    input = {
                        keys = {
                            ["<Esc>"] = { "close", mode = { "n", "i" } },
                        },
                    },
                    list = {
                        keys = {
                            ["s"] = { { "pick_win", "edit_vsplit" } },
                            ["<CR>"] = { { "pick_win", "confirm" } },
                            ["<C-n>"] = "cancel",
                            ["<ESC>"] = "",
                            ["<C-j>"] = "list_scroll_down",
                            ["<C-k>"] = "list_scroll_up",
                        },
                    },
                },
                sources = {},
                actions = {
                    pick_win = function(picker, item, action)
                        if item.dir then
                            return
                        end

                        if not picker.layout.split then
                            picker.layout:hide()
                        end
                        local win = Snacks.picker.util.pick_win({
                            main = picker.main,
                            float = false,
                            filter = function(_, buf)
                                local ft = vim.bo[buf].ft
                                return ft == "snacks_dashboard" or not ft:find("^snacks")
                            end,
                        })
                        if not win then
                            if not picker.layout.split then
                                picker.layout:unhide()
                            end
                            return true
                        end
                        picker.main = win
                        if not picker.layout.split then
                            vim.defer_fn(function()
                                if not picker.closed then
                                    picker.layout:unhide()
                                end
                            end, 100)
                        end
                    end,
                },
                layout = {
                    cycle = false,
                },
            },
            explorer = {},
            words = {},
        },
        keys = {
            { "<space>nn", "<CMD>lua Snacks.notifier.show_history()<CR>", desc = "Show notifications" },
            { "<space>nd", "<CMD>lua Snacks.notifier.hide()<CR>", desc = "Hide notification" },
            { "<c-w>z", "<CMD>lua Snacks.zen.zoom()<CR>", desc = "Toggle zoom" },
            { "<space>uz", "<CMD>lua Snacks.zen()<CR>", desc = "Toggle zen mode" },
            {
                "<space>f",
                function()
                    Snacks.picker.files({
                        win = {
                            input = {
                                keys = {
                                    ["<S-CR>"] = { "edit_vsplit", mode = { "n", "i" } },
                                },
                            },
                        },
                    })
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
                    Snacks.picker.buffers({
                        unloaded = false,
                        current = false,
                        win = {
                            input = {
                                keys = {
                                    ["<S-CR>"] = { "edit_vsplit", mode = { "n", "i" } },
                                },
                            },
                        },
                    })
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
                "<space>j",
                function()
                    Snacks.picker.jumps()
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
            {
                "<C-n>",
                function()
                    Snacks.explorer()
                end,
                desc = "Explorer",
            },
            {
                "<space>i",
                function()
                    Snacks.lazygit()
                end,
                desc = "Neogit",
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
                    lsp_doc_border = true,
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
}
