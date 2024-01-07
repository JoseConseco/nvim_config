-- local coding_model = "mywizard_coder:latest"  -- or 'my_phindv2:q4_K_M'
local coding_model = "deepseek-coder:6.7b-instruct-q5_K_M"  -- or 'my_phindv2:q4_K_M'

-- require("gen").model = "zephyr:7b-beta-q5_K_M" -- good for sumamry.., not so great for coding..
-- require("gen").model = "openhermes2.5-mistral:7b-q5_K_M" -- ok at +++ coding tooo...
require("gen")
require('gen').setup({
  model = "starling-lm:7b-alpha-q4_K_M", -- ok at +++ coding tooo...
  display_mode = "float", -- The display mode. Can be "float" or "split".
  show_prompt = false, -- Shows the Prompt submitted to Ollama.
  show_model = false, -- Displays which model you are using at the beginning of your chat session.
  no_auto_close = false, -- Never closes the window automatically.
  init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
  -- Function to initialize Ollama
  command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body", -- ollama
  -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  -- This can also be a lua function returning a command string, with options as the input parameter.
  -- The executed command must return a JSON object with { response, context }
  -- (context property is optional).
  list_models = '<omitted lua function>', -- Retrieves a list of model names
  debug = false -- Prints errors and the command which is run.
})
local prompts = require("gen").prompts
prompts["Make_Table"] = nil
prompts["Make_List"] = nil
prompts["Generate"] = nil
prompts["Enhance_Code"] = nil
prompts["Change_Code"] = nil
prompts["Review_Code"] = nil

prompts["Ask"] = { prompt = "$input" }
prompts["Change"] = {
  prompt = "$input:\n$text",
  replace = false,
}
prompts["Code_Modify"] = {
  -- prompt = "Regarding the following code, $input1, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
  prompt =
  "Below is an instruction that describes a task. Write a response that appropriately completes the request.\n\n### Instruction:\n$input\n[CODE]\n$text\n[/CODE]\n" ..
  "\n\n### Response:",
  replace = false,
  -- extract = "[CODE](.-)[/CODE]"
  extract = "```$filetype\n(.-)```",
  model = coding_model, -- 34b
  -- model = "mywizard_coder:latest", -- 13b
}
prompts["Code_Enhance"] = {
  prompt =
  "Enhance the following code, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
  replace = false,
  extract = "```$filetype\n(.-)```",
  model = coding_model,
}
prompts["Code_Review"] = {
  prompt = "Review the following code and make concise suggestions:\n```$filetype\n$text\n```",
  model = coding_model,
}

prompts["Code_Explain"] = {
  prompt = "Explain the following code, and make suggestions, if required:\n```$filetype\n$text\n```",
  model = coding_model,
}
prompts["Code_Generate"] = {
  prompt = "$input",
  replace = false,
  model = coding_model,
}
prompts["Code_Annotation"] = {
  prompt = "Explainig in one sentence what function below is it doing. Output your response in '''$filetype''' docstring format:\n```$filetype\n$text\n```",
  replace = false,
  model = coding_model,
}
prompts["Enhance_Wording"] = {
  prompt = "Modify the following text to use better wording:\n$text",
  replace = false,
}
