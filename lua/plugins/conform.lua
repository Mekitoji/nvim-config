return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      typescript = { "biome", "prettierd", "prettier" },
      typescriptreact = { "biome", "prettierd", "prettier" },
      javascript = { "biome", "prettierd", "prettier" },
      javascriptreact = { "biome", "prettierd", "prettier" },
    },
    formatters = {
      biome = {
        condition = function(ctx)
          return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.root, upward = true })[1] ~= nil
        end,
      },
    },
  },
}
