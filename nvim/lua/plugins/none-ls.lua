return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
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
