yaml = require "yaml"

M = {}
configs = {}

M.load = (f) ->
    ok,config_file = pcall(io.open,vim.fn.stdpath("config") .. f,"r")

    if ok and config_file
      content = config_file\read"*all"
      if #content != 0
        configs[f] = yaml.eval content
      config_file\close!
      return "ok"
    else
      return "err"

M.get = (f) -> configs[f]

M
