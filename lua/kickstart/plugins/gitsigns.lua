-- Alternatively, use `config = function() ... end` for full control over the configuration.
-- If you prefer to call `setup` explicitly, use:
--    {
--        'lewis6991/gitsigns.nvim',
--        config = function()
--            require('gitsigns').setup({
--                -- Your gitsigns configuration here
--            })
--        end,
--    }
--
-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`.
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      -- Git hunk navigation
      {
        ']h',
        function()
          if vim.wo.diff then
            vim.cmd.normal(']c')
          else
            require('gitsigns').nav_hunk('next')
          end
        end,
        desc = 'Next git hunk'
      },
      {
        '[h',
        function()
          if vim.wo.diff then
            vim.cmd.normal('[c')
          else
            require('gitsigns').nav_hunk('prev')
          end
        end,
        desc = 'Previous git hunk'
      },
    },
    config = function()
      -- NOTE: Previously broke when moved to 'opts' - keymap registration failed
      -- Exercise extra care if converting to opts format in the future
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        numhl = true, -- Enable line number highlighting
        linehl = false, -- Disable line highlighting (we only want line numbers)
        on_attach = function(bufnr)
          local gitsigns = require 'gitsigns'

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Actions
          -- visual mode
          map('v', '<leader>hs', function()
            gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'git [s]tage hunk' })
          map('v', '<leader>hr', function()
            gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'git [r]eset hunk' })
          -- normal mode
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
          map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
          map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
          map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
          map('n', '<leader>hD', function()
            gitsigns.diffthis '@'
          end, { desc = 'git [D]iff against last commit' })
          -- Toggles
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
          map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
        end,
      })

      -- Set up custom highlight groups for line number backgrounds
      vim.api.nvim_set_hl(0, 'GitSignsAddNr', { bg = '#2d5a16', fg = '#ffffff' })
      vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { bg = '#5c3a00', fg = '#ffffff' })
      vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { bg = '#6b1a1a', fg = '#ffffff' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
