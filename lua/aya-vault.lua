local index = require("index")
local cmp = require("cmp")

local vault = {
    index = index,
    setup = function()
        -- print("Start Load")
        cmp.setup()
    end,
}

return vault
