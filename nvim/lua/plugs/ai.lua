return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        opts = {
            provider = "openai",
            openai = {
                endpoint = "http://192.168.0.180:11434/v1",
                model = "deepseek-coder-v2",
                temperature = 0,
                -- max_tokens = 4096,
                ["local"] = true,
            },
            mappings = {
                ask = "<space>sa",
                edit = "<space>se",
                refresh = "<space>sr",
                submit = {
                    normal = "<CR>",
                    insert = "<S-CR>",
                },
            },
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
}
