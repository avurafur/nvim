plugins = {
  require"plugins.telescope_plugins"
  require"plugins.treesitter_plugins"
  require"plugins.file_management_plugins"
  require"plugins.lsp_plugins"
  "RRethy/base16-nvim"
  {dir: vim.fn.stdpath("config") .. "/plugins/moonscript"}
  {
    dir: vim.fn.stdpath("config") .. "/plugins/auto-pair"
    name: "auto-pair"
    config: -> vim.cmd("source " .. vim.fn.stdpath("config") .. "/plugins/auto-pair/auto-pair.vim")
  }
}

lazypath = vim.fn.stdpath"data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })

vim.opt.rtp\prepend lazypath

require("lazy").setup(plugins, {})
