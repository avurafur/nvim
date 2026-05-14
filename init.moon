plugin_init = require "plugin_init"
vim_opt = require "vim_opt"

package.path ..= ";" .. vim.fn.stdpath("config") .. "/vendor/lyaml/?.lua"

config_loader = require "config_loader"

config_loader.load("/config.yml")
config = config_loader.get("/config.yml") or {}

xpcall(->
    plugin_init.setup!
    vim_opt.setup!

    vim.api.nvim_create_augroup('MyColorSchemeGroup', { clear: true })

    vim.api.nvim_create_autocmd('ColorScheme', {
      group:  'MyColorSchemeGroup',
      pattern:  '*',
      callback: -> vim.cmd('highlight EndOfBuffer ctermbg=NONE guibg=NONE')
    })

    vim.cmd.colorscheme(config.theme or "base16-black-metal-dark-funeral")

    vim.cmd"autocmd BufLeave,BufWinLeave * silent! mkview"
    vim.cmd"autocmd BufReadPost * silent! loadview"

    vim.keymap.set("n", "gl", "$", { noremap: true, silent: true })
    vim.keymap.set("n", "gh", "0", { noremap: true, silent: true })
    vim.keymap.set("n", "ge", "G", { noremap: true, silent: true })
print)
