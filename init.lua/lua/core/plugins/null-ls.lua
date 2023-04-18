local M = {
  "jose-elias-alvarez/null-ls.nvim",
	name = 'null-ls',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
	config = function()
		local null_ls = require('null-ls')
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		null_ls.setup({
			debug = true,
			sources = {
				-- formatters
				formatting.prettierd,
				formatting.stylua,
				formatting.autopep8,
				formatting.taplo,
				formatting.shfmt,
        formatting.goimports,
        formatting.gofumpt,
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
        formatting.prettier.with({
          extra_args = { "--single-quote", "false" },
        }),
        
				-- diagnostics
        diagnostics.eslint_d,
				diagnostics.luacheck,
				-- diagnostics.markdownlint,
				-- diagnostics.editorconfig_checker.with({
        --    command = 'editorconfig-checker' 
        -- }),
				-- diagnostics.cspell.with({
        --   filetypes = {
        --     'lua',
        --     'rust',
        --     'javascript',
        --     'typescript',
        --     'reactjavascript',
        --     'reacttypescript',
        --     'python',
        --   },

        --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        --   fallback_severity = vim.diagnostic.severity.HINT,
        --   severity = vim.diagnostic.severity.HINT,
				-- }),
			},
		})
	end,
}

return M
