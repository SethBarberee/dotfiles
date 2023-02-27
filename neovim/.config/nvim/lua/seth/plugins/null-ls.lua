local M = {
    'jose-elias-alvarez/null-ls.nvim',
}

function M.setup()
    local null_ls = require('null-ls')
    local nls_diags = null_ls.builtins.diagnostics
    local nls_format = null_ls.builtins.formatting
    local nls_codeActions = null_ls.builtins.code_actions

    null_ls.setup {
        sources = {
            nls_diags.vint.with({ extra_args = { "--enable-neovim" } }), -- use vint for vim files and enable neovim syntax
            nls_format.trim_whitespace,

            nls_codeActions.gitsigns,

            -- Python
            nls_format.black,
            nls_format.isort,
        },
        on_init = function(new_client, _)
            --local filetype = vim.api.nvim_buf_get_option(0, "filetype")
        end,
        should_attach = function(bufnr)
            local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

            -- I don't want null-ls to on when using clangd/ccls and messing with offset-encoding
            if filetype == 'c' or filetype == "cpp" then
                return false
            end
            return true
        end,
        border = 'rounded',
    }
end

return M
