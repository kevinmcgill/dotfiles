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
      -- Skip the neo-tree buffer. If null-ls attaches, each tree redraw runs
      -- codespell again. Neo-tree sets filetype before buftype=nofile, so the
      -- default buftype check does not catch it. Also skip the directory buffer
      -- that `nvim .` opens.
      should_attach = function(bufnr)
        return vim.bo[bufnr].filetype ~= "neo-tree"
          and vim.fn.isdirectory(vim.api.nvim_buf_get_name(bufnr)) == 0
      end,
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
