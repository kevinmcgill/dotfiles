return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>b", builtin.buffers, {})
      vim.keymap.set("n", "<leader>f", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>m", builtin.marks, {})
      vim.keymap.set("n", "<leader>p", builtin.find_files, {})
      vim.keymap.set("n", "<leader>s", builtin.current_buffer_fuzzy_find, {})
      vim.keymap.set("n", "<leader>q", builtin.quickfix, {})
      vim.keymap.set("n", "<leader>r", builtin.resume, {})
      vim.keymap.set("n", "<leader>w", builtin.grep_string, {})
      -- LSP specific mappings, replaces the quickfix
      vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
      vim.keymap.set("n", "gD", builtin.lsp_implementations, {})
      vim.keymap.set("n", "gr", builtin.lsp_references, {})

      local telescope_config = require("telescope.config")

      -- Clone the default Telescope configuration
      table.unpack = table.unpack or unpack -- 5.1 compatibility, nvim uses an older version of Lua internally
      local vimgrep_arguments = { table.unpack(telescope_config.values.vimgrep_arguments) }

      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      -- open multiple selected items in separate buffers (<TAB> to select, <CR> to open)
      local select_one_or_multi = function(prompt_bufnr)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if not vim.tbl_isempty(multi) then
          require("telescope.actions").close(prompt_bufnr)
          for _, j in pairs(multi) do
            if j.path ~= nil then
              vim.cmd(string.format("%s %s", "edit", j.path))
            end
            if j.path ~= nil then
              if j.lnum ~= nil then
                vim.cmd(string.format("%s +%s %s", "edit", j.lnum, j.path))
              else
                vim.cmd(string.format("%s %s", "edit", j.path))
              end
            end
          end
        else
          require("telescope.actions").select_default(prompt_bufnr)
        end
      end

      local setup = require("telescope").setup
      setup({
        defaults = {
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = vimgrep_arguments,
          mappings = {
            i = {
              ["<CR>"] = select_one_or_multi,
            },
            n = {
              ["<CR>"] = select_one_or_multi,
            },
          },
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = require("telescope.actions").delete_buffer,
              },
              n = {
                ["<c-d>"] = require("telescope.actions").delete_buffer,
              },
            },
            theme = "ivy",
          },
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            theme = "ivy",
          },
          live_grep = {
            theme = "ivy",
          },
          marks = {
            theme = "ivy",
          },
          current_buffer_fuzzy_find = {
            theme = "ivy",
          },
          quickfix = {
            theme = "ivy",
          },
          grep_string = {
            theme = "ivy",
          },
          lsp_definitions = {
            theme = "ivy",
          },
          lsp_implementations = {
            theme = "ivy",
          },
          lsp_references = {
            theme = "ivy",
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "danielpieper/telescope-tmuxinator.nvim",
    config = function()
      vim.keymap.set("n", "<leader>tx", function()
        require("telescope").extensions.tmuxinator.projects(require("telescope.themes").get_dropdown({}))
      end, {})
      require("telescope").load_extension("tmuxinator")
    end,
  },
}
