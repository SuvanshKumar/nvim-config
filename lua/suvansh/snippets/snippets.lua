local is_luasnip_status_ok, ls = pcall(require, 'luasnip')

if not is_luasnip_status_ok then
    return
end

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require('luasnip.extras.fmt').fmt

ls.setup({
    update_events = 'TextChanged,TextChangedI',
})

ls.add_snippets('all', {
    s('expandthis', t'This is the expanded text'),
}, {key = 'all',
})

ls.add_snippets('javascript', {
    s({ trig = 'funarr', name = 'Arrow Function' }, {
        t('const '),
        i(1, 'functionName'),
        t(' = ('),
        i(2, ''),
        t(') => {'),
        t(''),
        i(0),
        t('};')
}, { key = 'javascript',
})

-- ls.add_snippets('typescript', {
--     s({ trig = 'funarr', name = 'Arrow Function' }, {
--         t('const '),
--         i(1, 'functionName'),
--         t(' = ('),
--         i(2, ''),
--         t({ ') => {', '\t' }),
--         t(''),
--         i(0),
--         t({ '', '};' })
-- }, { key = 'typescript',
-- })

local mySplit = function (inputString, sep)
    if sep == nil then
        sep = '%s'
    end
    local t = {}
    for str in string.gmatch(inputString, '([^'..sep..']+)') do
        table.insert(t, str)
    end
    return t
end

local trimString = function (s)
    if s == nil then
        return ''
    end
    return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

ls.add_snippets('typescript', {
    s({ trig = 'funarr', name = 'Arrow Function' }, fmt(
        [[
/**
* {} {}
*/
const {} = ({}){}{} => {{
    {}
}}
        ]], {
            i(4, 'A short description of the function'),
            f(function (args, parent, user_args)
                local funcArguments = mySplit(args[1][1], ',')
                local returnType = args[2][1]
                -- local funcArguments = {}
                -- table.insert(funcArguments, args[1][1])
                local argDocs = { '' }
                for _, funcArg in ipairs(funcArguments) do
                    local colonSplittedArgs = mySplit(funcArg, ':')
                    -- local argName, argType = table.unpack(colonSplittedArgs)
                    -- argName = trimString(argName)
                    -- argType = trimString(argType)
                    -- local argDocString = ' * {' .. argType .. '} ' .. argName
                    local typeParameter = (colonSplittedArgs[2] and colonSplittedArgs[2] ~= '') and ('{' .. trimString(colonSplittedArgs[2]) .. '} ') or ''
                    local argDocString = '* @param ' .. typeParameter .. trimString(colonSplittedArgs[1])
                    table.insert(argDocs, argDocString)
                end
                if returnType and returnType ~= '' then
                    table.insert(argDocs, '* @returns {' .. returnType .. '}')
                end
                return argDocs
            end, { 2, 3 }, {}),
            i(1, 'functionName'),
            c(2, { t(''), i(1, 'arguments') }),
            f(function (args, parent, user_args)
                local returnType = args[1][1]
                return (returnType and returnType ~= '') and ': ' or ''
            end, { 3 }, {}),
            c(3, { i(1, 'any'), t('') }),
            i(0)
        }
    ))
}, { key = 'typescript'
})

ls.add_snippets('lua', {
    s({ trig = 'pcall', name = 'Protected Call' }, fmt([[
local {}, {} = pcall(require, '{}')
if not {} then
    return
end
{}
        ]], {
            f(function (args, parent, user_args)
                local moduleName = args[1][1]
                if not moduleName or moduleName == '' then
                    return ''
                end
                return 'is_' .. moduleName .. 'status_ok'
            end, { 1 }, {}),
            f(function (args, parent, user_args)
                local moduleName = args[1][1]
                if not moduleName or moduleName == '' then
                    return ''
                end
                return moduleName
            end, { 1 }, {}),
            i(1, 'module_name'),
            f(function (args, parent, user_args)
                local moduleName = args[1][1]
                if not moduleName or moduleName == '' then
                    return ''
                end
                return 'is_' .. moduleName .. 'status_ok'
            end, { 1 }, {}),
            i(0),
        }
    )),
}, { key = 'lua'
})

