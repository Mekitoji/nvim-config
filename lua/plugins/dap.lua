return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },

    config = function()
      local dap, dapui = require("dap"), require("dapui")

      -------------------------------------------------------------------
      -- 1. Адаптер pwa-node через Mason-установленный js-debug
      -------------------------------------------------------------------
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { mason_path, "${port}" },
        },
      }

      -------------------------------------------------------------------
      -- 2. Один набор конфигов → назначаем нескольким filetype’ам
      -------------------------------------------------------------------
      local node_configs = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Jest (current file)",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/.bin/jest",
            "${fileBasenameNoExtension}",
            "--runInBand",
          },
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach (pick process)",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Nest Launch (ts-node)",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
          runtimeArgs = {
            "-r",
            "ts-node/register",
            "${workspaceFolder}/src/main.ts",
          },
          sourceMaps = true,
          protocol = "inspector",
          skipFiles = { "<node_internals>/**" },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Nest Attach :9229",
          port = 9229,
          restart = true,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Nest Jest (current file)",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/.bin/jest",
            "${fileBasenameNoExtension}",
            "--runInBand",
          },
          console = "integratedTerminal",
        },
      }

      for _, ft in ipairs({
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
      }) do
        dap.configurations[ft] = node_configs
      end

      dapui.setup()
      dap.listeners.after.event_initialized["dapui_open"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_close"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_close"] = function()
        dapui.close()
      end
    end,
  },
}
