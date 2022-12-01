local wk = require("which-key")

-- Allow to override the LSP -> indent normal routine.. 
-- We could use treesitter -> indent if we really wanted to
local ftMap = {
    --vim = 'indent',
    --python = {'indent'},
    --git = ''
    asm = 'treesitter',
}

-- From the README to add a arrow with number of lines folded to the line
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

require('ufo').setup({
    fold_virt_text_handler = handler,
    provider_selector = function(bufnr, filetype, buftype)
        -- return a string type use internal providers
        -- return a string in a table like a string type
        -- return empty string '' will disable any providers
        -- return `nil` will use default value {'lsp', 'indent'}

        -- if you prefer treesitter provider rather than lsp,
        -- return ftMap[filetype] or {'treesitter', 'indent'}
        return ftMap[filetype]
    end
})

-- We have to override the normal bindings with UFOs because these don't override the foldlevel like the
-- normal ones do
wk.register({
    z = {
        R = {'<cmd>lua ufo.openAllFolds()'},
        M = {'<cmd>lua ufo.closeAllFolds()'},
        r = {'<cmd>lua ufo.openFoldsExceptKinds()'},
        m = {'<cmd>lua ufo.closeFoldsWith()'}, -- closeAllFolds == closeFoldsWith(0)
        h = {function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    -- nvimlsp
                    vim.lsp.buf.hover()
                end
            end, "See folded lines"}
    },
})
