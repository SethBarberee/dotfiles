return {
    'rcarriga/nvim-dap-ui',
    main = "dapui",
    dependencies = { 'mfussenegger/nvim-dap' },
    keys = {
        { '<leader>dt', function() require("dapui").toggle() end, desc = 'dap-ui toggle' },
        {
            '<leader>df',
            function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end,
            desc = 'dap-ui float scope'
        },
        {
            '<leader>dh',
            function()
                require('dap.ui.widgets').hover()
            end,
            desc = 'dap-ui hover'
        },
    },
    opts = {
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        controls = {
            -- Needs at least nvim 0.8
            enabled = vim.fn.has("nvim-0.8") == 1,
            -- Display controls in this element
            element = "repl",
            icons = {
                pause = "",
                play = "",
                step_into = "",
                step_over = "",
                step_out = "",
                step_back = "",
                run_last = "",
                terminate = "",
            },
        },
    },
    config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
            dap.repl.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
            dap.repl.close()
        end
    end
}
