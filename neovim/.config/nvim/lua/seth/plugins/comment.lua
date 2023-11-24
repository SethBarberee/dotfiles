---@diagnostic disable: missing-fields
return {
    'JoosepAlviste/nvim-ts-context-commentstring',
    {
        'numToStr/Comment.nvim',
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
