require("nvim-tree").setup {
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },

    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
}

vim.keymap.set('n', '<Space>da', ":NvimTreeToggle<cr>", { silent = true, desc = 'Directory view toggle' })
vim.keymap.set('n', '<Space>df', ":NvimTreeFocus<cr>", { silent = true, desc = 'Directory view focus' })
