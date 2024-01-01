return {
    'rrethy/vim-illuminate',
    event = "BufReadPost",
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
