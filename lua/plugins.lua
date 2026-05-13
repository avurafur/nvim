local plugins_to_be_installed = {
    require("plugins.telescope_plugins"),
    require("plugins.treesitter_plugins"),
    require("plugins.file_management_plugins"),
    require("plugins.lsp_plugins"),
    "RRethy/base16-nvim"
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins_to_be_installed, {})
