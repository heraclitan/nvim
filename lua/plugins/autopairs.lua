-- ~/.config/nvim/lua/plugins/autopairs.lua
-- Auto-pairing configuration

return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local autopairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      
      autopairs.setup({
        check_ts = true, -- Use Treesitter for context-aware pairing
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          python = { "string" },
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
      
      -- Remove default quote rules
      autopairs.remove_rule('"')
      autopairs.remove_rule("'")
      
      -- Add custom rules for quotes with better context awareness
      local quote_filetypes = { "lua", "python", "javascript", "typescript", "c", "cpp" }
      
      -- Double quotes rule with context awareness
      autopairs.add_rules({
        Rule('"', '"', quote_filetypes)
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col - 1)
            return pair ~= "\\"
          end)
          :with_pair(function(opts)
            local pair = opts.line:sub(1, opts.col - 1)
            return not pair:match('"$') -- Don't pair if already inside a quote
          end)
          :with_move(function(opts)
            return opts.prev_char:match('"') and opts.char:match('"')
          end)
          :with_cr(function(opts)
            return false
          end)
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 1)
            return context:match('""') or context:match('""')
          end),
        
        -- Single quotes rule with context awareness
        Rule("'", "'", quote_filetypes)
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col - 1)
            return pair ~= "\\"
          end)
          :with_pair(function(opts)
            local pair = opts.line:sub(1, opts.col - 1)
            return not pair:match("'$") -- Don't pair if already inside a single quote
          end)
          :with_move(function(opts)
            return opts.prev_char:match("'") and opts.char:match("'")
          end)
          :with_cr(function(opts)
            return false
          end)
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 1)
            return context:match("''") or context:match("''")
          end),
      })
      
      -- Integrate with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
}