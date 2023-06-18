print("SADjio")
local has_cmp, cmp = pcall(require, "cmp")

-- if not has_cmp then
--     vim.notify("nvim-cmp not found!", vim.log.levels.ERROR)
--     return
-- end

local source = {}

source.new = function()
    return setmetatable({}, { __index = source })
end

source.get_trigger_characters = function()
    return { "[" }
end

source.complete = function(self, request, callback)
    local items = {}
    local input = string.sub(request.context.cursor_before_line, request.offset - 1)
    local prefix = string.sub(request.context.cursor_before_line, 1, request.offset - 1)
    print(input)
    print(prefix)
    local handle = "abc"
    local name_and_email = "def"
    table.insert(items, {
        filterText = handle .. " " .. name_and_email,
        label = name_and_email,
        textEdit = {
            newText = name_and_email,
            range = {
                start = {
                    line = request.context.cursor.row - 1,
                    character = request.context.cursor.col - 1 - #input,
                },
                ["end"] = {
                    line = request.context.cursor.row - 1,
                    character = request.context.cursor.col - 1,
                },
            },
        },
    })
    callback({
        items = items,
        isIncomplete = true,
    })
end

return {
    setup = function()
        print("Setup cmp")
        cmp.register_source("aya-vault", source.new())
        cmp.setup.filetype("markdown", {
            sources = cmp.config.sources({
                { name = "aya-vault" },
            }),
        })
    end,
}
