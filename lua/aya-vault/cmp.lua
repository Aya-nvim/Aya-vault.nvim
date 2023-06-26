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

function source:get_trigger_characters()
    return { "[" }
end

function source:get_keyword_pattern()
    return [=[\%(\s\|^\|#\)\zs\[\{2}[^\]]\+\]\{,2}]=]
end

function source:complete(_, callback)
    local items = {}

    local files = index.get_aya_file(vim.fn.getcwd())
    print(vim.inspect(files))
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
