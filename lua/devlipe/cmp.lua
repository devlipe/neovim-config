local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local tabnine_status_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not tabnine_status_ok then
    return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- TabNine Configuration to work with CMP
tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
    ignored_file_types = { -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
    },
    show_prediction_strength = true
})

-- -- GitHub copilot to work with CMP
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true
-- vim.g.copilot_tab_fallback = ""

-- --   פּ ﯟ   some other good icons
-- local kind_icons = {
--     Text = "",
--     Method = "m",
--     Function = "",
--     Constructor = "",
--     Field = "",
--     Variable = "",
--     Class = "",
--     Interface = "",
--     Module = "",
--     Property = "",
--     Unit = "",
--     Value = "",
--     Enum = "",
--     Keyword = "",
--     Snippet = "",
--     Color = "",
--     File = "",
--     Reference = "",
--     Folder = "",
--     EnumMember = "",
--     Constant = "",
--     Struct = "",
--     Event = "",
--     Operator = "",
--     TypeParameter = ""
-- }
-- find more here: https://www.nerdfonts.com/cheat-sheet

local source_mapping = {
    nvim_lsp = "[LSP]",
    buffer = "[Buffer]",
    -- nvim_lua = "[Lua]",
    path = "[Path]",
    luasnip = "[Snippet]",
    --[[ cmp_tabnine = "[TN]", ]]

}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        -- ["<Tab>"] = cmp.mapping.confirm {
        --     select = true
        -- },
        ["<CR>"] = cmp.mapping.confirm {
            select = true
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            -- local copilot_keys = vim.fn['copilot#Accept']()
            if cmp.visible() then
                cmp.confirm({
                    select = true
                })
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
                -- elseif copilot_keys ~= '' and type(copilot_keys) == 'string' then
                --     vim.api.nvim_feedkeys(copilot_keys, 'i', true)
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s" })
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, {"i", "s"})
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            --[[ if entry.source.name == 'cmp_tabnine' then ]]
            --[[     if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then ]]
            --[[         menu = entry.completion_item.data.detail .. ' ' .. menu ]]
            --[[     end ]]
            --[[     vim_item.kind = '' ]]
            --[[ end ]]
            vim_item.menu = menu
            return vim_item
        end
    },
    sources = {
        {
            name = "nvim_lsp"
        }, {
            name = "luasnip"
        },
        --[[ { ]]
        --[[     name = 'cmp_tabnine' ]]
        --[[ }, ]]
        {
            name = "buffer"
        }, {
            name = "path"
        }
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false
    },
    window = {
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
        }
    },
    experimental = {
        ghost_text = false,
        native_menu = false
    }
}
