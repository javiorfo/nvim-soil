-- #########################################################
-- # Maintainer:  Javier Orfo                              #
-- # URL:         https://github.com/javio7/nvim-modelizer #
-- #########################################################

if vim.g.modelizer then
  return
end

vim.g.modelizer = 1

vim.api.nvim_create_user_command('ModelizerRun', 'lua require("modelizer.core").run()', {})
