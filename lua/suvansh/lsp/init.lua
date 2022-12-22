local is_status_ok, _ = pcall(require, 'lspconfig')

if not is_status_ok then
    return
end

require('suvansh.lsp.lsp-installer')
require('suvansh.lsp.handlers').setup()

