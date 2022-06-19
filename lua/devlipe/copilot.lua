-- local copilot_status_ok, _  = pcall(require, "copilot.vim")
-- if not copilot_status_ok then
--     print("copilot.vim not found")
--     return
-- end
--

-- GitHub copilot to remap tab key
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""


local opts = { expr = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("i", "<Right>", "copilot#Accept(“<CR>”)", opts)
