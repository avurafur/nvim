local M = {}

function M.setup()
    require "plugins"
    require "config.nvim_tree"
    require "config.telescope"
    require "config.treesitter"
    require "config.lsp"
end

return M
