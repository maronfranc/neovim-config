-- require'lsp-config'.server_name.settings
local M = {
	json = {
		schemas = {
			{
				fileMatch = { "package.json" },
				url = "https://json.schemastore.org/package.json",
			},
			{
				fileMatch = { "tsconfig.json", "tsconfig.*.json" },
				url = "http://json.schemastore.org/tsconfig",
			},
			{
				fileMatch = { ".eslintrc.json", ".eslintrc" },
				url = "http://json.schemastore.org/eslintrc",
			},
			{
				fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
				url = "http://json.schemastore.org/prettierrc",
			},
		},
	},
}
return M
