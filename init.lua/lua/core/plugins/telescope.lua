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
  keys = {
    -- Search stuff
    { "<leader>g?", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>kk", "<cmd>Telescope keymaps<cr>", desc = "Show keymaps list" },
    { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Strings" },
    {
      "<leader>fg",
      "<cmd>lua require'telescope.builtin'.grep_string{ shorten_path = true, word_match = '-w', only_sort_text = true, search = '' }<cr>",
      desc = "Fuzzy search",
    },
    -- Git
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
    { "<leader>gt", "<cmd>Telescope git_status<cr>", desc = "Status" },
    { "<leader>gm", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
    -- Files
    { "<leader>fb", "<cmd>Telescope file_browser grouped=true<cr>", desc = "Filebrowser" },
    -- { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    -- Other
    { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Bufferlist" },
    { "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
  },
  config = function()
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")
    local actions = require("telescope.actions")
    local action_layout = require("telescope.actions.layout")
    -- local fb_actions = require("telescope").extensions.file_browser.actions

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
        ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
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
          i = {
            -- Close on first esc instead of going to normal mode
            -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-q>"] = actions.send_selected_to_qflist,
            ["<C-l>"] = actions.send_to_qflist,
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<cr>"] = actions.select_default,
            ["<c-v>"] = actions.select_vertical,
            ["<c-s>"] = actions.select_horizontal,
            ["<c-t>"] = actions.select_tab,
            ["<c-p>"] = action_layout.toggle_preview,
            ["<c-o>"] = action_layout.toggle_mirror,
            ["<c-h>"] = actions.which_key,
            ["<c-x>"] = actions.delete_buffer,
          },
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
