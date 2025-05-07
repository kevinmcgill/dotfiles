return {
  cmd = { "asdf", "exec", "ruby-lsp" },
  filetypes = { "ruby", "eruby", "erb" },
  init_options = {
    formatter = "auto", -- or "standard" or "rubocop" or "auto"
  },
  root_markers = {
    "Gemfile",
    "Gemfile.lock",
    ".git",
  },
}
