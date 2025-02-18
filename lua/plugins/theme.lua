return {
  {
    "akinsho/bufferline.nvim",
    opts = {},
    config = function(_, _)
      require("bufferline").setup({
        options = {
          -- stylua: ignore
          close_command = function(n) Snacks.bufdelete(n) end,
          -- stylua: ignore
          right_mouse_command = function(n) Snacks.bufdelete(n) end,
          diagnostics = "nvim_lsp",
          always_show_bufferline = false,
          diagnostics_indicator = function(_, _, diag)
            local icons = LazyVim.ui.icons.diagnostics
            local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warn .. diag.warning or "")
            return vim.trim(ret)
          end,
          offsets = {
            {
              filetype = "snacks_layout_box",
            },
          },
          show_close_icon = false,
          show_buffer_close_icons = false,
          show_buffer_icons = false, -- disable filetype icons for buffers
          ---@param opts bufferline.IconFetcherOpts
          get_element_icon = function(opts) return LazyVim.ui.icons.ft[opts.filetype] end,
        },
      })
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function() pcall(nvim_bufferline) end)
        end,
      })
    end,
  },

  {
    "nvchad/ui",
    config = function() require("nvchad") end,
  },

  {
    "nvchad/base46",
    commit = "c58d8a76fcd31462ef707c55d9f4147c3927721f",
    build = function() require("base46").load_all_highlights() end,
  },
  "nvzone/volt",
}
