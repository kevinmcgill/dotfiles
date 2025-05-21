local config = {
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'hl-DiagnosticError',
      [vim.diagnostic.severity.WARN] = 'hl-DiagnosticWarn',
      [vim.diagnostic.severity.INFO] = 'hl-DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'hl-DiagnosticHint',
    },
  },
  underline = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
  float = {
    source = "always",
    border = "rounded",
  },
}

vim.diagnostic.config(config)
