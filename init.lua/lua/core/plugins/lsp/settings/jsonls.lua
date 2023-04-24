local opts = {
  format = { enabled = false },
  schemas = {
    {
      description = "ESLint config",
      fileMatch = { ".eslintrc.json", ".eslintrc" },
      url = "http://json.schemastore.org/eslintrc",
    },
    {
      description = "Package config",
      fileMatch = { "package.json" },
      url = "https://json.schemastore.org/package",
    },
    {
      description = "Packer config",
      fileMatch = { "packer.json" },
      url = "https://json.schemastore.org/packer",
    },
    {
      description = "Renovate config",
      fileMatch = {
        "renovate.json",
        "renovate.json5",
        ".github/renovate.json",
        ".github/renovate.json5",
        ".renovaterc",
        ".renovaterc.json",
      },
      url = "https://docs.renovatebot.com/renovate-schema",
    },
    {
      description = "NPM configuration file",
      fileMatch = { "package.json" },
      url = "https://json.schemastore.org/package.json",
    },
  },
}

return opts
