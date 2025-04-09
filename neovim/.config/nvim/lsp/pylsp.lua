return {
    cmd =  {'pylsp'},
    filetypes = {'python'},
    root_markers = {'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile'},
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'E261' },
                    maxLineLength = 100,
                }
            }
        }
    },
}
