local M = {}

-- Disabling diagnostic here due to params import warnings.
---@diagnostic disable
---@type cmp
---@type luasnip
M.get_autocompletion_table = function(cmp, luasnip)
	---@diagnostic enable
	local function next_cmp_or_snippet(fallback)
		if cmp.visible() then
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		elseif luasnip.jumpable(1) then
			luasnip.jump(1)
		else
			fallback()
		end
	end
	local function previous_cmp_or_snippet(fallback)
		if cmp.visible() then
			cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end

	---Define a function that takes another function and a number as parameters
	---@param fn function: The function to be called repeatedly.
	---@param times integer: The number of times to call the function. Must be a positive integer.
	local function repeat_function(fn, times)
		local is_fn_a_function = type(fn) ~= "function"
		local is_times_a_positive = type(times) ~= "number" or times < 1

		if is_fn_a_function then
			vim.error("First argument must be a function")
		end
		if is_times_a_positive then
			vim.error("Second argument must be a positive integer")
		end

		-- Call the provided function `times` times
		for _ = 1, times do
			fn()
		end
	end

	local function move_up()
		cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
	end
	local function move_down()
		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	end

	local function scroll_up_5(fallback)
		if cmp.visible() then
			repeat_function(move_up, 5)
		else
			fallback()
		end
	end
	local function scroll_up_10(fallback)
		if cmp.visible() then
			repeat_function(move_up, 10)
		else
			fallback()
		end
	end
	local function scroll_up_15(fallback)
		if cmp.visible() then
			repeat_function(move_up, 15)
		else
			fallback()
		end
	end
	local function scroll_down_5(fallback)
		if cmp.visible() then
			repeat_function(move_down, 5)
		else
			fallback()
		end
	end
	local function scroll_down_10(fallback)
		if cmp.visible() then
			repeat_function(move_down, 10)
		else
			fallback()
		end
	end
	local function scroll_down_15(fallback)
		if cmp.visible() then
			repeat_function(move_down, 15)
		else
			fallback()
		end
	end

	local mapping_table = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping(next_cmp_or_snippet, { "i", "c" }),
		["<C-k>"] = cmp.mapping(previous_cmp_or_snippet, { "i", "c" }),
		["<A-j>"] = cmp.mapping(scroll_down_5, { "i", "c" }),
		["<A-d>"] = cmp.mapping(scroll_down_10, { "i", "c" }),
		["<C-d>"] = cmp.mapping(scroll_down_15, { "i", "c" }),
		["<A-k>"] = cmp.mapping(scroll_up_5, { "i", "c" }),
		["<A-u>"] = cmp.mapping(scroll_up_10, { "i", "c" }),
		["<C-u>"] = cmp.mapping(scroll_up_15, { "i", "c" }),
		-- @see: https://github.com/hrsh7th/nvim-cmp/issues/1074
		-- ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		-- @todo: add completion in normal mode
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
			}),
			{ "i", "c" }
		),
		["<TAB>"] = cmp.mapping(
			cmp.mapping.confirm({
				select = true, -- Select `true` pick the first option.
				behavior = cmp.ConfirmBehavior.Replace,
			}),
			{ "i", "c" }
		),
	})
	return mapping_table
end

return M
