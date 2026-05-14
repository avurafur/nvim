success,config = pcall(require, "nvim-treesitter")

if not success 
  return print "something is wrong with treesitter.configs"

config.setup {
  build: ":TSUpdate",
  ensure_installed: {
      "c",
      "go",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "rust",
      "javascript",
  },
  sync_install: false,
  auto_install: true,
  ignore_install: { "javascript" },

  indent: { enable: true },

  highlight: {
    enable: true,
      disabled_t: { "c", "rust" },
      disable: (lang, buf) ->
          if vim.api.nvim_buf_get_option(0, "filetype") ~= "TelescopePrompt"
              if lang == "cpp" 
                  pcall(vim.cmd.TSDisable, "rainbow")
              else
                  pcall(vim.cmd.TSEnable, "rainbow")

          max_filesize = 100 * 1024 -- 100 KB
          ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

          if ok and stats and stats.size > max_filesize 
              return true

      additional_vim_regex_highlighting: false
  }
}
