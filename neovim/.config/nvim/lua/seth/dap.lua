local dap = require('dap')
local wk = require("which-key")

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'rt_lldb',
        request = "launch",
        program = function()
            return vim.fn.input(
                "Path to executable: ",
                vim.fn.getcwd() .. "/",
                "file"
            )
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},

        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        -- runInTerminal = false,
    },
}

-- If you want to use this for Rust and C, add something like this:
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("dapui").setup({})

wk.register({

    d = {
        name = "dap",
        s    = {
            name = "line-step",
            o    = { '<cmd>lua require("dap").step_over()<cr>', 'step-over' },
            i    = { '<cmd>lua require("dap").step_into()<cr>', 'step-into' },
            b    = { '<cmd>lua require("dap").step_back()<cr>', 'step-back' },
        },
        b    = {
            name = "breakpoints",
            s    = { '<cmd>lua  require("dap").toggle_breakpoint()<cr>', 'set-breakpoint' },
            l    = { '<cmd>lua require("dap").list_breakpoints()<cr>', 'list-breakpoints' },
            c    = { '<cmd>lua require("dap").clear_breakpoints()<cr>', 'list-breakpoints' },
        },
        -- TODO: also add functionality to close REPL console too
        t    = { '<cmd>lua require("dapui").toggle()<cr>', 'dap-ui toggle' },
        r    = { '<cmd>lua require("dap").continue()<cr>', 'dap run' },
    }
}, { prefix = '<leader>' })
