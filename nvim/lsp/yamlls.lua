return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.dockerfile" },
  root_markers = {
    ".git",
  },
  settings = {
    yaml = {
      -- https://github.com/redhat-developer/yaml-language-server?tab=readme-ov-file#language-server-settings
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
}
