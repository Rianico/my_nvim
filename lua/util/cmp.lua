local M = {}

M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
function M.create_undo()
  if vim.api.nvim_get_mode().mode == "i" then
    vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
  end
end

-- This is a better implementation of `cmp.confirm`:
--  * check if the completion menu is visible without waiting for running sources
--  * create an undo point before confirming
-- This function is both faster and more reliable.
---@param opts? {select: boolean, behavior: cmp.ConfirmBehavior}
function M.confirm(opts)
  local cmp = require("cmp")
  opts = vim.tbl_extend("force", {
    select = true,
    behavior = cmp.ConfirmBehavior.Insert,
  }, opts or {})
  return function(fallback)
    if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
      M.create_undo()
      if cmp.confirm(opts) then
        return
      end
    end
    return fallback()
  end
end

-- This function resolves nested placeholders in a snippet.
---@param snippet string
---@return string
function M.snippet_preview(snippet)
  local ok, parsed = pcall(function() return vim.lsp._snippet_grammar.parse(snippet) end)
  return ok and tostring(parsed)
    or M.snippet_replace(snippet, function(placeholder) return M.snippet_preview(placeholder.text) end):gsub("%$0", "")
end

---@param snippet string
---@param fn fun(placeholder:Placeholder):string
---@return string
function M.snippet_replace(snippet, fn)
  return snippet:gsub("%$%b{}", function(m)
    local n, name = m:match("^%${(%d+):(.+)}$")
    return n and fn({ n = n, text = name }) or m
  end) or snippet
end

-- This function replaces nested placeholders in a snippet with LSP placeholders.
function M.snippet_fix(snippet)
  local texts = {} ---@type table<number, string>
  return M.snippet_replace(snippet, function(placeholder)
    texts[placeholder.n] = texts[placeholder.n] or M.snippet_preview(placeholder.text)
    return "${" .. placeholder.n .. ":" .. texts[placeholder.n] .. "}"
  end)
end

function M.expand(snippet)
  -- Native sessions don't support nested snippet sessions.
  -- Always use the top-level session.
  -- Otherwise, when on the first placeholder and selecting a new completion,
  -- the nested session will be used instead of the top-level session.
  -- See: https://github.com/LazyVim/LazyVim/issues/3199
  local session = vim.snippet.active() and vim.snippet._session or nil

  local ok, err = pcall(vim.snippet.expand, snippet)
  if not ok then
    local fixed = M.snippet_fix(snippet)
    ok = pcall(vim.snippet.expand, fixed)

    local msg = ok and "Failed to parse snippet,\nbut was able to fix it automatically."
      or ("Failed to parse snippet.\n" .. err)

    M[ok and "warn" or "error"](
      ([[%s
```%s
%s
```]]):format(msg, vim.bo.filetype, snippet),
      { title = "vim.snippet" }
    )
  end

  -- Restore top-level session when needed
  if session then
    vim.snippet._session = session
  end
end

return M
