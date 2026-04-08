# Error diagnostics Virtual-lines

## [WIP] Work in progress
### Fix: line out of range
There is error that crashes neovim window when aparently too many error lines are added.
To test it change `MAX_COL_WIDTH` to a small number(e.g. 20).

## Other codes.
```lua
---@see https://www.reddit.com/r/vim/comments/wm08fl/comment/ijwdgzs/
M.inline_colors = function()
  -- Loop through each line in the buffer.
  for row = 1, vim.api.nvim_buf_line_count(0) do
    -- Get the current line content.
    local current = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
    -- Clear any previous properties for the current row.
    vim.api.nvim_buf_set_extmark(0, 0, row - 1, 0, { id = 0, end_line = row, end_col = 0 })

    local cnt = 1
    local hex, starts, ends = string.match(current, "(#%x%x%x%x%x%x)", cnt)

    -- Continue searching for hex color codes in the line.
    while starts do
      local col_tag = "inline_color_" .. hex
      local col_type = vim.api.nvim_get_hl_by_name(col_tag, true)

      -- Check if the highlight group exists; if not, create it.
      if not col_type then
        vim.api.nvim_set_hl(0, col_tag, { fg = hex })
      end

      -- Add inline highlight for the found color code.
      vim.api.nvim_buf_set_extmark(0, 0, row - 1, starts - 1, {
        id = 0,
        virt_text = { { " ● ", col_tag } },
        virt_text_pos = 'eol',  -- Place the dot at the end of the line.
        hl_mode = 'combine',
      })

      -- Find the next color code in the line.
      cnt = cnt + 1
      hex, starts, ends = string.match(current, "(#%x%x%x%x%x%x)", cnt)
    end
  end
end
```
