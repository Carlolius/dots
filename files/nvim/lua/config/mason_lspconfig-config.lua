-- Mason-lspconfig loader retained but LSP handlers removed per user request
+local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
+if not ok then return end
+
+-- Keep ensure_installed minimally useful tools (formatters/linters) but do not configure LSP servers
+mason_lspconfig.setup({
+  ensure_installed = {
+    -- keep common formatters/linters if desired; left empty by default
+  },
+})
+
+-- Note: LSP server setup handlers were removed; re-add when enabling LSP.
