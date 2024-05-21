---@diagnostic disable: missing-fields
return {
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        enabled = vim.fn.has('nvim-0.10') == 0, -- disable once nvim 0.10 hits with core commentstring
    },
    {
        'numToStr/Comment.nvim',
        enabled = vim.fn.has('nvim-0.10') == 0, -- disable once nvim 0.10 hits with built-in commenting
        config = function()
            require('Comment').setup {
                pre_hook = function()
                    return vim.bo.commentstring
                end
            }
        end,
        event = "VeryLazy",
    }
}
