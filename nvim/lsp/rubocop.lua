-- Rubocop is used by some (but not all) Ruby projects.
-- ONLY enable this if you are working on a project that uses Rubocop.
-- we determine this by checking for the presence of a rubocop config file.
-- We expect Rubocop to be installed at the project level.
return {
  cmd = { "bundle", "exec", "rubocop", "--lsp" },
  filetypes = { "ruby", "eruby", "erb" },
  root_markers = {
    ".rubocop.yml",
    ".git",
  },
}
