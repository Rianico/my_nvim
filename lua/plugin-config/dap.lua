require("dapui").setup()

local dap, dapui = require "dap", require "dapui"

require("keybindings").dap_mapping(dap, dapui)


dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
