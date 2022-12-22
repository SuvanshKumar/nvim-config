-- Refer to http://github.com/hrsh7th/nvim-cmp
local is_cmp_status_ok, cmp = pcall(require, "cmp")
if not is_cmp_status_ok then
  return
end

local is_snip_status_ok, luasnip = pcall(require, "luasnip")
if not is_snip_status_ok then
  return
end

-- Copying the icons for now
--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body)     -- For vsnip
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        -- ['<C-y>'] = cmp.config.disable, -- specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
    formatting = {
        -- TODO: add icons here?
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            -- kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
            vim_item.menu = ({
                nvim_lsp = '[LSP]',
                luasnip = '[Snippet]',
                buffer = '[Buffer]',
                path = '[Path]',
            })[entry.source.name]
            return vim_item
        end,
    },
    -- TODO: command line completions later?
    confirm_opts = {    -- What are these?
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    -- documentation = {
        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        -- border = cmp.config.window.bordered(),
        -- border = rounded,    -- Will this work? -- No, the border doesn't show up
        -- border = { "+", "-", "+", "|", "+", "-", "+", "|"},
    -- },
    window = {
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true,      -- Experiment - set this to true
        native_menu = false,
    },
})
