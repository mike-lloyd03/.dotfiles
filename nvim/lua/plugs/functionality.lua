return {
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
        init = function()
            vim.opt.sessionoptions =
                { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
        end,
    },
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

            -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,

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
                css = { "biome" },
                dart = { "dartformat" },
                go = { "gofumpt" },
                html = { "prettierd", "prettier", stop_after_first = true },
                json = { "biome" },
                lua = { "stylua" },
                markdown = { "prettierd", "prettier", stop_after_first = true },
                nix = { "nixfmt" },
                python = { "ruff_format", "ruff_organize_imports" },
                rust = { "rust_analyzer", lsp_format = "prefer" },
                sh = { "shfmt" },
                svelte = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "biome" },
                toml = { "taplo" },
                typst = { "typstfmt" },
                vue = { "prettierd", "prettier", stop_after_first = true },
                yaml = { "prettierd", "prettier", stop_after_first = true },
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

            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    -- FormatDisable! will disable formatting just for this buffer
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            })

            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {
                desc = "Re-enable autoformat-on-save",
            })

            vim.api.nvim_create_user_command("FormatToggle", function()
                vim.b.disable_autoformat = not vim.b.disable_autoformat
                vim.g.disable_autoformat = not vim.g.disable_autoformat
            end, {
                desc = "Toggle autoformat-on-save",
            })
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
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { "string" },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
    },
    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
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
          -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
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
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
            enable_autocmd = true,
        },
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
        },
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
        event = "VeryLazy",
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
                "<space>td",
                function()
                    Snacks.picker.todo_comments()
                end,
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
    -- {
    --     "NeogitOrg/neogit",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "sindrets/diffview.nvim",
    --         "ibhagwan/fzf-lua",
    --     },
    --     config = true,
    --     keys = {
    --         {
    --             "<space>i",
    --             "<CMD>Neogit kind=floating<CR>",
    --             desc = "Neogit",
    --         },
    --     },
    -- },
    {
        "stevearc/profile.nvim",
        config = function()
            local should_profile = os.getenv("NVIM_PROFILE")
            if should_profile then
                require("profile").instrument_autocmds()
                if should_profile:lower():match("^start") then
                    require("profile").start("*")
                else
                    require("profile").instrument("*")
                end
            end

            local function toggle_profile()
                local prof = require("profile")
                if prof.is_recording() then
                    prof.stop()
                    vim.ui.input(
                        { prompt = "Save profile to:", completion = "file", default = "profile.json" },
                        function(filename)
                            if filename then
                                prof.export(filename)
                                vim.notify(string.format("Wrote %s", filename))
                            end
                        end
                    )
                else
                    prof.start("*")
                end
            end
            vim.keymap.set("", "<f1>", toggle_profile)
        end,
    },
    {
        "gregorias/coerce.nvim",
        config = true,
    },
}
