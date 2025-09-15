local is_status_ok, telescope = pcall(require, 'telescope')

if not is_status_ok then
    return
end

local actions = require('telescope.actions')

telescope.setup {
    defaults = {
	file_ignore_patterns = { "node_modules" },
        -- Nice ricing from LunarVim
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },

        -- My own mappings

        -- sorting_strategy = "ascending",
        -- layout_strategy = "vertical",
        -- multi_icon = " ", -- or "﫟", "﫠", ,, ,, ,, ,, ﬽,, 
        multi_icon = " ",
        -- dynamic_preview_title = true,
        -- TODO - add mapping of select all and drop all? like:
        --      ["<C-a>"] = actions.select_all
        --      ["<C-S-a>"] = actions.drop_all -- ctrl + shift doesn't work in
        -- vim, so need to find a different key combination to map
        -- maybe actions.toggle_all
        -- may be it won't work because it maybe selects everything, even the
        -- files not in preview. Need to confirm this
        -- TODO - add mapping to close buffers (in multi-selected mode?) -
        -- actions.delete_buffer

        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- Default mappings
                -- ["<C-n>"] = actions.cycle_history_next,
                -- ["<C-p>"] = actions.cycle_history_prev,

                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                -- ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>

                -- My mappings
                
            },

            n = {
                -- My mappings
                ["<Space>"] = actions.toggle_selection
            },
        },
    },
    -- pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    -- },
    extensions = {
        -- media_files = {
        --     -- filetypes whitelist
        --     -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        --     filetypes = {"png", "webp", "jpg", "jpeg"},
        --     find_cmd = "rg" -- find command (defaults to `fd`)
        -- }
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    },
}

