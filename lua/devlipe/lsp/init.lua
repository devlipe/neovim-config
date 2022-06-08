local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "devlipe.lsp.configs"
require("devlipe.lsp.handlers").setup()
-- require "devlipe.lsp.null-ls"
