local is_status_ok, colorizer = pcall(require, 'colorizer')

if not is_status_ok then
    return
end

colorizer.setup()

