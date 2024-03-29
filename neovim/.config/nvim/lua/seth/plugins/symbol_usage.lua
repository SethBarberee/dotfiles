-- hl-groups can have any name
local function text_format(symbol)
    local res = {}

    local round_start = { '', 'SymbolUsageRounding' }
    local round_end = { '', 'SymbolUsageRounding' }

    if symbol.references then
        local usage = symbol.references <= 1 and 'usage' or 'usages'
        local num = symbol.references == 0 and 'no' or symbol.references
        table.insert(res, round_start)
        table.insert(res, { '󰌹 ', 'SymbolUsageRef' })
        table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageContent' })
        table.insert(res, round_end)
    end

    if symbol.definition then
        if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
        end
        table.insert(res, round_start)
        table.insert(res, { '󰳽 ', 'SymbolUsageDef' })
        table.insert(res, { symbol.definition .. ' defs', 'SymbolUsageContent' })
        table.insert(res, round_end)
    end

    if symbol.implementation then
        if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
        end
        table.insert(res, round_start)
        table.insert(res, { '󰡱 ', 'SymbolUsageImpl' })
        table.insert(res, { symbol.implementation .. ' impls', 'SymbolUsageContent' })
        table.insert(res, round_end)
    end

    return res
end

return {
    "Wansmer/symbol-usage.nvim",
    event = 'LspAttach', -- use LspAttach on nvim 0.10
    opts = {
        -- definition = { enabled = true },
        -- implementation = { enabled = true },
        text_format = text_format,
        request_pending_text = false, -- Don't display anything until ready
        vt_position = 'end_of_line'
    }
}
