-- OneDark
vim.g.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.g.onedark_hide_endofbuffer = 1
vim.g.onedark_terminal_italics = 1

-- TokyoNight
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_keywords= 1
vim.g.tokyonight_italic_comments= 1
vim.g.tokyonight_lualine_bold= 1




vim.cmd [[
try
  colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
