return {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'mfussenegger/nvim-dap',
    },
    config = function()
        require("dap-python").setup(
            "/usr/bin/python")
    end
}
