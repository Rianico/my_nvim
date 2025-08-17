return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "default" },

      signature = { enabled = true },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        menu = {
          auto_show = true,
          draw = {
            treesitter = { "lsp" },
            columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },

  --   {
  --     "hrsh7th/nvim-cmp",
  --     version = false, -- last release is way too old
  --     event = "InsertEnter",
  --     dependencies = {
  --       "hrsh7th/cmp-nvim-lsp",
  --       "hrsh7th/cmp-buffer",
  --       "hrsh7th/cmp-path",
  --       "hrsh7th/cmp-cmdline",
  --       {
  --         "garymjr/nvim-snippets",
  --         opts = {
  --           friendly_snippets = true,
  --         },
  --         -- install jsregexp (optional!).
  --         -- build = "make install_jsregexp",
  --         dependencies = { "rafamadriz/friendly-snippets" },
  --       },
  --     },
  --
  --     opts = function(_, _)
  --       local cmp = require("cmp")
  --       local auto_select = false
  --       local options = {
  --         auto_brackets = {}, -- configure any filetype to auto add brackets
  --         completion = {
  --           completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
  --         },
  --         window = {
  --           completion = cmp.config.window.bordered(),
  --           documentation = cmp.config.window.bordered(),
  --         },
  --         preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
  --         mapping = cmp.mapping.preset.insert(require("keybindings").cmp_mapping(cmp, auto_select)),
  --         sources = cmp.config.sources({
  --           { name = "nvim_lsp" },
  --           { name = "path" },
  --           { name = "buffer" },
  --           { name = "cmp-cmdline" },
  --           { name = "snippets" },
  --         }),
  --         formatting = {
  --           format = function(_, item)
  --             local icons = LazyVim.ui.icons.kinds
  --             if icons[item.kind] then
  --               item.kind = icons[item.kind] .. item.kind
  --             end
  --
  --             local widths = {
  --               abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
  --               menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
  --             }
  --
  --             for key, width in pairs(widths) do
  --               if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
  --                 item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
  --               end
  --             end
  --             return item
  --           end,
  --         },
  --         sorting = require("cmp.config.default")().sorting,
  --         snippet = {
  --           expand = function(item) return LazyVim.cmp.expand(item.body) end,
  --         },
  --       }
  --       options = vim.tbl_deep_extend("force", options, require("nvchad.cmp"))
  --       return options
  --     end,
  --   },
}
