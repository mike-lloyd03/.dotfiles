return {
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
                    arduino = require("formatter.filetypes.c").clangformat,
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
                    yaml = function()
                        local util = require("formatter.util")

                        return {
                            exe = "prettier",
                            args = {
                                "--stdin-filepath",
                                util.escape_path(util.get_current_buffer_file_path()),
                                "--no-bracket-spacing",
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
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
        lazy = true,
        opts = {
            enable_autocmd = true,
        },
    },
    {
        "numToStr/Comment.nvim",
        config = true,
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
    -- {
    --     "echasnovski/mini.clue",
    --     version = false,
    -- },
    -- {
    --     "edluffy/specs.nvim",
    --     opts = {
    --         show_jumps = true,
    --         popup = {
    --             inc_ms = 20,
    --             blend = 10,
    --             winhl = "TermCursor",
    --         },
    --     },
    -- },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = true,
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },
}
