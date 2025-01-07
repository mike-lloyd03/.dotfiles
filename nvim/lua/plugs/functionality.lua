return {
    {
        "olimorris/persisted.nvim",
        lazy = false,
        opts = {
            save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/persisted/"),
            ignored_dirs = { { "~", exact = true }, "/tmp/", { "/", exact = true } },
        },
        config = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "PersistedSavePre",
                callback = function()
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.bo[buf].filetype == "neo-tree" then
                            vim.api.nvim_buf_delete(buf, { force = true })
                        end
                    end
                end,
            })
        end,
    },
    "tpope/vim-fugitive",
    "preservim/vim-lexical",
    "junegunn/goyo.vim",
    {
        -- Formatter
        "stevearc/conform.nvim",
        event = "VeryLazy",
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
                typst = { "typstfmt" },
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
        keys = {
            {
                "<C-f>",
                "<cmd>Format<cr>",
                desc = "Format Buffer",
            },
        },
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
        cmd = "Trouble",
        keys = {
            { "<space>t", "<cmd><cr>", desc = "Trouble" },
            { "<space>tw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace" },
            { "<space>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document" },
            { "<space>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
            { "<space>tl", "<cmd>Trouble loclist<cr>", desc = "Loclist" },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            label = { uppercase = false },
            modes = {
                search = { enabled = false },
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
        opts = {
            highlight = true,
        },
    },
    "tpope/vim-abolish",
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
        keys = {
            {
                "]t",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "Next todo comment",
            },
            {
                "[t",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "Previous todo comment",
            },
            {
                "<space>xt",
                "<CMD>TodoFzfLua<CR>",
                desc = "Todo list",
            },
        },
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },
    {
        "MagicDuck/grug-far.nvim",
        opts = { headerMaxWidth = 80 },
        cmd = "GrugFar",
        keys = {
            {
                "<space>S",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
    },
}
