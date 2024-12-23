local dap = require "dap"

require("dap-python").setup()
require("nvim-dap-virtual-text").setup()

dap.adapters.rr = { type = "executable", command = "rr" }
dap.adapters.lldb = { type = "executable", command = "lldb" }
dap.adapters.rust_lldb = { type = "executable", command = "rust-lldb" }
local port = 17776
dap.adapters.codelldb = {
    type = "server",
    port = 17776,
    executable = { command = "codelldbb", args = { "--port", 17776 } },
}
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}
dap.adapters.rust_gdb =
    { type = "executable", command = "rust-gdb", args = { "--interpreter=dap" } }

dap.configurations.cpp = {
    {
      name = "Attach to process",
      type = 'cpp',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
      request = 'attach',
      pid = require('dap.utils').pick_process,
      args = {},
    },
}

local gdb_configs = {
    launch = {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    attach = {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        pid = function()
            local name = vim.fn.input "Executable name (filter): "
            return require("dap.utils").pick_process { filter = name }
        end,
        cwd = "${workspaceFolder}",
    },
    server = {
        name = "Attach to gdbserver :1234",
        type = "gdb",
        request = "attach",
        target = "localhost:1234",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
    },
}

local lldb = {
    name = "Launch lldb",
    type = "lldb",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    runInTerminal = false,
    args = {},
}

dap.configurations.c = {
    lldb,
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

local function sign(name, tbl)
    local default = { text = "", texthl = "", linehl = "", numhl = "" }
    vim.fn.sign_define(name, vim.tbl_extend("force", default, tbl))
end

sign("DapStopped", { text = "→", texthl = "DapStopped" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint" })
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
sign("DapBreakpointRegected", { text = "", texthl = "DapBreakpointRegected" })
sign("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition" })
