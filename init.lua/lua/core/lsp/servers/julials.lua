---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/julials.lua
local util = require('lspconfig.util')
local helper = require("core.utils.helper")

local cmd = {
  'julia',
  '--startup-file=no',
  '--history-file=no',
  '-e',
  [[
    # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig
    # with the regular load path as a fallback
    ls_install_path = joinpath(
        get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),
        "environments", "nvim-lspconfig"
    )
    pushfirst!(LOAD_PATH, ls_install_path)
    using LanguageServer
    popfirst!(LOAD_PATH)
    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
    project_path = let
        dirname(something(
            ## 1. Finds an explicitly set project (JULIA_PROJECT)
            Base.load_path_expand((
                p = get(ENV, "JULIA_PROJECT", nothing);
                p === nothing ? nothing : isempty(p) ? nothing : p
            )),
            ## 2. Look for a Project.toml file in the current working directory,
            ##    or parent directories, with $HOME as an upper boundary
            Base.current_project(),
            ## 3. First entry in the load path
            get(Base.load_path(), 1, nothing),
            ## 4. Fallback to default global environment,
            ##    this is more or less unreachable
            Base.load_path_expand("@v#.#"),
        ))
    end
    @info "Running language server" VERSION pwd() project_path depot_path
    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
    server.runlinter = true
    run(server)
  ]],
}

local M = {}
M.server_name = "julials"
M.setup = {
  cmd = cmd,
  filetypes = { 'julia' },
  root_dir = function(fname)
    return util.root_pattern('Project.toml')(fname) or helper.find_git_ancestor(fname)
  end,
  single_file_support = true,
  docs = {
    description = [[
https://github.com/julia-vscode/julia-vscode

LanguageServer.jl can be installed with `julia` and `Pkg`:
```sh
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
```
where `~/.julia/environments/nvim-lspconfig` is the location where
the default configuration expects LanguageServer.jl to be installed.

To update an existing install, use the following command:
```sh
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.update()'
```

Note: In order to have LanguageServer.jl pick up installed packages or dependencies in a
Julia project, you must make sure that the project is instantiated:
```sh
julia --project=/path/to/my/project -e 'using Pkg; Pkg.instantiate()'
```

## Generate project
- SEE: https://github.com/JuliaCI/PkgTemplates.jl

## Example:
- SEE: https://youtu.be/lZskxdMpYfE?si=acdRjl2aD5dHNZqo&t=8798
```sh
using PkgTemplates
t = Template(;dir = ".", julia = v"1.10", user="my_username", 
    plugins = [
        Git(; manifest=true, branch = "main"),
        Codecov(),
        GitHubActions(),
        !CompatHelper,
        !TagBot
    ]
)
```
### Plugins
- SEE: https://juliaci.github.io/PkgTemplates.jl/stable/user/
    ]],
  },
}

return M
