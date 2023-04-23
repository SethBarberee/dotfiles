local bufnr = vim.api.nvim_get_current_buf()
local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

-- Add rounded borders to these handlers on every filetype
local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

-- Poryscript needs custom handlers so we do that here
--if filetype == "pory" then
handlers["poryscript/getPoryscriptFiles"] = function(_, result, ctx, _)
    -- search for all *pory files for this request
    -- and return a table of URIs

    -- get all files ending with .pory
    local files = vim.fs.find(function(name, path)
        return name:match('.*%.pory$')
    end, { limit = math.huge, type = 'file' })

    --print(vim.inspect(files))

    local files_array = {}
    for k, v in pairs(files) do
        local uri_file = vim.uri_from_fname(v)
        table.insert(files_array, uri_file)
    end
    print(vim.inspect(files_array))
    return files_array
end

handlers["poryscript/getfileuri"] = function(_, result, ctx, _)
    print("get file uri")
    print(vim.inspect(result))
    return vim.uri_from_bufnr(0)
end

handlers["poryscript/readfile"] = function(_, result, ctx, _)
    local bufnr = vim.uri_to_bufnr(result)
    if vim.api.nvim_buf_is_loaded(bufnr) then
        -- NOTE: Read the lines in the buffer and then combine into a string since poryscript-pls expects a string
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        return table.concat(lines, "\n")
    else
        return ""
    end
end

handlers["poryscript/readfs"] = function(_, result, ctx, _)
    local bufnr = vim.uri_to_bufnr(result)
    if vim.api.nvim_buf_is_loaded(bufnr) then
        -- NOTE: Read the lines in the buffer and then combine into a string since poryscript-pls expects a string
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        return table.concat(lines, "\n")
    else
        return ""
    end
end
--end

return handlers
