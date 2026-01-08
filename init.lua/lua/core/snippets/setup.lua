local M = {}

function M.load_snippets()
    require("core.snippets.lua.lua").load_snippets()
    require("core.snippets.lua.css").load_snippets()
    require("core.snippets.lua.js_and_ts").load_snippets()
    require("core.snippets.lua.go").load_snippets()
    require("core.snippets.lua.html").load_snippets()
    require("core.snippets.lua.python").load_snippets()
    require("core.snippets.lua.markdown").load_snippets()
    require("core.snippets.lua.rust").load_snippets()
    require("core.snippets.lua.sh").load_snippets()
    require("core.snippets.lua.sql_postgres").load_snippets()
    require("core.snippets.lua.svelte").load_snippets()
end

return M
