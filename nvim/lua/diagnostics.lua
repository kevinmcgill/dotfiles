local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
  { name = "DiagnosticSignHint", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.WARN
    },
  },
  signs = {
    active = signs,
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
