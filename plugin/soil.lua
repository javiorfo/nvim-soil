-- ######################################################
-- # Maintainer: Mr. Charkuils                          #
-- # URL:        https://github.com/charkuils/nvim-soil #
-- ######################################################

if vim.g.soil then
  return
end

vim.g.soil = 1

vim.api.nvim_create_user_command('Soil', 'lua require("soil.core").run()', {})
