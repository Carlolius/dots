------------------
-- Mason config --
------------------

-- Mason plugin retained but LSP handlers removed per user request
+local mason_status_ok, mason = pcall(require, "mason")
+if mason_status_ok then
+  mason.setup({
+    ui = {
+      icons = {
+        package_installed = "✓",
+        package_pending = "➜",
+        package_uninstalled = "✗"
+      }
+    }
+  })
+end
+
+-- Note: LSP-related setup removed. Re-add LSP handlers if you enable LSP later.
