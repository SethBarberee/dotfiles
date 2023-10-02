return {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    event = "BufReadPost",
    opts = {
        -- Disable indent-blankline underline of scopes
        scope = {
            show_start = false,
            show_end = false
        }
    }
}
