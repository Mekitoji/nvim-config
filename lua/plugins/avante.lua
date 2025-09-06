return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  -- @module 'avante'
  -- @type avante.Config
  opts = {
    -- add any opts here
    mode = "agentic",

    provider = "openai",
    providers = {
      openai = {
        model = "gpt-5",
        api_key_name = "AVANTE_OPENAI_API_KEY",
        extra_request_body = { temperature = 1, max_completion_tokens = 4096 },
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          max_completion_tokens = 20480,
        },
        api_key_name = "AVANTE_ANTHROPIC_API_KEY",
      },
      ollama = {
        endpoint = "http://127.0.0.1:11434",
        model = "deepseek-r1:8b",
      },
      -- groq = {
      --   __inherited_from = "openai",
      --   api_key_name = "GROQ_API_KEY",
      --   endpoint = "https://api.groq.com/openai/v1/",
      --   model = "llama-3.1-70b-versatile",
      -- },
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "AVANTE_DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-coder",
      },
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/openai",
        -- Если используешь OpenAI-compatible шим к Gemini; иначе можно не указывать
        model = "gemini-2.0-flash-thinking-exp",
        api_key_name = "AVANTE_GEMINI_API_KEY",
        __inherited_from = "openai",
      },
      moonshot = {
        endpoint = "https://api.moonshot.ai/v1",
        model = "kimi-k2-0711-preview",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          max_tokens = 32768,
        },
      },
    },
    web_search_engine = {
      provider = "google", -- tavily | serpapi | google | kagi | brave | searxng
      proxy = nil,
    },
    rag_service = {
      enabled = false,
      host_mount = os.getenv("HOME"),
      runner = "docker",
      llm = {
        provider = "openai",
        endpoint = "https://api.openai.com/v1",
        api_key = "AVANTE_OPENAI_API_KEY",
        model = "gpt-5",
      },
      embed = {
        provider = "openai",
        endpoint = "https://api.openai.com/v1",
        api_key = "AVANTE_OPENAI_API_KEY",
        model = "text-embedding-3-large",
      },
      docker_extra_args = "",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
