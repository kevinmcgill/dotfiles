-- Standardrb is used by some (but not all) Ruby projects.
-- ONLY enable this if you are working on a project that uses Standardrb.
-- we determine this by checking for the presence of a standardrb config file.
-- We expect Standardrb to be installed at the project level.
return {
  cmd = { "standardrb", "lsp" },
  filetypes = { "ruby", "eruby", "erb" },
  root_markers = {
    ".standard.yml",
    ".git",
  },
}
