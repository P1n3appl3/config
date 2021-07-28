vim.opt.termguicolors = true
vim.cmd([[ colorscheme gruvbox ]])
vim.g.gruvbox_contrast_dark = "hard"
-- require("lualine").setup({ options = { theme = "gruvbox_material" } })
-- require("hardline").setup({})
-- require("feline").setup({})
require("colorizer").setup()
vim.g.bufferline = { closable = false, icons = false }
