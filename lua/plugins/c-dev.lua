-- Minimal C setup for LazyVim
return {
  -- Ensure tools are installed via Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "clangd", -- LSP
        "clang-format", -- formatter
        -- "codelldb",    -- uncomment if you want debugging
      })
    end,
  },

  -- Treesitter for syntax/indent/highlight
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "c", "cpp", "make", "cmake" })
    end,
  },

  -- LSP config: clangd
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          -- keep it simple; add flags if you want (e.g., "--background-index")
          -- cmd = { "clangd", "--background-index", "--completion-style=detailed" },
        },
      },
    },
  },

  -- Formatting with conform.nvim (LazyVim default)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      format_on_save = function(bufnr)
        return { timeout_ms = 1000, lsp_fallback = true }
      end,
    },
  },

  -- Remove this whole block if you don't want DAP yet.
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      ensure_installed = { "codelldb" },
      handlers = {},
    },
    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)
      local dap = require("dap")
      -- Generic codelldb config that asks for the program path
      dap.configurations.c = {
        {
          name = "Launch (codelldb)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to program: ", vim.fn.getcwd() .. "/a.out", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.cpp = dap.configurations.c
    end,
  },
}
