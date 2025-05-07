-- ESLint and Typescript LSPs are managed by "Mason-lspconfig" and "lspconfig". See `lsp-config.lua` for details.
-- Custom LSP configurations are defined in `/lsp/*.lua`
vim.lsp.enable({ "lua_ls", "ruby_lsp", "solargraph", "yamlls", "jsonls" })
if vim.fn.filereadable("sorbet/config") == 1 then
  vim.lsp.enable({ "sorbet" })
end
if vim.fn.filereadable(".standard.yml") == 1 then
  vim.lsp.enable({ "standardrb" })
end
if vim.fn.filereadable(".rubocop.yml") == 1 then
  vim.lsp.enable({ "rubocop" })
end
