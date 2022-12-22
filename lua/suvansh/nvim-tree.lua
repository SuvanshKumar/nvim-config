local is_status_ok, nvim_tree = pcall(require, 'nvim-tree')

if not is_status_ok then
    return
end

nvim_tree.setup {
}

