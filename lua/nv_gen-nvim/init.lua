-- local coding_model = "mywizard_coder:latest"  -- or 'my_phindv2:q4_K_M'
-- local coding_model = "deepseek-coder:6.7b-instruct-q5_K_M"  -- for ollama
-- local coding_model = "deepseek-coder-6.7b-instruct.Q5_K_M.gguf"  -- for llamacpp
local coding_model = "CodeQwen1.5-7B-Chat-Q5_K_S.gguf"  -- almost as good as deepseek-coder 33b !

-- require("gen").model = "zephyr:7b-beta-q5_K_M" -- good for sumamry.., not so great for coding..
-- require("gen").model = "openhermes2.5-mistral:7b-q5_K_M" -- ok at +++ coding tooo...
-- require("gen")
local stop_token = {"<|end_of_turn|>"}
local open_code_stop_token = {"<|im_end|>", "<|im_start|>"}
require('gen').setup({
  model = "starling-lm-7b-alpha.Q4_K_M.gguf", -- ok at +++ coding tooo...
  display_mode = "split", -- The display mode. Can be "float" or "split".
  show_prompt = false, -- Shows the Prompt submitted to Ollama.
  show_model = false, -- Displays which model you are using at the beginning of your chat session.
  no_auto_close = false, -- Never closes the window automatically.
  -- init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
  -- Function to initialize Ollama
  -- command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body", -- ollama
  -- command = "curl --silent --no-buffer -X POST http://localhost:8080/completion -d $body", -- llamacpp
  -- was /forward - with commit "c3fca8695dd61c350e08e9912784c21061f98a1e"
  command = [[curl --request POST \
  --url http://localhost:5000/v1/chat/completions \
  --header "Content-Type: application/json" \
  --data $body]], -- my local python forwarding REST server to llamacpp
  model_options = {
    min_p = 0.2,



    -- XXX: which model is overriding which where?
    -- model = "starling-lm-7b-alpha.Q4_K_M.gguf",  -- for my local llamacpp
    ngl = 25,
    n_predict = 850,
    stop = open_code_stop_token
  },
  -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  -- This can also be a lua function returning a command string, with options as the input parameter.
  -- The executed command must return a JSON object with { response, context }
  -- (context property is optional).
  list_models = '<omitted lua function>', -- Retrieves a list of model names
  debug = false -- Prints errors and the command which is run.
})
local deep_seek_wrap = function(s)  -- for deepseek-coder
  local codex_prefix = "### Instruction:\n"
  local codex_suffix = "\n### Response:"
  return codex_prefix .. s .. codex_suffix
end
local starling_wrap = function(s)  -- for starling-lm
  local codex_prefix = "GPT4 Correct User:\n"
  local codex_suffix = "\n<|end_of_turn|>GPT4 Correct Assistant:"
  return codex_prefix .. s .. codex_suffix
end

local openCodeInterpreter_wrap = function(s)  -- for starling-lm
  local instruction = "<|im_start|>\nYou are a helpful assistant.<|im_end|>\n"
  local codex_prefix = "<|im_start|>user\n"
  local codex_suffix = "<|im_end|>\n<|im_start|>assistant"
  return instruction..codex_prefix .. s .. codex_suffix
end

local prompts = require("gen").prompts
prompts["Make_Table"] = nil
prompts["Make_List"] = nil
prompts["Generate"] = nil
prompts["Enhance_Code"] = nil
prompts["Change_Code"] = nil
prompts["Code_Annotation"] = nil
prompts["Review_Code"] = nil

prompts["Ask"] = {
  prompt = starling_wrap("$input"),
  model_options = {
    stop = stop_token,
    min_p = 0.05
  },
}
prompts["Change"] = {
  prompt = starling_wrap("$input:\n$text"),
  replace = false,
  model_options = {
    stop = stop_token,
    min_p = 0.05
  },
}
prompts["Enhance_Wording"] = {
  prompt = starling_wrap("Improve the following text by better wording. Use casual style and avoid technical jargon. Do not change the meaning of the text:\n```\n$text\n```"),
  replace = false,
  model_options = {
    stop = stop_token,
    temperature = 0.5,
    min_p = 0.05
  },
}

prompts["Enhance_Grammar_Spelling"] = {
  prompt = starling_wrap("Modify the following text to improve grammar and spelling, just output the final text without additional quotes around it:\n```\n$text\n```"),
  replace = false,
  model_options = {
    stop = stop_token,
    temperature = 0.5,
    min_p = 0.05
  },
}

prompts["Code_Modify"] = {
  -- prompt = "Regarding the following code, $input1, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
  prompt = openCodeInterpreter_wrap( "Below is an instruction that describes a task. Write a response that appropriately completes the request.\n$input\n[CODE]\n$text\n[/CODE]\n"),
  replace = false,
  -- extract = "[CODE](.-)[/CODE]"
  extract = "```$filetype\n(.-)```",
  model = coding_model, -- 34b
}
prompts["Code_Enhance"] = {
  prompt =
  openCodeInterpreter_wrap("Enhance and optimize the following code:\n```$filetype\n$text\n```"), -- Output the result in format ```$filetype\n...\n```
  replace = false,
  extract = "```$filetype\n(.-)```",
  model_options = { min_p = 0.2, },
  model = coding_model,
}
prompts["Code_Review"] = {
  prompt = openCodeInterpreter_wrap("Review the following code and make concise suggestions:\n```$filetype\n$text\n```"),
  model = coding_model,
}
prompts["Code_Explain"] = {
  prompt = openCodeInterpreter_wrap("Explain the following code, and make suggestions, if required:\n```$filetype\n$text\n```"),
  model = coding_model,
}
prompts["Code_Generate"] = {
  prompt = openCodeInterpreter_wrap("$input"),
  replace = false,
  model = coding_model,
  model_options = {
    min_p = 0.4,
  },
}
prompts["Code_Docstring"] = {
  prompt = openCodeInterpreter_wrap("Explain in one sentence what function below is it doing, and describe function arguments and return value. Output response in '''$filetype''' docstring format:\n```$filetype\n$text\n```"),
  replace = false,
  model = coding_model,
}
