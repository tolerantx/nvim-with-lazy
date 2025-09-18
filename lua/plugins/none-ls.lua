-- return {
--   {
--     "nvimtools/none-ls.nvim",
--     dependencies = {
--       "nvimtools/none-ls-extras.nvim",
--     },
--     config = function()
--       local null_ls = require("null-ls")
--
--       null_ls.setup({
--         debug = true,
--         sources = {
--           null_ls.builtins.formatting.stylua,
--           null_ls.builtins.formatting.prettier,
--           null_ls.builtins.diagnostics.stylelint,
--           null_ls.builtins.diagnostics.rubocop.with({
--             command = "bundle",
--             args = {
--               "exec", "rubocop", "--stdin", "$FILENAME", "--format", "json", "--force-exclusion",
--             },
--           }),
--           null_ls.builtins.formatting.rubocop,
--           null_ls.builtins.formatting.black,
--           null_ls.builtins.diagnostics.pylint.with({
--             command = "pylint",
--           })
--         },
--       })
--
--       vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
--     end,
--   },
--   {
--     "jay-babu/mason-null-ls.nvim",
--     config = function()
--       require("mason-null-ls").setup({
--         ensure_installed = { "pylint", "black", "prettier", "stylelint" },
--       })
--     end,
--   }
-- }
return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local u = require("null-ls.utils")

      -- Host path -> container path (/rails/…)
      local function to_container_path(host_path)
        local root = (u.root_pattern("Gemfile", ".git")(host_path)) or vim.fn.getcwd()
        local rel = host_path:gsub("^" .. vim.pesc(root .. "/"), "")
        return "/rails/" .. rel
      end

      null_ls.setup({
        debug = true,
        sources = {
          -- your existing sources
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.stylelint,

          -- RuboCop diagnostics (container)
          null_ls.builtins.diagnostics.rubocop.with({
            command = "docker",
            args = function(params)
              local cpath = to_container_path(params.bufname)
              return {
                "compose", "exec", "-T", "web",
                "bundle", "exec", "rubocop",
                "--force-exclusion",
                "--format", "json",
                "--no-color",
                "--stdin", cpath,
              }
            end,
            from_stdin = true,
            timeout = 15000,
          }),

          -- RuboCop formatting (container)
          null_ls.builtins.formatting.rubocop.with({
            command = "docker",
            args = function(params)
              local cpath = to_container_path(params.bufname)
              return {
                "compose", "exec", "-T", "web", "bash", "-lc",
                "bundle exec rubocop -A --stdin "
                .. vim.fn.shellescape(cpath)
                .. " --force-exclusion --no-color --fail-level fatal"
                .. " | awk 'printed{print} /^=+$/{printed=1; next}'"
              }
            end,
            to_stdin = true,
            timeout = 15000,
          }),
          null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.pylint.with({
            command = "pylint",
          }),
        },
      })

      -- vim.keymap.set("n", "<leader>gf", function()
      --   vim.lsp.buf.format({ async = false })
      -- end, { desc = "Format buffer" })
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "pylint", "black", "prettier", "stylelint" },
      })
    end,
  },
}
