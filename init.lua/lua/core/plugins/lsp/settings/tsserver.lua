-- TypeScript
-- Don't forget to install typescript language server itself:
-- npm i -g typescript-language-server 
local opts = {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}

return opts