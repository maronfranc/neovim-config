---@class State
---@field public cached_hrefs table List of cached remote hrefs.
---@field private ids table List of local files ids.
---@field private classes table List of local files classes.
---@field private cached_ids table List of remote ids.
---@field private cached_classes table List of remote classes.
local M = {
  cached_hrefs   = {},
  cached_classes = {},
  cached_ids     = {},
  classes        = {},
  ids            = {},
}
local CMP_VARIABLE_KIND = 6
local CMP_CONSTANT_KIND = 21
---@todo improve regex to match nested values.
local REGEX_CSS_CLASS = "%.([a-za-z][a-za-z-0-9%-%_]+)"
local REGEX_CSS_ID = "%#([a-za-z][a-za-z-0-9]+)"

function M:reset_classes() self.classes = {} end

function M:reset_ids() self.ids = {} end

---@param possible_class_selector string
function M:set_css_classes(possible_class_selector)
  local matched_class = possible_class_selector:match(REGEX_CSS_CLASS) or ""
  if matched_class ~= "" then
    ---@type lsp.CompletionItem
    local cmp_item = {
      label    = matched_class,
      kind     = CMP_VARIABLE_KIND,
      sortText = "css-class",
    }
    self.classes[matched_class] = cmp_item
  end
end

---@param possible_class_selector string
function M:set_cached_classes(possible_class_selector)
  local matched_class = possible_class_selector:match(REGEX_CSS_CLASS) or ""
  if matched_class ~= "" then
    ---@type lsp.CompletionItem
    local cmp_item = {
      label    = matched_class,
      kind     = CMP_CONSTANT_KIND,
      sortText = "css-class",
    }
    self.cached_classes[matched_class] = cmp_item
  end
end

---@param possible_id_selector string
function M:set_css_ids(possible_id_selector)
  local matched_id = possible_id_selector:match(REGEX_CSS_ID) or ""
  if matched_id ~= "" then
    ---@type lsp.CompletionItem
    local cmp_item = {
      label    = matched_id,
      kind     = CMP_VARIABLE_KIND,
      sortText = "css-id",
    }
    self.ids[matched_id] = cmp_item
  end
end

---@param possible_id_selector string
function M:set_cached_css_ids(possible_id_selector)
  local matched_id = possible_id_selector:match(REGEX_CSS_ID) or ""
  if matched_id ~= "" then
    ---@type lsp.CompletionItem
    local cmp_item = {
      label    = matched_id,
      kind     = CMP_CONSTANT_KIND,
      sortText = "css-id",
    }
    self.cached_ids[matched_id] = cmp_item
  end
end

---@return lsp.CompletionItem
function M:get_css_classes()
  local cmp_items = {}
  for _, cmp_item in pairs(self.cached_classes) do
    table.insert(cmp_items, cmp_item)
  end
  for _, cmp_item in pairs(self.classes) do
    table.insert(cmp_items, cmp_item)
  end
  return cmp_items
end

---@return lsp.CompletionItem
function M:get_css_ids()
  local cmp_items = {}
  for _, cmp_item in pairs(self.cached_ids) do
    table.insert(cmp_items, cmp_item)
  end
  for _, cmp_item in pairs(self.ids) do
    table.insert(cmp_items, cmp_item)
  end
  return cmp_items
end

function M:get_css_selectors(params)
  local CMP_TRIGGER_CONTEXT = 2
  local is_trigger = params.completion_context.triggerKind == CMP_TRIGGER_CONTEXT
  if is_trigger then
    local is_class = params.completion_context.triggerCharacter == "."
    if is_class then return self:get_css_classes() end

    local is_id = params.completion_context.triggerCharacter == "#"
    if is_id then return self:get_css_ids() end
  end

  local REGEX_HTML_OPEN_CLASS = 'class%s*=%s*"'
  local REGEX_HTML_OPEN_ID = 'id%s*=%s*"'
  local is_after_class_quote = string.match(
    params.context.cursor_before_line,
    REGEX_HTML_OPEN_CLASS) ~= nil
  if is_after_class_quote then return self:get_css_classes() end

  local is_after_id_quote = string.match(
    params.context.cursor_before_line,
    REGEX_HTML_OPEN_ID) ~= nil
  if is_after_id_quote then return self:get_css_ids() end

  return {}
end

return M
