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
                "tabdo Neotree close",
            }
        end,
    },

    "tpope/vim-fugitive",
    "preservim/vim-lexical",
    "dhruvasagar/vim-zoom",
    "junegunn/goyo.vim",
    {
        "stevearc/conform.nvim",
        opts = {
            default_format_opts = {
                timeout_ms = 3000,
                lsp_format = "fallback",
                async = false,
                quiet = false,
            },
            format_on_save = {
                lsp_format = "fallback",
            },
            formatters = {
                stylua = {
                    prepend_args = { "--indent-type", "spaces" },
                },
                gofumpt = {
                    env = {
                        GOFUMPT_SPLIT_LONG_LINES = "on",
                    },
                },
            },
            formatters_by_ft = {
                arduino = { "clang-format" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                css = { "prettierd", "prettier", stop_after_first = true },
                dart = { "dartformat" },
                go = { "gofumpt" },
                html = { "prettierd", "prettier", stop_after_first = true },
                json = { "prettierd", "prettier", stop_after_first = true },
                lua = { "stylua" },
                markdown = { "prettierd", "prettier", stop_after_first = true },
                nix = { "nixfmt" },
                python = { "isort", "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
                sh = { "shfmt" },
                svelte = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                toml = { "taplo" },
                yaml = { "prettierd", "prettier", stop_after_first = true },
                --                 yaml = function()
                --                     local util = require("formatter.util")
                --
                --                     return {
                --                         exe = "prettierd", "prettier", stop_after_first = true,
                --                         args = {
                --                             "--stdin-filepath",
                --                             util.escape_path(util.get_current_buffer_file_path()),
                --                             "--no-bracket-spacing",
                --                         },
                --                         stdin = true,
                --                         try_node_modules = true,
                --                     }
                --                 end,
                zsh = { "shfmt" },
            },
        },
        init = function()
            vim.api.nvim_create_user_command("Format", function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                    range = {
                        start = { args.line1, 0 },
                        ["end"] = { args.line2, end_line:len() },
                    }
                end
                require("conform").format({ async = true, lsp_format = "fallback", range = range })
            end, { range = true })
        end,
        -- keys = {
        --     {
        --         "<space>cF",
        --         function()
        --             require("conform").format({ timeout_ms = 3000 })
        --         end,
        --         mode = { "n", "v" },
        --         desc = "Format Buffer",
        --     },
        -- },
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
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
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
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
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            label = { uppercase = false },
            modes = {
                search = { enabled = true },
                char = { enabled = false },
            },
        },
        -- stylua: ignore
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
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
        "echasnovski/mini.animate",
        event = "VeryLazy",
        version = "*",
        opts = {
            scroll = {
                enable = true,
            },
            cursor = {
                enable = false,
            },
            resize = {
                enable = false,
            },
            open = {
                enable = false,
            },
            close = {
                enable = false,
            },
        },
        keys = {
            { "<c-k>", mode = { "n", "x", "o" }, "10<c-y>", desc = "Scroll Up" },
            { "<c-j>", mode = { "n", "x", "o" }, "10<c-e>", desc = "Scroll Down" },
        },
    },
    -- {
    --     "karb94/neoscroll.nvim",
    --     opts = function()
    --         local t = {}
    --         t["<C-k>"] = { "scroll", { "-5", "false", "250" } }
    --         t["<C-j>"] = { "scroll", { "5", "false", "250" } }
    --         require("neoscroll.config").set_mappings(t)
    --
    --         return {
    --             easing_function = "cubic",
    --             mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    --             cursor_scrolls_alone = false,
    --         }
    --     end,
    -- },
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
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
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
