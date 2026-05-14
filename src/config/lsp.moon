lspconfig = vim.lsp.config
lsp = vim.lsp

config_loader = require "config_loader"

config_loader.load("/lsp.yml")
config = config_loader.get("/lsp.yml") or {}

lsp_servers = {}

for server_name,server_data in pairs(config.servers or {}) do
    lsp_servers[server_name] = server_data

if lspconfig == nil
  return print("vim.lsp.config is nil")

capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.signatureHelp =
    dynamicRegistration: true,
    signatureInformation:
      documentationFormat: { "markdown", "plaintext" },
      parameterInformation: { labelOffsetSupport: true }

default_opts =
    capabilities: capabilities,
    on_exit: (code, signal, client_id) ->

for lsp_name,data in pairs(lsp_servers)
    if type(data) == "table"
      if vim.fn.executable(data.exec or lsp_name) == 1
          lsp.config(lsp_name,data.options or default_opts)
          lsp.enable(lsp_name)

vim.diagnostic.config({
  virtual_text: true
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback: (args) ->
        client = lsp.get_client_by_id(args.data.client_id)

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
