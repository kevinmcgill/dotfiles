-- Use Mason-lspconfig to install and configure ESLint and TypeScript LSPs.
-- Custom LSP configurations are defined in `/lsp/*.lua` and enabled in `lsp.lua`.
-- The risk is the the LSP configurations defined in `lsp/*.lua` will not be kept
-- upto date with the latest changes in the nvim-lspconfig repository.
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "eslint",
          "ts_ls",
        },
        automatic_enable = { "eslint", "ts_ls" }
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} },
      -- Schema information, used for JSON and YAML LSPs configured in `lsp/*.lua`
      "b0o/SchemaStore.nvim",
    },
    config = function()
      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Add capabilities for all LSP clients
      vim.lsp.config('*', {
        capabilities = default_capabilities,
      })
    end,
  },
}
