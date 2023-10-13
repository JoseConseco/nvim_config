local llm = require "llm"
local llamacpp = require "llm.providers.llamacpp"
local extract = require('llm.prompts.extract')
-- best model so far: codellama-13b-instruct.Q5_K_S.gguf
-- https://huggingface.co/TheBloke/CodeLlama-13B-Instruct-GGUF

require("llm").setup {
  hl_group = "Substitute",
  -- prompts = util.module.autoload "prompt_library",
  default_prompt = llamacpp.default_prompt,

  prompts = {
    ask = {
      provider = llamacpp,
      params = { temperature = 0.7, },
      mode = llm.mode.INSERT,
      builder = function(input)

        return function(build)
          vim.ui.input(
            { prompt = 'Instruction: ' },
            function(user_input)
              if user_input == nil then return end

              local final_prompt = ''
              if #user_input > 0 then

                -- [===[<s>[INST]<<SYS>>\nWrite code to solve the following coding problem. Please wrap your code answer using ```. Output only the code.\n<</SYS>>.]==]

                final_prompt =
  " <s>[INST]<<SYS>>Write code to solve the following coding problem that obeys the constraints and passes the example test cases. Please wrap your code answer using ```.<<SYS>>"
  .. user_input .. "\n[/INST]\n"

              else
                return
              end

              build({
                prompt = final_prompt
              })
            end)
        end
      end,
      transform = extract.markdown_code,
    },

    general = {
      provider = llamacpp,
      params = { temperature = 0.7, },
      mode = llm.mode.APPEND,
      -- builder = function(input)
      --   return function(build)
      --     vim.ui.input(
      --       { prompt = 'Instruction: ' },
      --       function(user_input)
      --         if user_input == nil then return end
      --
      --         local final_prompt = ''
      --         if #user_input > 0 then
      --           final_prompt = M.llama_2_general_prompt({system = user_input, user='', message = input})
      --         else
      --           return
      --         end
      --
      --         vim.print(final_prompt)
      --         build({
      --           prompt = final_prompt
      --         })
      --       end)
      --   end
      -- end,

      builder = function(input)
        return function(build)
          vim.ui.input(
            { prompt = 'Action to perform on code: ' },
            function(user_input)
              if user_input == nil then return end

              local final_prompt = ''
              if #user_input > 0 then

                final_prompt =
[===[ User: ]===] .. user_input .. "\n'''python" .. input .. [===[\n'''\n Assistant: ]===]

              else
                return
              end

              print(final_prompt)
              build({
                prompt = final_prompt
              })
            end)
        end
      end,

      transform = extract.markdown_code,
    },

    modify = {
      provider = llamacpp,
      params = { temperature = 0.4, },

      options = {
        temperature = 0.5,     -- Adjust the randomness of the generated text (default: 0.8).
        repeat_penalty = 1.0,  -- Control the repetition of token sequences in the generated text (default: 1.1)
        seed = -1,             -- Set the random number generator (RNG) seed (default: -1, -1 = random seed)
      },

      mode = llm.mode.INSERT_OR_REPLACE,
      -- mode = llm.mode.BUFFER,
      builder = function(input)
        return function(build)
          vim.ui.input(
            { prompt = 'Action to perform on code: ' },
            function(user_input)
              if user_input == nil then return end

              local final_prompt = ''
              if #user_input > 0 then

                final_prompt =
[===[ <s>[INST]<<SYS>>\nHelp USER by updating his code wrapped inside [CODE] tag.\nUSER:]===] .. user_input .. "\n[CODE]\n" .. input .. "\n[/CODE]\n [/INST]"

              else
                return
              end

              print(final_prompt)
              build({
                prompt = final_prompt
              })
            end)
        end
      end,
      transform = extract.markdown_code,
    },




    mistral = {
      provider = llamacpp,
      params = { temperature = 0.4, },

      options = {
        temperature = 0.5,     -- Adjust the randomness of the generated text (default: 0.8).
        repeat_penalty = 1.0,  -- Control the repetition of token sequences in the generated text (default: 1.1)
        seed = -1,             -- Set the random number generator (RNG) seed (default: -1, -1 = random seed)
      },

      mode = llm.mode.INSERT_OR_REPLACE,
      -- mode = llm.mode.BUFFER,
      builder = function(input)
        return function(build)
          vim.ui.input(
            { prompt = 'Action to perform on code: ' },
            function(user_input)
              if user_input == nil then return end

              local final_prompt = ''
              if #user_input > 0 then

                final_prompt =
"<s>[INST]\nHelp to fix python code wrapped inside [CODE] tag.\n" .. user_input .. "\n[CODE]\n" .. input .. "\n[/CODE]\n [/INST] "

              else
                return
              end

              print(final_prompt)
              build({
                prompt = final_prompt
              })
            end)
        end
      end,
      transform = extract.markdown_code,
    },


    wizard = {
      provider = llamacpp,
      params = { temperature = 0.4, },

      options = {
        temperature = 0.2,     -- Adjust the randomness of the generated text (default: 0.8).
        repeat_penalty = 1.0,  -- Control the repetition of token sequences in the generated text (default: 1.1)
        seed = -1,             -- Set the random number generator (RNG) seed (default: -1, -1 = random seed)
      },

      mode = llm.mode.INSERT_OR_REPLACE,
      -- mode = llm.mode.BUFFER,
      builder = function(input)
        return function(build)
          vim.ui.input(
            { prompt = 'Action to perform on code: ' },
            function(user_input)
              if user_input == nil then return end

              local final_prompt = ''
              if #user_input > 0 then

                final_prompt =
"Below is an instruction that describes a task. Write a response that appropriately completes the request.\n\n### Instruction:\n"..user_input .. "\n[CODE]\n" .. input .. "\n[/CODE]\n".."\n\n### Response:"

              else
                return
              end

              print(final_prompt)
              build({
                prompt = final_prompt
              })
            end)
        end
      end,
      transform = extract.markdown_code,
    },

    open_assistant = { --  does not stop talking...
      provider = llamacpp,
      params = { temperature = 0.4, },

      options = {
        temperature = 0.2,     -- Adjust the randomness of the generated text (default: 0.8).
        repeat_penalty = 1.0,  -- Control the repetition of token sequences in the generated text (default: 1.1)
        seed = -1,             -- Set the random number generator (RNG) seed (default: -1, -1 = random seed)
      },

      mode = llm.mode.INSERT_OR_REPLACE,
      -- mode = llm.mode.BUFFER,
      builder = function(input)
        return function(build)
          vim.ui.input(
            { prompt = 'Action to perform on code: ' },
            function(user_input)
              if user_input == nil then return end

              local final_prompt = ''
              if #user_input > 0 then

                final_prompt =
"Below is an instruction that describes a task. Write a response that appropriately completes the request.\n\n### Instruction:\n"..user_input .. "\n[CODE]\n" .. input .. "\n[/CODE]\n".."\n\n### Response:"
                -- local sys_msg = "Follow user instruction and modify code wrapped in [CODE] tag. Write a response that appropriately completes the request."
                -- final_prompt = "<|im_start|>\nsystem\n" .. user_input .."<|im_end|>\n<|im_start|>user\n".. "\n[CODE]\n" .. input .. "\n[/CODE]\n" .."<|im_end|>\n<|im_start|>assistant "

                final_prompt =
"<|im_start|>system\nBelow is an instruction that describes a task. Write a response that appropriately completes the request.<|im_end|>\n"..user_input .. "\n[CODE]\n" .. input .. "\n[/CODE]\n"
              else
                return
              end

              print(final_prompt)
              build({
                prompt = final_prompt
              })
            end)
        end
      end,
      transform = extract.markdown_code,
    },

  },
}
