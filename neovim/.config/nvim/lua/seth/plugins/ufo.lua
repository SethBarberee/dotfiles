local sethconfig = require("seth.config")

return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async',
    },
    enabled = sethconfig.ufo,
    event = "VeryLazy",
    keys = {
        { 'zR', function() require('ufo').openAllFolds() end },
        { 'zM', function() require('ufo').closeAllFolds() end },
        { 'zr', function() require('ufo').openFoldsExceptKinds() end },
        { 'zm', function() require('ufo').closeFoldsWith() end },
        {
            'zh',
            function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    -- nvimlsp
                    vim.lsp.buf.hover()
                end
            end,
            desc = 'Peek folded lines'
        },
    },
    opts = function()
        -- Allow to override the LSP -> treesitter -> indent normal routine..
        local ftMap = {
            --vim = 'indent',
            --python = {'indent'},
            --git = ''
            --asm = 'treesitter',
        }

        -- lsp -> treesitter -> indent
        local function customizeSelector(bufnr)
            local function handleFallbackException(err, providerName)
                if type(err) == 'string' and err:match('UfoFallbackException') then
                    return require('ufo').getFolds(providerName, bufnr)
                else
                    return require('promise').reject(err)
                end
            end

            return require('ufo').getFolds(bufnr, 'lsp'):catch(function(err)
                return handleFallbackException(err, 'treesitter')
            end):catch(function(err)
                return handleFallbackException(err, 'indent')
            end)
        end

        -- From the README to add a arrow with number of lines folded to the line
        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' ↙ %d'):format(endLnum - lnum)
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
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, 'PreProc' }) -- set the highlighting of the folded line count
            return newVirtText
        end

        return {
            fold_virt_text_handler = handler,
            provider_selector = function(bufnr, filetype, buftype)
                -- return a string type use internal providers
                -- return a string in a table like a string type
                -- return empty string '' will disable any providers
                -- return `nil` will use default value {'lsp', 'indent'}

                -- if you prefer treesitter provider rather than lsp,
                -- return ftMap[filetype] or {'treesitter', 'indent'}
                return ftMap[filetype] or customizeSelector
            end
        }
    end
}
