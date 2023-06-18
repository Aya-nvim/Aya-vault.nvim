local index = {}

function index.get_aya_file(path)
    local path_len = string.len(vim.fs.normalize(path))
    local ayas = vim.fs.find(function(name, _)
        return name:match(".*md$")
    end, { path = path, type = "file", limit = math.huge })
    for idx, aya in ipairs(ayas) do
        ayas[idx] = string.sub(aya, path_len + 2)
    end
    return ayas
end

return index
