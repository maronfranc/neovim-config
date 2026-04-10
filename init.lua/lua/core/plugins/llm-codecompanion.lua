---@see https://github.com/olimorris/codecompanion.nvim
local M = {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = require("core.keymap.plugins.codecompanion").keymaps,
	cmd = {
		"CodeCompanion",
		"CodeCompanionActions",
		"CodeCompanionChat",
		"CodeCompanionCmd",
	},
	config = function()
		local codecompanion = require("codecompanion")

		---Accept an ENV_VAR and create ollama adapter with configurable it.
		---Example:
		---1. Set `export ENV_VAR_CHAT="ollama_example:30b"` in bashrc.
		---2. Run with: `create_ollama_adapter("ENV_VAR_CHAT")`.
		local create_ollama_adapter = function(ENV_VAR)
			local llm_agent = os.getenv(ENV_VAR)
			local schema = nil
			if llm_agent ~= nil then schema = { model = { default = llm_agent } } end

			return require("codecompanion.adapters").extend("openai_compatible", {
				env = { url = "http://localhost:11434", api_key = "ollama" },
				schema = schema,
			})
		end

		codecompanion.setup({
			strategies = {
				-- NOTE: these are the names created in the adapter functions.
				chat = { adapter = "ollama_code" },
				inline = { adapter = "ollama_code" },
				agent = { adapter = "ollama_code" },
			},
			adapters = {
				http = {
					ollama_code = create_ollama_adapter("OLLAMA_CODE_AGENT"),
					-- ollama_default = create_ollama_adapter("OLLAMA_CHAT_AGENT"),
				},
			},
			-- The log_level is in `opts.opts`.
			opts = { opts = { log_level = "DEBUG" } }, -- `"DEBUG" | TRACE"`
		})

		---@see https://github.com/olimorris/codecompanion.nvim/discussions/2856
		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("user.codecompanion_notifier", { clear = true }),
			pattern = {
				"CodeCompanionChatDone",
				"CodeCompanionInlineFinished",
				"CodeCompanionToolApprovalRequested",
				"MCPHubApprovalWindowOpened",
			},
			callback = function(_)
        local bin = "notify-send"
				local title = "🤖 Codecompanion"
				local message = "✔️ Task complete."
				local expire_time_ms = 1500
        ---Command format: `notify-send "title" "Message" -t 1500 -u low`.
				local command = string.format('%s "%s" "%s" -t %d -u low', bin, title, message, expire_time_ms)
				vim.fn.jobstart(command)
			end,
		})
	end,
}

return M
