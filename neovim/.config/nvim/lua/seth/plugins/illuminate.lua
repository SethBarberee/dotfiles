return {
    'rrethy/vim-illuminate',
    event = "VeryLazy",
    config = function()
        require('illuminate').configure({
            filetypes_denylist = {
                'dirbuf',
                'dirvish',
                'fugitive',
                'Glance'
            },
        })
    end
}
