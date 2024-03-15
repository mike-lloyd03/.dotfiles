-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- LSP
-- Snippets
-- Treesitter
-- Telescope
-- UI
-- Functionality
-- Language Support

require("lazy").setup({
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("theme")
        end,
    },
    -----------------------------------------------
    -- LSP
    -----------------------------------------------
    "neovim/nvim-lspconfig",
    "nvimtools/none-ls.nvim",
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "onsails/lspkind-nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
        },
        config = function()
            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end

            local cmp = require("cmp")
            local lspkind = require("lspkind")
            cmp.setup({
                -- Enable LSP snippets
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<Down>"] = cmp.mapping.select_next_item(),
                    ["<Up>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.scroll_docs(4),
                    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = false,
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if vim.fn["vsnip#jumpable"](1) == 1 then
                            feedkey("<Plug>(vsnip-jump-next)", "")
                        elseif cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function()
                        if vim.fn["vsnip#jumpable"](-1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        elseif cmp.visible() then
                            cmp.select_prev_item()
                        end
                    end, { "i", "s" }),
                },

                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    }),
                },

                -- Installed sources
                sources = {
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
            })
        end,
    },
    ---------------------------------------------
    -- Snippets
    ---------------------------------------------
    {
        "hrsh7th/vim-vsnip",
        config = function()
            vim.g.vsnip_snippet_dir = "~/.config/nvim/vsnip"
        end,
    },
    "golang/vscode-go",
    "rust-lang/vscode-rust",

    -----------------------------------------------
    -- Treesitter
    -----------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            playground = {
                enable = true,
            },
            autotag = {
                enable = true,
            },
            context_commentstring = {
                enable = true,
            },
        },
        dependencies = {
            "nvim-treesitter/playground",
        },
    },

    -----------------------------------------------
    -- Telescope
    -----------------------------------------------
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    prompt_prefix = "❯ ",
                    mappings = {
                        i = {
                            ["<esc>"] = require("telescope.actions").close,
                            ["<C-j>"] = require("telescope.actions").preview_scrolling_down,
                            ["<C-k>"] = require("telescope.actions").preview_scrolling_up,
                        },
                    },
                    layout_config = {
                        cursor = {
                            width = 60,
                            height = 10,
                        },
                        scroll_speed = 1,
                    },
                    file_ignore_patterns = {
                        "package-lock\\.json",
                    },
                },
                pickers = {
                    spell_suggest = {
                        layout_strategy = "cursor",
                        sorting_strategy = "ascending",
                    },
                    buffers = {
                        sort_lastused = true,
                        mappings = {
                            i = {
                                ["<C-b>"] = require("telescope.actions").delete_buffer,
                            },
                        },
                    },
                },
            })

            require("telescope").load_extension("notify")
            require("telescope").load_extension("fzf")
        end,
    },

    -----------------------------------------------
    -- UI
    -----------------------------------------------
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

    -----------------------------------------------
    -- Functionality
    -----------------------------------------------
    {
        "rmagatti/auto-session",
        opts = {
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "/tmp/", "/" },
            auto_session_enabled = true,
            auto_save_enabled = true,
            auto_restore_enabled = false,
        },
        init = function()
            local function close_all_floating_wins()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local config = vim.api.nvim_win_get_config(win)
                    if config.relative ~= "" then
                        vim.api.nvim_win_close(win, false)
                    end
                end
            end

            vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
            vim.g.auto_session_pre_save_cmds = {
                close_all_floating_wins,
                "tabdo NvimTreeClose",
            }
        end,
    },

    "tpope/vim-fugitive",
    "preservim/vim-lexical",
    "dhruvasagar/vim-zoom",
    "junegunn/goyo.vim",
    {
        "mhartington/formatter.nvim",
        lazy = false,
        opts = function()
            return {
                logging = false,
                filetype = {
                    c = require("formatter.filetypes.c").clangformat,
                    cpp = require("formatter.filetypes.cpp").clangformat,
                    css = require("formatter.defaults.prettier"),
                    dart = require("formatter.filetypes.dart").dartformat,
                    go = function()
                        return {
                            exe = "GOFUMPT_SPLIT_LONG_LINES=on gofumpt",
                            stdin = true,
                        }
                    end,
                    html = require("formatter.defaults.prettier"),
                    javascript = require("formatter.defaults.prettier"),
                    json = require("formatter.defaults.prettier"),
                    lua = function()
                        return {
                            exe = "stylua",
                            args = {
                                "--indent-type",
                                "spaces",
                                "-",
                            },
                            stdin = true,
                        }
                    end,
                    markdown = require("formatter.defaults.prettier"),
                    nix = require("formatter.filetypes.nix").nixfmt,
                    python = {
                        require("formatter.filetypes.python").black,
                        require("formatter.filetypes.python").isort,
                    },
                    rust = require("formatter.filetypes.rust").rustfmt,
                    sh = require("formatter.filetypes.sh").shfmt,
                    sql = require("formatter.filetypes.sql"),
                    svelte = require("formatter.defaults.prettier"),
                    typescript = require("formatter.defaults.prettier"),
                    toml = require("formatter.filetypes.toml").taplo,
                    yaml = require("formatter.defaults.prettier"),
                    zsh = require("formatter.filetypes.sh").shfmt,
                },
            }
        end,
    },
    {
        "kylechui/nvim-surround",
        opts = {
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "ms",
                normal_cur = "mss",
                normal_line = "mS",
                normal_cur_line = "mSS",
                visual = "ms",
                visual_line = "mS",
                delete = "md",
                change = "mr",
            },
        },
    },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    {
        "windwp/nvim-ts-autotag",
        config = true,
    },
    {
        "folke/trouble.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        opts = {
            signs = {
                error = "●",
                warning = "●",
                hint = "●",
                information = "●",
                other = "●",
            },
        },
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
            require("leap").opts.special_keys = {
                next_target = { "<tab>" },
                prev_target = { "<S-tab>" },
            }
            -- get highlight groups with :so $VIMRUNTIME/syntax/hitest.vim
            vim.api.nvim_set_hl(0, "LeapLabelPrimary", { link = "debugBreakpoint" })
        end,
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        -- opts = function()
        --     vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        --     return {
        --         highlight = true,
        --     }
        -- end,
    },
    "tpope/vim-abolish",
    {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            window = {
                border = "rounded",
            },
            lsp = {
                auto_attach = true,
            },
        },
    },
    {
        "karb94/neoscroll.nvim",
        opts = function()
            local t = {}
            t["<C-k>"] = { "scroll", { "-5", "false", "250" } }
            t["<C-j>"] = { "scroll", { "5", "false", "250" } }
            require("neoscroll.config").set_mappings(t)

            return {
                easing_function = "cubic",
                mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
                cursor_scrolls_alone = false,
            }
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = {
            "terrortylor/nvim-comment",
        },
        config = function()
            require("nvim_comment").setup({
                comment_empty = false,
                hook = function()
                    if vim.api.nvim_buf_get_option(0, "filetype") == "svelte" then
                        ---@diagnostic disable-next-line: missing-parameter
                        require("ts_context_commentstring.internal").update_commentstring()
                    end
                end,
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            -- Sets up fold column
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require("statuscol.builtin")
                    require("statuscol").setup({
                        relculright = true,
                        segments = {
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                            { text = { "%s" }, click = "v:lua.ScSa" },
                            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                        },
                    })
                    vim.api.nvim_set_hl(0, "FoldColumn", {}) -- Clear the FoldColumn HL group so it's bg is transparent
                end,
            },
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
            local language_servers = require("lspconfig").util.available_servers()
            for _, ls in ipairs(language_servers) do
                require("lspconfig")[ls].setup({
                    capabilities = capabilities,
                })
            end
            require("ufo").setup()
        end,
    },
    {
        "echasnovski/mini.clue",
        version = false,
    },
    {
        "edluffy/specs.nvim",
        opts = {
            show_jumps = true,
            popup = {
                inc_ms = 20,
                blend = 10,
                winhl = "TermCursor",
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = true,
    },

    -----------------------------------------------
    -- Language Support
    -----------------------------------------------
    {
        "chrisbra/csv.vim",
        ft = "csv",
    },
    {
        "simrat39/rust-tools.nvim",
        -- ft = {
        --     "rust",
        --     "toml",
        -- },
        opts = {

            tools = {
                inlay_hints = {
                    only_current_line = true,
                    show_parameter_hints = false,
                    -- highlight = "VertSplit",
                    -- highlight = "lualine_a_mode_inactive",
                    highlight = "DevIconDoc",
                },
            },
            server = {
                on_attach = function(client, bufnr)
                    -- Hover actions
                    vim.keymap.set(
                        "n",
                        "<C-space>",
                        require("rust-tools").hover_actions.hover_actions,
                        { buffer = bufnr }
                    )
                    -- Code action groups
                    vim.keymap.set(
                        "n",
                        "<Leader>a",
                        require("rust-tools").code_action_group.code_action_group,
                        { buffer = bufnr }
                    )
                    require("nvim-navic").attach(client, bufnr)
                end,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                        inlayHints = { locationLinks = false },
                    },
                },
            },
        },
    },
    {
        "ron-rs/ron.vim",
        ft = "ron",
    },
    {
        "leafOfTree/vim-svelte-plugin",
        ft = "svelte",
    },
    {
        "LhKipp/nvim-nu",
        ft = "nu",
    },
    {
        "akinsho/flutter-tools.nvim",
        ft = "dart",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "dart-lang/dart-vim-plugin",
        },
        opts = {
            ui = {
                notification_style = "native",
            },
            lsp = {
                on_attach = function(client, bufnr)
                    require("nvim-navic").attach(client, bufnr)
                end,
            },
        },
    },
    {
        "NoahTheDuke/vim-just",
        ft = "just",
    },
    { "ellisonleao/glow.nvim", opts = {
        width = 120,
        border = "rounded",
    }, cmd = "Glow" },
    "Glench/Vim-Jinja2-Syntax",
    "folke/neodev.nvim",
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
    },
})
