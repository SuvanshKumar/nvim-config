-- vim.cmd "colorscheme default"    -- Normally, this would have been an
                                    -- unprotected way of setting the
                                    -- colorscheme

local selected_colorscheme = "darkplus"

local is_status_ok, _ = pcall(vim.cmd, "colorscheme " .. selected_colorscheme)

if not is_status_ok then
    vim.notify("colorscheme " .. selected_colorscheme .. " not found")
    return
end

