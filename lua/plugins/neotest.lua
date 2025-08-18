return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  opt = {
    adapters = {
      "neotest-jest",
      jestCommand = "npm test --",
      env = { CI = true },
      jestConfigFile = "jest.config.ts",
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    },
  },
}
