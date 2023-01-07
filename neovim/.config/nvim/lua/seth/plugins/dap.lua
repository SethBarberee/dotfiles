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
        { 'rcarriga/nvim-dap-ui', config = function()
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
        end },
        { 'theHamsta/nvim-dap-virtual-text', config = true },
        'nvim-telescope/telescope-dap.nvim',
        'jbyuki/one-small-step-for-vimkind',
    }
}

function M.config()
    local dap = require('dap')
    local wk = require("which-key")


    -- cpp - c - rust
    dap.adapters.lldb = {
        name = 'lldb',
        type = 'executable',
        command = '/usr/bin/lldb-vscode',
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
        {
            name = "Launch file",
            type = "lldb",
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
            l    = { '<cmd>lua require("dap").run_last()<cr>', 'dap run last' },
        }
    }, { prefix = '<leader>' })


    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

return M