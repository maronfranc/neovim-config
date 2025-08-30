local M = {}

function M.load_snippets()
    require("core.plugins.snippets.lua.lua").load_snippets()
    require("core.plugins.snippets.lua.css").load_snippets()
    require("core.plugins.snippets.lua.js_and_ts").load_snippets()
    require("core.plugins.snippets.lua.go").load_snippets()
    require("core.plugins.snippets.lua.html").load_snippets()
    require("core.plugins.snippets.lua.python").load_snippets()
    require("core.plugins.snippets.lua.markdown").load_snippets()
    require("core.plugins.snippets.lua.rust").load_snippets()
    require("core.plugins.snippets.lua.sh").load_snippets()
    require("core.plugins.snippets.lua.sql_postgres").load_snippets()
    require("core.plugins.snippets.lua.svelte").load_snippets()
end

return M
