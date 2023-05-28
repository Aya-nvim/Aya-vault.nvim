local api = vim.api

api.nvim_create_user_command("AyaTest", function (o)
  local aya_vault = require("aya-vault")
  aya_vault.index.get_aya_file(vim.fn.getcwd())
end, {})
