local state = require("core.local-plugins.nvim-cmp-css.state")
local shell_helper = require("core.local-plugins.nvim-cmp-css.shell-helper")
---# Regex for css comment opening but not closing.
---(?:\/\*)(?!.*(?:\*\/))
---## Match:
---1. `/*` any text
---2. /**/ `/*`
---3. /* */ `/*`
---4. /* */ any text `/*`
---## Match none:
---1. /* /* any text */
---2. /* */
---3. /* any text  */
---4. /* */ /* */
---5. /* */ any text
-- local REGEX_CSS_COMMENT_OPEN  = "(?:%/%*)(?!.*(?:%*%/))"
local REGEX_CSS_COMMENT_OPEN = "(/%*) "
---(?!=(?:\/\*))(.*?)(?=(?:\*\/)(\s*\/\*.*)) -- Attempt to select in between /*/**/
-- "^(?:%/%*(?!%/%*.*%*%/)" -- ^(?:\/\*(?!\/\*.*\*\/))
local REGEX_CSS_COMMENT_CLOSE = "(%*/) "
local M = {}

function M:process_css_selectors()
	---Reseting and reprocessing values to clean deleted values.
	state:reset_ids()
	state:reset_classes()

	local css_file_names = self.get_current_html_file_links()
	for file_or_href, is_not_remote in pairs(css_file_names) do
		if is_not_remote then self:process_tags_of_local_file(file_or_href) end
		-- else fs_helper:process_tags_of_remote_file(file_or_href)
	end
end

---@param file_name string
function M:process_tags_of_local_file(file_name)
	local handle = io.open(file_name, "r") -- "rb"
	if handle == nil then return nil end

	local is_comment_open = false
	---@type string
	local value = handle:read("*l")

	while value do
		if not is_comment_open then
			local matched_open_comment = value:match(REGEX_CSS_COMMENT_OPEN) or ""
			is_comment_open = matched_open_comment ~= ""

			state:set_css_classes(value)
			state:set_css_ids(value)
		else
			local matched_close_comment = value:match(REGEX_CSS_COMMENT_CLOSE) or ""
			is_comment_open = matched_close_comment == ""
		end

		value = handle:read("*l")
	end

	handle:close()
end

---@param href string
function M:process_tags_of_remote_file(href)
	error("NOT IMPLEMENTED. Regex gmatch is not working and can't match minified files.")
	if true then return nil end

	if state.cached_hrefs[href] then return end

	local cmd = shell_helper.curl_get_request(href)
	local handle = io.popen(cmd, "r")
	if handle == nil then return end

	local value = handle:read("*l")
	if shell_helper.is_error_msg(value) then
		handle:close()
		return
	end

	local is_comment_open = false
	while value do
		if not is_comment_open then
			local matched_open_comment = value:match(REGEX_CSS_COMMENT_OPEN) or ""
			is_comment_open = matched_open_comment ~= ""

			state:set_cached_classes(value)
			state:set_cached_css_ids(value)
		else
			local matched_close_comment = value:match(REGEX_CSS_COMMENT_CLOSE) or ""
			is_comment_open = matched_close_comment == ""
		end

		value = handle:read("*l")
	end

	state.cached_hrefs[href] = true
	handle:close()
end

---Method is returning only not remote file paths.
---@return table
function M.get_current_html_file_links()
	local file_line_count = vim.api.nvim_buf_line_count(0)
	local file_content = vim.api.nvim_buf_get_lines(0, 0, file_line_count, false)
	--- @todo Implement this regex with lua string escape:
	--- - Regex: `(?:<link\s.*)href=(?:"|')(.+\.css)(?:"|')`
	--- - 1. positive lookbehind `<link`
	--- - 2. group between href="()"
	local REGEX_HTML_HREF = [[href=(.+%.css)]]

	---@type table
	local file_paths = {}
	for _, file_line in pairs(file_content) do
		---@type string
		local matched_link = string.match(file_line, REGEX_HTML_HREF) or ""
		if matched_link ~= "" then
			---@fixme Remove this when REGEX_HTML_HREF is fixed.
			matched_link = matched_link:gsub('"', ""):gsub("'", "")
			--- Regex: `^(?!http(?:s)?:\/\/)(?:\.?(?:\/.*)*)$`
			--- local REGEX_IS_RELATIVE = "(?!http(?:s)?:%/%/)(?:%.?(?:%/.*)*)"
			--- local matched_local_file_name = matched_link:match(REGEX_IS_RELATIVE) or ""
			--- @fixme Replace this when REGEX_IS_RELATIVE is fixed.
			local is_remote = matched_link:sub(1, #"http") == "http"
			file_paths[matched_link] = not is_remote
			-- local REGEX_IS_HREF_REMOTE = "^http(?:s)://.+"
			-- local matched_remote = matched_link:match(REGEX_IS_HREF_REMOTE) or ""
			-- if matched_remote ~= "" then end
		end
	end

	return file_paths
end

return M
