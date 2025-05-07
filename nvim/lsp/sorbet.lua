-- Sorbet is used by some (but not all) Ruby projects.
-- ONLY enable this if you are working on a project that uses Sorbet.
-- we determine this by checking for the presence of a Sorbet config file.
-- We expect Sorbet to be installed at the project level.
return {
  cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
  filetypes = { "ruby", "eruby", "erb" },
  root_markers = {
    "sorbet/config",
    ".git",
  },
}
