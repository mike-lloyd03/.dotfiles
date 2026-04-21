return {
    -- {
    --     "yetone/avante.nvim",
    --     build = "make",
    --     event = "VeryLazy",
    --     version = false,
    --     opts = {
    --         instructions_file = "avante.md",
    --         provider = "openwebui",
    --         providers = {
    --             -- litellm = {
    --             --     __inherited_from = "openai",
    --             --     endpoint = "https://lllm.presidio.blue/v1",
    --             --     model = "Qwen3-Coder-Next-4bit",
    --             --     api_key_name = "LLLM_KEY",
    --             --     -- timeout = 30000,
    --             --     -- extra_request_body = {
    --             --     --     temperature = 0.75,
    --             --     --     max_tokens = 20480,
    --             --     -- },
    --             -- },
    --             openwebui = {
    --                 __inherited_from = "openai",
    --                 endpoint = "https://llm.presidio.blue/api/v1",
    --                 model = "qwen3-coder-next",
    --                 api_key_name = "OPENWEBUI_KEY",
    --                 -- timeout = 30000,
    --                 -- extra_request_body = {
    --                 --     temperature = 0.75,
    --                 --     max_tokens = 20480,
    --                 -- },
    --             },
    --         },
    --         input = {
    --             provider = "snacks",
    --             provider_opts = {
    --                 title = "Avante Input",
    --                 icon = " ",
    --             },
    --         },
    --     },
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "MunifTanjim/nui.nvim",
    --         "folke/snacks.nvim", -- for input provider snacks
    --         "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    --         {
    --             -- support for image pasting
    --             "HakonHarnes/img-clip.nvim",
    --             event = "VeryLazy",
    --             opts = {
    --                 default = {
    --                     embed_image_as_base64 = false,
    --                     prompt_for_file_name = false,
    --                     drag_and_drop = {
    --                         insert_mode = true,
    --                     },
    --                 },
    --             },
    --         },
    --         {
    --             "MeanderingProgrammer/render-markdown.nvim",
    --             opts = {
    --                 file_types = { "markdown", "Avante" },
    --             },
    --             ft = { "markdown", "Avante" },
    --         },
    --     },
    -- },
    -- {
    --     "sudo-tee/opencode.nvim",
    --     -- config = function()
    --     --     require("opencode").setup({
    --     --         keymap_prefix = "<space>v",
    --     --         default_mode = "plan",
    --     --     })
    --     -- end,
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         {
    --             "MeanderingProgrammer/render-markdown.nvim",
    --             opts = {
    --                 anti_conceal = { enabled = false },
    --                 file_types = { "markdown", "opencode_output" },
    --             },
    --             ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    --         },
    --         "saghen/blink.cmp",
    --         "folke/snacks.nvim",
    --     },
    --     opts = {
    --         ui = {
    --             enable_treesitter_markdown = true,
    --         },
    --         keymap_prefix = "<space>v",
    --         -- default_mode = "plan",
    --     },
    -- },
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        keys = {
            { "<space>v", nil, desc = "AI/Claude Code" },
            { "<space>vg", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            { "<space>vi", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            { "<space>vr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<space>vC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<space>vm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            -- { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
            -- { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
            -- {
            --   "<leader>as",
            --   "<cmd>ClaudeCodeTreeAdd<cr>",
            --   desc = "Add file",
            --   ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
            -- },
            -- Diff management
            -- { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            -- { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    },
}
