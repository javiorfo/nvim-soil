-- #####################################################
-- # Maintainer: Javier Orfo                           #
-- # URL:        https://github.com/javiorfo/nvim-soil #
-- #####################################################

if vim.g.soil then
  return
end

vim.g.soil = 1

vim.api.nvim_create_user_command('Soil', 'lua require("soil.core").run()', {})
