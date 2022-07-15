-- local copilot_status_ok,copilot  = pcall(require, "copilot")
-- if not copilot_status_ok then
--     return
-- end

-- GitHub copilot to remap tab key
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

vim.cmd('imap <silent><script><expr> <C-y> copilot#Accept("<CR>")')
-- local opts = { noremap = false, expr = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap 
-- copilot.setup{ }
