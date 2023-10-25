_G.F_get_python_path = function(workspace)
  local lsp_util = require("lspconfig/util")
  local path = lsp_util.path
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end
  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end
  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

_G.F_format_on_save = function(bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("Format", { clear = true }),
    buffer = bufnr,
    callback = function() vim.lsp.buf.format({ async = false }) end
  })
end

_G.F_map = function(tbl, f)
  local t = {}
  for k, v in pairs(tbl) do
    t[k] = f(v)
  end
  return t
end

-- @see https://stackoverflow.com/questions/1410862/concatenation-of-tables-in-lua
-- _G.f_merge_second_table = function(mut_table, t2)
--   for i = 1, #t2 do mut_table[#mut_table + 1] = t2[i] end
--   return mut_table
-- end
-- _G.F_print_table = function(t) print(table.concat(t, '\n')) end
-- _G.F_path_exists = function(path)
--   return vim.loop.fs_stat(path)
-- end
-- _G.F_project_files = function()
--   local path = vim.loop.cwd() .. "/.git"
--   if path_exists(path) then
--     return "Telescope git_files"
--   else
--     return "Telescope find_files"
--   end
-- end
