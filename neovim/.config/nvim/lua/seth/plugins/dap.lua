local M = {
    'mfussenegger/nvim-dap',
    keys = {
        { '<leader>dso', function() require("dap").step_over() end,         desc = 'step-over' },
        { '<leader>dsi', function() require("dap").step_into() end,         desc = 'step-into' },
        { '<leader>dsb', function() require("dap").step_back() end,         desc = 'step-back' },
        { '<leader>dbs', function() require("dap").toggle_breakpoint() end, desc = 'set-breakpoint' },
        { '<leader>dbl', function() require("dap").list_breakpoints() end,  desc = 'list-breakpoints' },
        { '<leader>dbc', function() require("dap").clear_breakpoints() end, desc = 'clear-breakpoints' },
        { '<leader>dr',  function() require("dap").continue() end,          desc = 'dap run' },
        { '<leader>dl',  function() require("dap").run_last() end,          desc = 'dap run last' },
    },
    dependencies = {
        {
            'mfussenegger/nvim-dap-python',
            config = function()
                require("dap-python").setup(
                    "/usr/bin/python")
            end
        },
        {
            'rcarriga/nvim-dap-ui',
            main = "dapui",
            keys = {
                { '<leader>dt', function() require("dapui").toggle() end, desc = 'dap-ui toggle' },
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
        },
        { 'theHamsta/nvim-dap-virtual-text', config = true },
        'nvim-telescope/telescope-dap.nvim',
    },
    --event = "VeryLazy"
}

function M.config()
    local dap = require('dap')

    local codelldb_bin = "/usr/bin/codelldb"
    local lldb_vscode_bin = "/usr/bin/lldb-vscode"
    local codelldb_lib = "/usr/lib/codelldb/lldb/lib/liblldb.so"

    -- cpp - c - rust
    dap.adapters.lldb = {
        name = 'lldb',
        type = 'executable',
        command = lldb_vscode_bin,
    }

    dap.adapters.codelldb = {
        name = 'codelldb',
        type = 'server',
        port = "${port}",
        executable = {
            command = codelldb_bin,
            args = { "--liblldb", codelldb_lib, "--port", "${port}" },
        },
    }

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "lldb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = false,
        },
    }

    -- Reuse cpp config for C
    dap.configurations.c = dap.configurations.cpp

    dap.configurations.rust = {

        -- NOTE: not as god as codelldb but we'll keep it commented for now
        --{
        --    name = "Launch file",
        --    type = "lldb",
        --    request = "launch",

        --    -- Taken from @rcarriga where it automatically figures out the debug file
        --    program = function()
        --        local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
        --        local metadata = vim.fn.json_decode(metadata_json)
        --        local target_name = metadata.packages[1].targets[1].name
        --        local target_dir = metadata.target_directory
        --        return target_dir .. "/debug/" .. target_name
        --    end,
        --    cwd = '${workspaceFolder}',
        --},

        {
            name = "Launch file (codelldb)",
            type = "codelldb",
            request = "launch",
            -- Taken from @rcarriga where it automatically figures out the debug file
            program = function()
                local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
                local metadata = vim.fn.json_decode(metadata_json)
                local target_name = metadata.packages[1].targets[1].name
                local target_dir = metadata.target_directory
                return target_dir .. "/debug/" .. target_name
            end,
            cwd = '${workspaceFolder}',
        },

    }
end

return M
