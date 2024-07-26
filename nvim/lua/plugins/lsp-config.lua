return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "eslint",
          "tsserver",
          "lua_ls",
          "jsonls",
          "yamlls",
        },
        automatic_installation = { exclude = { "ruby_lsp", "solargraph", "standardrb", "rubocop" } }, -- true, except for those listed
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} },
      -- Schema information
      "b0o/SchemaStore.nvim",
    },
    config = function()
      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      -- LSP configuration without Mason

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruby_lsp
      lspconfig.ruby_lsp.setup({
        -- Server-specific settings. See `:help lspconfig-setup`
        capabilities = capabilities,
        cmd = { "asdf", "exec", "ruby-lsp" },
        init_options = {
          formatter = "auto", -- or "standard" or "rubocop" or "auto"
        },
      })

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
      lspconfig.solargraph.setup({
        -- Server-specific settings. See `:help lspconfig-setup`
        capabilities = capabilities,
        cmd = { "asdf", "exec", "solargraph", "stdio" },
        init_options = {
          formatting = false, -- use ruby_lsp for formatting
        },
        settings = {
          solargraph = {
            diagnostics = false,
          },
        },
      })

      lspconfig.standardrb.setup({
        -- Server-specific settings. See `:help lspconfig-setup`
        capabilities = capabilities,
      })

      -- END of LSP configuration without Mason

      -- LSP configuration with Mason

      -- Setup and configure LSP servers installed via Mason. Ruby LSP servers are manually configured separately.
      local handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        -- Next, you can provide targeted overrides for specific servers.
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
        ["jsonls"] = function()
          lspconfig.jsonls.setup({
            capabilities = capabilities,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          })
        end,
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                -- https://luals.github.io/wiki/settings/
                diagnostics = { globals = { "vim" } },
                telemetry = { enable = false },
              },
            },
          })
        end,
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
        ["yamlls"] = function()
          lspconfig.yamlls.setup({
            capabilities = capabilities,
            settings = {
              yaml = {
                -- https://github.com/redhat-developer/yaml-language-server?tab=readme-ov-file#language-server-settings
                schemaStore = {
                  enable = false,
                  url = "",
                },
                schemas = require("schemastore").yaml.schemas(),
              },
            },
          })
        end,
      }

      -- now setup the custom handlers
      mason_lspconfig.setup_handlers(handlers)
    end,
  },
}
