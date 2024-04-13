local sethconfig = require("seth.config")

local M = {
    'mfussenegger/nvim-dap',
    enabled = sethconfig.dap,
    keys = {
        { '<leader>dso', function() require("dap").step_over() end,         desc = 'step-over' },
        { '<leader>dsi', function() require("dap").step_into() end,         desc = 'step-into' },
        { '<leader>dsb', function() require("dap").step_back() end,         desc = 'step-back' },
        { '<leader>dbs', function() require("dap").toggle_breakpoint() end, desc = 'toggle-breakpoint' },
        {
            '<leader>dbl',
            function()
                require("dap").list_breakpoints()
                local entries = vim.fn.getqflist()

                if #entries > 0 then
                    vim.cmd.copen()
                end
            end,
            desc = 'list-breakpoints'
        },
        { '<leader>dbc', function() require("dap").clear_breakpoints() end, desc = 'clear-breakpoints' },
        { '<leader>dr',  function() require("dap").continue() end,          desc = 'dap run' },
        { '<leader>dl',  function() require("dap").run_last() end,          desc = 'dap run last' },
        { '<leader>dc',  function() require("dap").repl.toggle() end,       desc = 'dap repl' },
    },
    dependencies = {
        { 'theHamsta/nvim-dap-virtual-text', config = true },
        -- 'nvim-telescope/telescope-dap.nvim',
    },
    --event = "VeryLazy"
}

function M.config()
    local dap = require('dap')

    local codelldb_bin = "/usr/bin/codelldb"
    local lldb_vscode_bin = "/usr/bin/lldb-vscode"
    local codelldb_lib = "/usr/lib/codelldb/lldb/lib/liblldb.so"

    vim.fn.sign_define('DapBreakpoint',
        { text = 'B', texthl = 'DiagnosticInfo', linehl = '', numhl = 'DiagnosticInfo' })

    vim.fn.sign_define('DapStopped',
        { text = '→', texthl = 'DiagnosticError', linehl = 'DiagnosticError', numhl = 'DiagnosticError' })

    dap.defaults.fallback.external_terminal = {
        command = '/usr/bin/kitty',
        args = { '-e' }
    }

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
            name = "Launch file (lldb)",
            type = "lldb",
            request = "launch",
            program = function()
                return vim.fn.input({
                    prompt = 'Path to executable: ',
                    default = vim.fn.getcwd() .. '/',
                    completion = 'file'
                })
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = false,
        },
        {
            name = "Launch file (codelldb)",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input({
                    prompt = 'Path to executable: ',
                    default = vim.fn.getcwd() .. '/',
                    completion = 'file'
                })
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

    -- if sethconfig.dap then require("telescope").load_extension("dap") end
end

return M
