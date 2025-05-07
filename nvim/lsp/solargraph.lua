return {
  cmd = { "asdf", "exec", "solargraph", "stdio" },
  filetypes = { "ruby", "eruby", "erb" },
  root_markers = {
    "Gemfile",
    "Gemfile.lock",
    ".git",
  },
  init_options = {
    formatting = false, -- use ruby_lsp for formatting
  },
  settings = {
    solargraph = {
      diagnostics = false,
    },
  },
}
