---@see https://www.reddit.com/r/neovim/comments/y2by27/is_there_a_way_to_run_terminal_commands_with_lua/
local M = {}
local ERROR_MSG = "fail"

---Build bash curl request:
---```sh
---if ! curl "$href" --fail-early ; then echo ERROR_MSG ; fi
---```
---@see https://askubuntu.com/a/29596: run command and print on error.
---@param href string
---@return string
function M.curl_get_request(href)
	---Adding this because neovim is writings errors in curret the buffer.
	---@see https://github.com/neovim/neovim/issues/21376: possibly this issue.
	local hide_error = " 2> /dev/null"
	local shell_cmd = string.format('curl "%s" --fail-early', href)
	local cmd = string.format("if ! %s ; then echo %s ; fi %s", shell_cmd, ERROR_MSG, hide_error)
	return cmd
end

---@param possible_error_msg string
---@return boolean
function M.is_error_msg(possible_error_msg) return ERROR_MSG == possible_error_msg end

return M
