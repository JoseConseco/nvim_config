local codecompanion = {
  "olimorris/codecompanion.nvim",
  opts = {},
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim", -- extension (optional)
    "xinghe98/codecompanion-model-selector.nvim",
  },
  config = function ()
    require("codecompanion").setup({
      -- display = {
      --     diff = {
      --       provider = "mini_diff",
      --     },
      --   },
      strategies = {
        chat = {
          adapter = "llama.cpp",
        },
        inline = {
          adapter = "llama.cpp",
        },
        agent = {
          adapter = "llama.cpp",
        },
      },
      adapters = {
        http = {
          openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = os.getenv "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  -- Update this to your preferred default OpenRouter model ID
                  default = "qwen/qwen3.7-max",
                  choices = {
                    "qwen/qwen3.7-max",
                    "deepseek/deepseek-v4-flash",
                    "deepseek/deepseek-v4-pro",
                    -- Add more models as needed (check OpenRouter docs for IDs)
                  },
                },
              },
            })
          end,

          ["llama.cpp"] = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                -- url = "https://llama.xxx.com",
                url = "http://localhost:8012", -- Example local URL for llama.cpp serving
                -- api_key = os.getenv "LLAMA_API_KEY", -- Set LLAMA_API_KEY in your environment
                api_key = nil,
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  -- there's only one model loaded into llama-cpp which will be used
                  -- but codecompanion needs a default model set, otherwise it will send model list requests which will fail
                  default = "Qwen3.6-35B-A3B-IQ4_XS-3.97bpw",
                  choices = { "dummy" },
                },
              },
              handlers = {
                form_messages = function(self, messages)
                  local system_content = {}
                  local other_messages = {}
                  -- 1. Separate system messages from everything else
                  for _, msg in ipairs(messages) do
                    if msg.role == "system" then
                      table.insert(system_content, msg.content)
                    else
                      table.insert(other_messages, msg)
                    end
                  end
                  local final_messages = {}
                  -- 2. If there are system messages, merge them into ONE message at the top
                  if #system_content > 0 then
                    table.insert(final_messages, {
                      role = "system",
                      content = table.concat(system_content, "\n\n"),
                    })
                  end
                  -- 3. Append all the user/assistant messages
                  for _, msg in ipairs(other_messages) do
                    table.insert(final_messages, msg)
                  end
                  -- 4. Pass the cleaned messages to the standard OpenAI handler
                  local openai = require "codecompanion.adapters.http.openai"
                  return openai.handlers.form_messages(self, final_messages)
                end,
                parse_message_meta = function(self, data)
                  local extra = data.extra
                  if extra and extra.reasoning_content then
                    data.output.reasoning = { content = extra.reasoning_content }
                    if data.output.content == "" then
                      data.output.content = nil
                    end
                  end
                  return data
                end,
              },
            })
          end,

        },
      },
    })
  end
}

local M = {codecompanion}
return M
