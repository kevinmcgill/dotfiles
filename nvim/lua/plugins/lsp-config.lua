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
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} },

      -- Schema information
      "b0o/SchemaStore.nvim",
    },
    config = function()
      -- local signs = {
      --   { name = "DiagnosticSignError", text = "" },
      --   { name = "DiagnosticSignWarn", text = "" },
      --   { name = "DiagnosticSignInfo", text = "" },
      --   { name = "DiagnosticSignHint", text = "" },
      -- }
      --
      -- for _, sign in ipairs(signs) do
      --   vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      -- end
      --
      -- local config = {
      --   virtual_text = {
      --     severity = {
      --       min = vim.diagnostic.severity.WARN,
      --     },
      --   },
      --   signs = {
      --     active = signs,
      --   },
      --   underline = {
      --     severity = {
      --       min = vim.diagnostic.severity.WARN,
      --     },
      --   },
      -- }
      --
      -- vim.diagnostic.config(config)

      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      --   border = "rounded",
      -- })
      --
      -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      --   border = "rounded",
      -- })

      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      --
      -- local lspconfig = require("lspconfig")
      --
      -- lspconfig.lua_ls.setup({
      --   capabilities = capabilities,
      -- })
      -- lspconfig.tsserver.setup({
      --   capabilities = capabilities,
      -- })
      -- lspconfig.eslint.setup({
      --   capabilities = capabilities,
      -- })
      -- lspconfig.ember.setup({
      --   capabilities = capabilities,
      -- })
      -- lspconfig.standardrb.setup({
      --   capabilities = capabilities,
      -- })
      -- temporary disable ruby lsp as rubocop diagnostics are appearing instead of standardrb.
      -- this happened after updating to neovim 0.10
      -- lspconfig.ruby_lsp.setup({
      --   capabilities = capabilities,
      -- })
      -- lspconfig.solargraph.setup({
      --   capabilities = capabilities,
      -- })
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      -- vim.keymap.set("n", "gl", vim.diagnostic.open_float)
      -- -- Use LspAttach autocommand to only map the following keys
      -- -- after the language server attaches to the current buffer
      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      --   callback = function(ev)
      --     -- Buffer local mappings.
      --     -- See `:help vim.lsp.*` for documentation on any of the below functions
      --     local opts = { buffer = ev.buf }
      --     vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      --     vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      --     vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      --   end,
      -- })
    end,
  },
}
