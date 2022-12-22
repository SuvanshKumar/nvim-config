local is_status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')

if not is_status_ok then
    return
end

-- refer to :help nvim-lsp-installer
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register on specific server instances instead
-- (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require('suvansh.lsp.handlers').on_attach,
        capabilities = require('suvansh.lsp.handlers').capabilities,
    }

    if server.name == 'sumneko_lua' then
        local sumneko_lua_opts = require('suvansh.lsp.settings.sumneko_lua')
        opts = vim.tbl_deep_extend('force', sumneko_lua_opts, opts)
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

