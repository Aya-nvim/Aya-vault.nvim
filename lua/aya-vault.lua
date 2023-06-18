local index = require("aya-vault.index")
local cmp = require("aya-vault.cmp")

local vault = {
    index = index,
    setup = function()
        -- print("Start Load")
        cmp.setup()
    end,
}

return vault
