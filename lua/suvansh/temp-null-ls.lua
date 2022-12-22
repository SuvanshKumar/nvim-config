local is_null_ls_status_ok, null_ls = pcall(require, 'null-ls')

if not is_null_ls_status_ok then
    return
end

null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.diagnostics.eslint.with({
            dynamic_command = function ()
                return 'eslint'
            end
        }),
    },
})

