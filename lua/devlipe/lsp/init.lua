local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    print("LSP not installed")
  return
end

require "devlipe.lsp.configs"
require("devlipe.lsp.handlers").setup()
-- require "devlipe.lsp.null-ls"
