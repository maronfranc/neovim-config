local state = require("core.local-plugins.nvim-cmp-css.state")
local fs_helper = require("core.local-plugins.nvim-cmp-css.fs-helper")
local source_name = "cmp_css"
---@diagnostic disable: duplicate-set-field
---@class cmp.Source
local source = {}

---Return whether this source is available in the current context or not (optional).
---@return boolean
function source:is_available() return vim.tbl_contains(self.options.filetypes, vim.bo.filetype) end

---Return the debug name of this source (optional).
---@return string
function source:get_debug_name() return "debug " .. source_name end

---Return trigger characters for triggering completion (optional).
function source:get_trigger_characters() return self.options.trigger_characters end

---Invoke completion (required).
---@param params cmp.SourceCompletionApiParams
---@param callback fun(response: lsp.CompletionResponse|nil)
function source:complete(params, callback)
	fs_helper:process_css_selectors()
	callback(state:get_css_selectors(params))
end

---Register css_cmp to nvim-cmp.
---@param options options|nil
function source.setup(options)
	---@type options
	local default_opts = {
		filetypes = { "html" },
		trigger_characters = { ".", "#" },
	}
	source.options = options or default_opts
	source.options.filetypes = source.options.filetypes or default_opts.filetypes
	source.options.trigger_characters = source.options.trigger_characters or default_opts.trigger_characters

	require("cmp").register_source(source_name, source)
end

return source
