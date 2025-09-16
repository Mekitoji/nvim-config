return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          typescript = { preferences = { quoteStyle = "single" } },
          javascript = { preferences = { quoteStyle = "single" } },
        },
      },
    },
  },
}
