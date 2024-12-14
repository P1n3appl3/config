local dap = require "dap"
require("dap-python").setup()

dap.adapters.rr = { type = "executable", command = "rr", name = "rr" }
dap.adapters.rust_lldb = { type = "executable", command = "rust-lldb", name = "rust-lldb" }
dap.adapters.lldb = { type = "executable", command = "lldb", name = "lldb" }
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}
dap.adapters.rust_gdb =
    { type = "executable", command = "rust-gdb", args = { "--interpreter=dap" } }

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

dap.configurations.rust = {
    lldb,
}

local function sign(name, tbl)
    local default = { text = "", texthl = "", linehl = "", numhl = "" }
    vim.fn.sign_define(name, vim.tbl_extend("force", default, tbl))
end

sign("DapStopped", { text = "→", texthl = "DapStopped" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint" })
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
sign("DapBreakpointRegected", { text = "", texthl = "DapBreakpointRegected" })
sign("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition" })
