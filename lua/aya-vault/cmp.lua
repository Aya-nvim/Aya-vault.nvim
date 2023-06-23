local has_cmp, cmp = pcall(require, "cmp")
local index = require("aya-vault.index")

if not has_cmp then
    vim.notify("nvim-cmp not found!", vim.log.levels.ERROR)
    return
end

local source = {}

source.new = function()
    return setmetatable({}, { __index = source })
end

source.complete = function(self, request, callback)
    local items = {}
    local prefix = string.sub(request.context.cursor_before_line, 1, request.offset - 1)

    local files = index.get_aya_file(vim.fn.getcwd())
    if vim.endswith(prefix, "[[") then
        for _, file in ipairs(files) do
            table.insert(items, {
                filterText = "[[" .. file,
                label = file,
                kind = cmp.lsp.CompletionItemKind.File,
            })
        end
        callback({
            items = items,
            isIncomplete = true,
        })
    else
        callback({
            isIncomplete = true,
        })
    end
end

return {
    setup = function()
        cmp.register_source("aya-vault", source.new())
        cmp.setup.filetype("markdown", {
            sources = cmp.config.sources({
                { name = "aya-vault" },
            }),
        })
    end,
}
