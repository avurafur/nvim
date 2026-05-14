plugin_init = require "plugin_init"
vim_opt = require "vim_opt"

xpcall(->
    plugin_init.setup!
    vim_opt.setup!

    vim.api.nvim_create_augroup('MyColorSchemeGroup', { clear: true })

    vim.api.nvim_create_autocmd('ColorScheme', {
      group:  'MyColorSchemeGroup',
      pattern:  '*',
      callback: -> vim.cmd('highlight EndOfBuffer ctermbg=NONE guibg=NONE')
    })

    vim.cmd.colorscheme "base16-black-metal-dark-funeral"

    vim.cmd("autocmd BufLeave,BufWinLeave * silent! mkview")
    vim.cmd("autocmd BufReadPost * silent! loadview")
    vim.cmd("source " .. vim.fn.stdpath("config") .. "/auto-pair.vim")
print)
