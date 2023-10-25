-- @see https://github.com/nvim-lualine/lualine.nvim
-- A blazing fast and easy to configure Neovim statusline written in Lua.
local M = {
  'nvim-lualine/lualine.nvim',
  depedencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    local lualine = require('lualine')
    local icons = require('core.utils.nerdfonts-icons')
    local colors = require("core.utils.colors")
    local web_devicons = require("nvim-web-devicons")
    local dynamic_color = require("core.utils.color-by-mode")
    local color_by_mode = function()
      return { fg = dynamic_color() }
    end

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end
    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      function() return '▊' end,
      color = color_by_mode,  -- Sets highlighting of component
      padding = { left = 0 }, -- We don't need space before this
    }

    ins_left {
      -- mode component
      function()
        return web_devicons.get_icon_by_filetype(vim.bo.filetype, {
          default = true
        })
      end,
      color = color_by_mode,
      padding = { right = 1 },
    }

    ins_left {
      -- filesize component
      'filesize',
      cond = conditions.buffer_not_empty,
    }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = 'bold' },
    }

    ins_left { 'location' }

    ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warning,
        info = icons.diagnostics.Info
      },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function() return '%=' end,
    }

    ins_left {
      -- Lsp server name .
      function()
        local inactive_msg = 'No Active Lsp'
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then return inactive_msg end

        local msg
        local buf_ft = vim.api.nvim_get_option_value('filetype', {})
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            if (not msg) then
              msg = client.name
            else
              msg = msg .. ',' .. client.name
            end
          end
        end
        return msg or inactive_msg
      end,
      icon = icons.ui.Code .. 'LSP:',
      color = { fg = '#ffffff', gui = 'bold' },
    }

    -- Add components to right sections
    -- ins_right {
    --   'o:encoding',       -- option component same as &encoding in viml
    --   fmt = string.upper, -- I'm not sure why it's upper case either ;)
    --   cond = conditions.hide_in_width,
    --   color = { fg = colors.green, gui = 'bold' },
    -- }

    -- ins_right {
    --   'fileformat',
    --   fmt = string.upper,
    --   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    --   color = { fg = colors.green, gui = 'bold' },
    -- }

    ins_right {
      'branch',
      icon = icons.git.Branch,
      color = { fg = colors.violet, gui = 'bold' },
    }

    ins_right {
      'diff',
      symbols = { added = icons.ui.Plus, modified = icons.ui.Mod, removed = icons.ui.Trash },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    ins_right {
      function() return '▊' end,
      color = color_by_mode,
      padding = { left = 1 },
    }

    lualine.setup(config)
  end
}
return M
