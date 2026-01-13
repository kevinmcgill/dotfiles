return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    -- Pass the same capabilities to null-ls so its client matches others:
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.general = capabilities.general or {}
    capabilities.general.positionEncodings = { "utf-16" }
    capabilities.offsetEncoding = { "utf-16" }
    null_ls.setup({
      capabilities = capabilities,
      sources = {
        diagnostics.codespell,
        formatting.codespell,
        formatting.stylua,

        -- setting prettier only if we have a ".prettierrc.js" file in the project
        formatting.prettier.with({
          condition = function(utils)
            return utils.root_has_file({ ".prettierrc.js" })
          end,
        }),
      },
    })
  end,
}
