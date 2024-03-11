function CC_tab_size(n --[[int]])
  vim.opt.tabstop = n
  vim.opt.softtabstop = n
  vim.opt.shiftwidth = n
end

local is_transparent = false
local toggle_bg = function()
  if is_transparent then
    is_transparent = false
    vim.opt.background = "dark" -- vim.cmd("set background=dark")
  else
    is_transparent = true
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
  end
end

vim.api.nvim_create_user_command(
  'CCBgTransparentToggle',
  -- function(input) vim.print(input) end
  function() toggle_bg() end,
  { desc = 'Toggle transparent background' }
)
