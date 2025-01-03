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
          "ts_ls",
          "lua_ls",
          "jsonls",
          "yamlls",
        },
        automatic_installation = { exclude = { "ruby_lsp", "sorbet", "solargraph", "standardrb", "rubocop" } }, -- true, except for those listed
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

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ruby_lsp
      lspconfig.ruby_lsp.setup({
        -- Server-specific settings. See `:help lspconfig-setup`
        capabilities = capabilities,
        cmd = { "asdf", "exec", "ruby-lsp" },
        init_options = {
          formatter = "auto", -- or "standard" or "rubocop" or "auto"
        },
      })

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#sorbet
      -- Sorbet is used by some (but not all) Ruby projects.
      -- ONLY enable this if you are working on a project that uses Sorbet.
      -- we determine this by checking for the presence of a Sorbet config file.
      -- We expect Sorbet to be installed at the project level.
      if vim.fn.filereadable("sorbet/config") == 1 then
        lspconfig.sorbet.setup({
          -- Server-specific settings. See `:help lspconfig-setup`
          capabilities = capabilities,
          cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
          -- init_options = {
          --   highlightUntyped = true,
          -- },
        })
      end

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#solargraph
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

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#standardrb
      -- Standardrb is used by some (but not all) Ruby projects.
      -- ONLY enable this if you are working on a project that uses Standardrb.
      -- we determine this by checking for the presence of a standardrb config file.
      -- We expect Standardrb to be installed at the project level.
      if vim.fn.filereadable(".standard.yml") == 1 then
        lspconfig.standardrb.setup({
          -- Server-specific settings. See `:help lspconfig-setup`
          capabilities = capabilities,
        })
      end

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#rubocop
      -- Rubocop is used by some (but not all) Ruby projects.
      -- ONLY enable this if you are working on a project that uses Rubocop.
      -- we determine this by checking for the presence of a rubocop config file.
      -- We expect Rubocop to be installed at the project level.
      if vim.fn.filereadable(".rubocop.yml") == 1 then
        lspconfig.rubocop.setup({
          -- Server-specific settings. See `:help lspconfig-setup`
          capabilities = capabilities,
        })
      end

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
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls
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
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
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
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#yamlls
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

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })
    end,
  },
}
