local lspconfig = vim.lsp.config
local lsp = vim.lsp

if lspconfig == nil then return print("vim.lsp.config is nil") end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.signatureHelp = {
    dynamicRegistration = true,
    signatureInformation = {
        documentationFormat = { "markdown", "plaintext" },
        parameterInformation = { labelOffsetSupport = true },
    },
}

local lsp_servers = {
    { "lua_ls",  "lua-language-server" },
    {
        "rust_analyzer",
        "rust-analyzer",
        opts = {
            settings = {
                ['rust-analyzer'] = {},
            },
            capabilities = capabilities
        },
    },
    { "ts_ls", "tsserver"},
    { "pylsp",format_on_save = true},
    { "zls"},
    { "gopls"},
    { "nimls","nimlangserver"},
}

table.insert(lsp_servers, {
    "clangd",
    opts = {
        capabilities = capabilities,
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
    }
})

local default_opts = {
    capabilities = capabilities,
    on_exit = function(code, signal, client_id)
    end,
}

local cached_clients = {}

for _, server in ipairs(lsp_servers) do
    if type(server) == "string" then
        if vim.fn.executable(server) == 1 then
            lsp.config(server,default_opts)
            lsp.enable(server)
        end
    elseif type(server) == "table" then
        if vim.fn.executable(server[2] or server[1]) == 1 then
            lsp.config(server[1],server.opts or default_opts)
            lsp.enable(server[1])
        end
    end
end

vim.diagnostic.config({
    virtual_text = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then return end

        if not cached_clients[client.name] then
            cached_clients[client.name] = client
        end

        -- if client.supports_method("textDocument/formatting") then
        --     vim.keymap.set('n', '<Space>rf', ":lua vim.lsp.buf.format()<cr>", { silent = true, desc = 'Refactor format' })
        --
        --     if cached_clients[client.name].format_on_save then
        --         vim.api.nvim_create_autocmd("BufWritePre", {
        --             buffer = args.buf,
        --             callback = function()
        --                 vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        --             end
        --         })
        --     end
        -- end
    end
})

vim.keymap.set('n', '<Space>fsr', ":lua vim.lsp.buf.references()<cr>", { silent = true, desc = 'Find Symbol references' })

vim.keymap.set('n', '<Space>fsw', ":lua vim.lsp.buf.workspace_symbol()<cr>",
    { silent = true, desc = 'Find Symbol workspace' })

vim.keymap.set('n', '<Space>r.', ":lua vim.lsp.buf.code_action()<cr>", {
    silent = true,
    desc = 'Refactor code action',
})

vim.keymap.set('n', '<Space>rr', ":lua vim.lsp.buf.rename()<cr>", {
    silent = true,
    desc = 'Refactor rename',
})

require "config.cmp"
