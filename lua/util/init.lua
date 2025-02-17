local LazyUtil = require("lazy.core.util")

local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    t[k] = require("util." .. k)
    return t[k]
  end,
})

---@param name string
function M.get_plugin(name) return require("lazy.core.config").spec.plugins[name] end

---@param name string
---@param path string?
function M.get_plugin_path(name, path)
  local plugin = M.get_plugin(name)
  path = path and "/" .. path or ""
  return plugin and (plugin.dir .. path)
end

---@param plugin string
function M.has(plugin) return M.get_plugin(plugin) ~= nil end

return M
