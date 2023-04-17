local M = {
    'mfussenegger/nvim-dap',
    ft = {
        "python",
        "rust",
        "c",
        "cpp",
        "lua"
    },
    dependencies = {
        'mfussenegger/nvim-dap-python',
        {
            'rcarriga/nvim-dap-ui',
            config = function()
                require("dapui").setup({
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
                })
            end
        },
        { 'theHamsta/nvim-dap-virtual-text', config = true },
        'nvim-telescope/telescope-dap.nvim',
        'jbyuki/one-small-step-for-vimkind',
    },
    event = "VeryLazy"
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


    dap.configurations.lua = {
        {
            type = 'nlua',
            request = 'attach',
            name = "Attach to running Neovim instance",
        }
    }

    dap.adapters.nlua = function(callback, config)
        callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port })
    end

    -- Define user command to start up DAP for lua
    vim.api.nvim_create_user_command('DapStartLua', function()
        require "osv".run_this()
    end, {})

    -- Debugpy installed as module of system python
    require("dap-python").setup('/usr/bin/python')

    vim.keymap.set('n', '<leader>dso', require('dap').step_over, { desc = 'step-over' })
    vim.keymap.set('n', '<leader>dsi', require('dap').step_into, { desc = 'step-into' })
    vim.keymap.set('n', '<leader>dsb', require('dap').step_back, { desc = 'step-back' })
    vim.keymap.set('n', '<leader>dbs', require('dap').toggle_breakpoint, { desc = 'set-breakpoint' })
    vim.keymap.set('n', '<leader>dbl', require('dap').list_breakpoints, { desc = 'list-breakpoints' })
    vim.keymap.set('n', '<leader>dbc', require('dap').clear_breakpoints, { desc = 'clear-breakpoints' })
    vim.keymap.set('n', '<leader>dt', require('dapui').toggle, { desc = 'dap-ui toggle' })
    vim.keymap.set('n', '<leader>dr', require('dap').continue, { desc = 'dap run' })
    vim.keymap.set('n', '<leader>dl', require('dap').run_last, { desc = 'dap run last' })

    local dapui = require("dapui")
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

return M
