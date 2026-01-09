-- @see https://github.com/nvim-telescope/telescope.nvim
-- telescope.nvim is a highly extendable fuzzy finder over lists. Built on the 
-- latest awesome features from neovim core. Telescope is centered around modularity,
-- allowing for easy customization.

local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  -- keys = { }, -- keymaps are in mapping file.
  config = function()
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")
    local actions = require("telescope.actions")
    local action_layout = require("telescope.actions.layout")
    local themes = require("telescope.themes")
    -- local fb_actions = require("telescope").extensions.file_browser.actions
    local keymaps = require("core.mappings.telescope")

    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
    -- trim the indentation at the beginning of presented line
    table.insert(vimgrep_arguments, "--trim")

    local fzf_opts = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }

    telescope.setup({
      extensions = {
        fzf = fzf_opts,
        ["ui-select"] = { themes.get_dropdown({}) },
      },
      pickers = {
        find_files = { hidden = false },
        buffers = { ignore_current_buffer = true, sort_lastused = true },
        live_grep = {
          sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts),
          only_sort_text = true, -- grep for content and not file name/path
        },
      },
      defaults = {
        -- file_ignore_patterns = settings.telescope_file_ignore_patterns,
        vimgrep_arguments = vimgrep_arguments,
        mappings = {
          -- i = keymaps.window_open_keymaps,
          i = keymaps.load_window_opened_keymaps(actions, action_layout),
        },
        -- prompt_prefix = table.concat({ icons.arrows.ChevronRight, " " }),
        -- selection_caret = icons.arrows.CurvedArrowRight,
        entry_prefix = "  ",
        -- multi_icon = icons.arrows.Diamond,
        initial_mode = "insert",
        scroll_strategy = "cycle",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.95,
          height = 0.85,
          -- preview_cutoff = 120,
          prompt_position = "top",
          horizontal = {
            preview_width = function(_, cols, _)
              if cols > 200 then
                return math.floor(cols * 0.4)
              else
                return math.floor(cols * 0.6)
              end
            end,
          },
          vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
          flex = { horizontal = { preview_width = 0.9 } },
        },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      },
    })

    telescope.load_extension("fzf")
  end,
}

return M
