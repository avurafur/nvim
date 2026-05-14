success, telescope = pcall(require, "telescope")

if not success 
  return print "telescope is not installed"

telescope.setup({
  defaults: {
    file_ignore_patterns: {
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

builtin = require('telescope.builtin')

vim.keymap.set('n', '<Space>f', builtin.find_files, { desc: 'Find files', silent: true })
vim.keymap.set('n', '<Space>F', builtin.live_grep, { desc: 'Find with grep', silent: true })
