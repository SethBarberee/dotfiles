---@diagnostic disable: missing-fields
return {
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {
                pre_hook = function()
                    -- return vim.bo.commentstring
                    require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
                end
            }
        end,
        event = "VeryLazy",
    }
}
