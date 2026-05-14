lspconfig = vim.lsp.config
lsp = vim.lsp

if lspconfig == nil
  return print("vim.lsp.config is nil")

capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.signatureHelp =
    dynamicRegistration: true,
    signatureInformation: {
      documentationFormat: { "markdown", "plaintext" },
      parameterInformation: { labelOffsetSupport: true }
    }

lsp_servers = {
    { "lua_ls",  "lua-language-server" },
    {
        "rust_analyzer",
        "rust-analyzer",
        opts:
          settings: {
              ['rust-analyzer']: {}
          },
          capabilities: capabilities
    },
    { "ts_ls", "tsserver"},
    { "pylsp",format_on_save: true},
    { "zls"},
    { "gopls"},
    { "nimls","nimlangserver"},
}

table.insert(lsp_servers,{
    "clangd",
    opts:
      capabilities: capabilities,
      cmd: {
          "clangd"
          "--background-index"
          "--suggest-missing-includes"
      },
      filetypes: { "c", "cpp", "objc", "objcpp" }
})

default_opts = 
    capabilities: capabilities,
    on_exit: (code, signal, client_id) ->

for _, server in ipairs(lsp_servers)
    if type(server) == "table"
      if vim.fn.executable(server[2] or server[1]) == 1
          lsp.config(server[1],server.opts or default_opts)
          lsp.enable(server[1])

vim.diagnostic.config({
  virtual_text: true
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback: (args) ->
        client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client 
          return 
})

vim.keymap.set('n', '<Space>gr', ":lua vim.lsp.buf.references()<cr>", 
  { silent: true, desc: 'Find Symbol references' })

vim.keymap.set('n', '<Space>gs', ":lua vim.lsp.buf.workspace_symbol()<cr>",
    { silent: true, desc: 'Find Symbol workspace' })

vim.keymap.set('n', '<Space>a', ":lua vim.lsp.buf.code_action()<cr>", {
  silent: true,
  desc: 'Refactor code action',
})

vim.keymap.set('n', '<Space>r', ":lua vim.lsp.buf.rename()<cr>", {
  silent: true,
  desc: 'Refactor rename',
})

require "config.cmp"
