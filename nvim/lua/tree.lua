local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
    vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
    vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    -- vim.keymap.set("n", "c", api.tree.change_root_to_node, opts("CD"))
end

require("nvim-tree").setup({
    on_attach = on_attach,
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    respect_buf_cwd = false,
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
    filters = {
        dotfiles = false,
        custom = { "\\.git$", "__pycache__", "\\.venv", "\\.pytest_cache", "node_modules", ".svelte-kit" },
        git_ignored = false,
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 200,
    },
    view = {
        width = 35,
        side = "left",
        number = false,
        relativenumber = false,
        signcolumn = "no",
    },
    renderer = {
        group_empty = false,
        highlight_opened_files = "name",
        root_folder_label = true,
        icons = {
            git_placement = "after",
            padding = " ",
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "!",
                    staged = "+",
                    unmerged = "",
                    renamed = "»",
                    untracked = "?",
                    deleted = "✘",
                    ignored = "",
                },
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
        indent_markers = {
            enable = true,
        },
    },
})
