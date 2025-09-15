local is_dap_status_ok, dap = pcall(require, 'dap')

if not is_dap_status_ok then
    print('dap could not be imported')
    vim.notify('dap not imported')
    return
end

local is_dap_vscode_js_status_ok, dap_vscode_js = pcall(require, 'dap-vscode-js')

if not is_dap_vscode_js_status_ok then
    print('dap_vscode_js could not be imported')
    vim.notify('dap_vscode_js not imported')
    return
end

dap_vscode_js.setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
    debugger_path = vim.fn.stdpath('data') .. '/lsp_debuggers/vscode-js-debug3',
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
    -- adapters = { 'pwa-node' }, -- which adapters to register in nvim-dap
    -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
    -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
    -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
        -- see below
        -- {
        --     type = language,
        --     name = 'Launch',
        --     request = 'launch',
        --     program = '${file}',
        --     cwd = vim.fn.getcwd(),
        --     sourceMaps = true,
        --     protocol = 'inspector',
        --     console = 'integratedTerminal',
        -- },
        -- {
        --     type = language,
        --     name = 'Attach to process',
        --     request = 'attach',
        --     processId = require('dap.utils').pick_process,
        -- },
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
        },
    }
end

-- Sign definitions (can add more for conditional breakpoints, etc.)
-- eg. 
--  - Conditional breakpoint
--  - Breakpoint data
--  - Breakpoint log
--  - Breakpoint unsupported
-- Need to find the sign names for those (like 'DapBreakpoint' and 'DapStopped' below)
-- Found the signs on the help page. There are five signs:
-- SIGNS CONFIGURATION
-- nvim-dap uses five signs:
-- - `DapBreakpoint` for breakpoints (default: `B`)
-- - `DapBreakpointCondition` for conditional breakpoints (default: `C`)
-- - `DapLogPoint` for log points (default: `L`)
-- - `DapStopped` to indicate where the debugee is stopped (default: `→`)
-- - `DapBreakpointRejected` to indicate breakpoints rejected by the debug
--   adapter (default: `R`)
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticSignWarn', linehl = 'visual', numhl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })

-- Nvim DAP Virtual Text setup

local is_dap_virtual_text_status_ok, dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')

if not is_dap_virtual_text_status_ok then
    print('dap_virtual_text could not be imported')
    vim.notify('dap_virtual_text not imported')
    return
end

dap_virtual_text.setup({
    enabled = true,                         -- enable this plugin (the default)
    enabled_commands = true,                -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,     -- highlight changed variables with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,       -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,                -- show stop reason when stopped for exceptions
    commented = false,                      -- prefix virtual text with comment string
    only_first_definition = true,           -- only show virtual text at first definition (if there are multiple)
    all_references = false,                 -- show virtual text on all all references of the variable (not only definitions)
    clear_on_continue = false,              -- clear virtual text on "continue" (might cause flickering when stepping)
    --- A callback that determines how a variable is displayed or whether it should be omitted
    --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
    --- @param buf number
    --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
    --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
    --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
    --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
    display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value
        else
            return variable.name .. ' = ' .. variable.value
        end
    end,
    -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
    -- In line virtual text support is only added in the neovim version 0.10
    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

    -- experimental features:
    all_frames = false,                     -- show virtual text for all stack frames not only current. Only works for debugpy on the plugin author's machine.
    virt_lines = false,                     -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                 -- position the virtual text at a fixed window column (starting from the first text column) ,
                                            -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

