local success, telescope = pcall(require, "telescope")

if not success then return print "telescope is not installed" end

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            ".git/*",
            "node_modules/*",
            "target/*",
            "bin/*",
            "build/*",
            "cache",
            "CMakeFiles",
            "dll",
            "exe",
        },
    }
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<Space>ff', builtin.find_files, { desc = 'Find files', silent = true })
vim.keymap.set('n', '<Space>fg', builtin.live_grep, { desc = 'Find with grep', silent = true })
