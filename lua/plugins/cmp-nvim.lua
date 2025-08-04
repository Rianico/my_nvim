return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      {
        "garymjr/nvim-snippets",
        opts = {
          friendly_snippets = true,
        },
        -- install jsregexp (optional!).
        -- build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },

    opts = function(_, _)
      local cmp = require("cmp")
      local auto_select = false
      local options = {
        auto_brackets = {}, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert(require("keybindings").cmp_mapping(cmp, auto_select)),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "cmp-cmdline" },
          { name = "snippets" },
        }),
        formatting = {
          format = function(_, item)
            local icons = LazyVim.ui.icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end

            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end
            return item
          end,
        },
        sorting = require("cmp.config.default")().sorting,
        snippet = {
          expand = function(item) return LazyVim.cmp.expand(item.body) end,
        },
      }
      options = vim.tbl_deep_extend("force", options, require("nvchad.cmp"))
      return options
    end,
  },
}
