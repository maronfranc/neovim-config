---A blazing fast and easy to configure Neovim statusline written in Lua.
---@see https://github.com/nvim-lualine/lualine.nvim
local M = {
  'nvim-lualine/lualine.nvim',
  depedencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    local lualine = require('lualine')
    local icons = require('core.utils.icons')
    local colors = require("core.utils.colors")
    local dynamic_color = require("core.utils.color-by-mode")
    local function color_by_mode() return { fg = dynamic_color() } end

    local conditions = {
      buffer_not_empty = function()
        local is_toggleterm = vim.bo.filetype == "toggleterm"
        return not is_toggleterm and vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
      -- check_git_workspace = function()
      --   local filepath = vim.fn.expand('%:p:h')
      --   local gitdir = vim.fn.finddir('.git', filepath .. ';')
      --   return gitdir and #gitdir > 0 and #gitdir < #filepath
      -- end,
    }

    local section_rectangle = {
      function() return '▊' end,
      color = color_by_mode,
      padding = { left = 0, right = 0 }, -- We don't need left space before this
    }
    local section_foldername = {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = "#999999" },
      -- 0: Just the filename
      -- 1: Relative path
      -- 2: Absolute path
      -- 3: Absolute path, with tilde as the home directory
      -- 4: Filename and parent dir, with tilde as the home directory
      path = 4,
      fmt = function(path, _) -- (path, context)
        local folder_and_filename = vim.split(path, "/")
        return icons.ui.Folder .. folder_and_filename[1] .. "/"
      end,
      padding = { right = 0, left = 0 },
      symbols = { modified = "", readonly = "", unnamed = "", newfile = "" }
    }
    local section_absolute_path = {
      'filename',
      cond = function()
        return conditions.buffer_not_empty() and conditions.hide_in_width()
      end,
      fmt = function(path, _) return icons.ui.Folder .. path end,
      path = 3,
    }

    local section_filename = {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = "#ffffff", gui = 'bold' },
      path = 0,
      padding = { right = 0, left = 0 },
      ---@todo Try to implement this regex in lua `([a-zA-Z-0-9]+)(?:\.[a-zA-Z-0-9]+)?\s*(.+)?`
      ---Match: "filename.ext" and "filename.ext [+]" and "filename [+]" and "filename [+]"
      fmt = function(path, _) -- (path, context)
        local REGEX_FILENAME_AND_EXT = "^([a-zA-Z-0-9_-]+)%.[a-zA-Z-0-9]+"
        local REGEX_FILENAME = "^([a-zA-Z-0-9]+)"
        local matched_filename =
            path:match(REGEX_FILENAME_AND_EXT) or
            path:match(REGEX_FILENAME)
            or ""
        if matched_filename == "" then return path end

        local REGEX_ENDING_WITH_SYMBOLD = "%s+(.+)$"
        local matched_symbold = path:match(REGEX_ENDING_WITH_SYMBOLD) or ""
        return matched_symbold .. matched_filename
      end,
    }

    local section_file_icon = {
      'filetype',
      cond = conditions.buffer_not_empty,
      colored = true,
      icon_only = false,
      icon = { align = 'right' }, -- Display filetype icon on the right hand side
      fmt = function(ext_name, _)
        -- if ext_name then return "." .. ext_name end
        -- return ""
        return "." .. ext_name
      end,
      padding = { left = 0, right = 1 },
    }

    local section_diagnostics = {
      cond = conditions.hide_in_width,
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

    ---Insert mid section. You can make any number of sections in neovim :)
    ---for lualine it's any number greater then 2
    local section_empty_space = { function() return '%=' end }

    local section_lsp_server = {
      function()
        local inactive_msg = 'No Active Lsp'
        local clients = vim.lsp.get_clients()
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
      color = { fg = '#ffffff' },
    }

    local section_branch = {
      'branch',
      icon = icons.git.Branch,
      color = { fg = colors.violet, gui = 'bold' },
    }

    local section_diff = {
      'diff',
      cond = conditions.hide_in_width,
      symbols = { added = icons.ui.Plus, modified = icons.ui.Mod, removed = icons.ui.Trash },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
    }

    lualine.setup({
      disabled_buftypes = { 'quickfix', 'prompt' }, -- Hide a window if its buffer's type is disabled
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      -- winbar = {}, inactive_winbar = {}, top bar
      sections = {
        lualine_a = {},
        lualine_b = { section_branch },
        lualine_c = {
          section_rectangle,
          section_diff,
          section_empty_space,
          section_foldername,
          section_filename,
          section_file_icon,
          section_lsp_server,
        },
        lualine_x = { section_diagnostics, section_rectangle },
        lualine_y = {
          { 'progress', color = { fg = colors.fg, gui = 'bold' } },
          { 'location' },
        },
        lualine_z = {},
      },
      inactive_sections = {
        -- Empty values to remove defaults
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          section_rectangle,
          section_empty_space,
          section_absolute_path,
        },
        lualine_x = { section_rectangle },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end
}
return M
