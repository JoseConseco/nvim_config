local defaults = {
  debug = false,
  edgy = false,
  yank_register = "+",
  default_provider = "docilellama",
  providers = {
    docilellama = {
      enabled = true,
      api_host = "http://localhost:5000",
      api_key = "",
      models = {
        {
          -- create a modify url specifically for mixtral to run
          name = "starling-lm-7b-alpha.Q4_K_M.gguf",
          modify_url = function(url)
            return url
          end,
          -- conform_fn = function(params)
          --   -- Different models might have different instruction format
          --   -- for example, Mixtral operates on `<s> [INST] Instruction [/INST] Model answer</s> [INST] Follow-up instruction [/INST] `
          -- end,
        },
      },
      model = {
        name = "starling-lm-7b-alpha.Q4_K_M.gguf",
        system_message = nil,
      },
      api_params = {
        -- used for `edit` and `edit_code` strategy in the actions
        model = "starling-lm-7b-alpha.Q4_K_M.gguf",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0.5,
        top_p = 0.99,
      },
      api_chat_params = {
        -- use default ollama model
        model = "starling-lm-7b-alpha.Q4_K_M.gguf",
        temperature = 0.8,
        top_p = 0.99,
      },
    },
  },

  edit = {
    layout = "default",
    edgy = nil, -- use global default
    diff = false,
    keymaps = {
      close = "<C-c>",
      accept = "<C-y>", -- accept the output and write to original buffer
      toggle_diff = "<C-d>", -- view the diff between left and right panes and use diff-mode
      toggle_parameters = "<C-p>", -- Toggle parameters window
      cycle_windows = "<Tab>",
      use_output_as_input = "<C-u>",
    },
  },
  popup = {
    edgy = nil, -- use global default
    position = 1,
    size = {
      width = "40%",
      height = 10,
    },
    padding = { 1, 1, 1, 1 },
    enter = true,
    focusable = true,
    zindex = 50,
    border = {
      style = "rounded",
    },
    buf_options = {
      modifiable = false,
      readonly = false,
      filetype = "ogpt-popup",
      syntax = "markdown",
    },
    win_options = {
      wrap = true,
      linebreak = true,
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    keymaps = {
      close = { "<C-c>", "q" },
      accept = "<C-CR>",
      append = "a",
      prepend = "p",
      yank_code = "c",
      yank_to_register = "y",
    },
  },

  chat = {
    welcome_message = 'Welcome',
    loading_text = "Loading, please wait ...",
    question_sign = "", -- 🙂
    answer_sign = "ﮧ", -- 🤖
    border_left_sign = "|",
    border_right_sign = "|",
    max_line_length = 120,
    edgy = nil, -- use global default
    sessions_window = {
      active_sign = " 󰄵 ",
      inactive_sign = " 󰄱 ",
      current_line_sign = "",
      border = {
        style = "rounded",
        text = {
          top = " Sessions ",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
      buf_options = {
        filetype = "ogpt-sessions",
      },
    },
    keymaps = {
      close = { "<C-c>" },
      yank_last = "<C-y>",
      yank_last_code = "<C-i>",
      scroll_up = "<C-u>",
      scroll_down = "<C-d>",
      new_session = "<C-n>",
      cycle_windows = "<Tab>",
      cycle_modes = "<C-f>",
      next_message = "J",
      prev_message = "K",
      select_session = "<CR>",
      rename_session = "r",
      delete_session = "d",
      draft_message = "<C-d>",
      edit_message = "e",
      delete_message = "d",
      toggle_parameters = "<C-p>",
      toggle_message_role = "<C-r>",
      toggle_system_role_open = "<C-s>",
      stop_generating = "<C-x>",
    },
  },
  popup_layout = {
    default = "center",
    center = {
      width = "80%",
      height = "80%",
    },
    right = {
      width = "30%",
      width_parameters_open = "50%",
    },
  },
  output_window = {
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top = " OGPT ",
      },
    },
    win_options = {
      wrap = true,
      linebreak = true,
      foldcolumn = "1",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    buf_options = {
      filetype = "ogpt-window",
      syntax = "markdown",
    },
  },
  system_window = {
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top = " SYSTEM ",
      },
    },
    win_options = {
      wrap = true,
      linebreak = true,
      foldcolumn = "2",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    buf_options = {
      filetype = "ogpt-system-window",
    },
  },
  input_window = {
    prompt = "  ",
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top_align = "center",
        top = " {{input}} ",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    buf_options = {
      filetype = "ogpt-input",
    },
    submit = "<C-Enter>",
    submit_n = "<Enter>",
    max_visible_lines = 20,
  },
  instruction_window = {
    prompt = "  ",
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top_align = "center",
        top = " Instruction ",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    buf_options = {
      filetype = "ogpt-instruction",
    },
    submit = "<C-Enter>",
    submit_n = "<Enter>",
    max_visible_lines = 20,
  },
  parameters_window = {
    setting_sign = "  ",
    border = {
      style = "rounded",
      text = {
        top = " Parameters ",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    buf_options = {
      filetype = "ogpt-parameters-window",
    },
  },
  actions = {
    -- all strategy "edit" have instruction as input
    edit_code_with_instructions = {
      type = "edit",
      strategy = "edit_code",
      template = "Given the follow code snippet, {{instruction}}.\n\nCode:\n```{{filetype}}\n{{input}}\n```",
      delay = true,
      extract_codeblock = true,
      params = {
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0.5,
        top_p = 0.99,
      },
    },

    explain_code_deep = {
      type= "chat",
      template= "Explain the following code:\n\nCode:\n```{{filetype}}\n{{input}}\n```\n\nUse markdown format.\nHere's what the above code is doing:\n```",
      opts= {
        title= " Explain Code",
        -- system = "Explain the following code:\n\nCode:\n```{{filetype}}\n{{input}}\n```\n\nUse markdown format.\nHere's what the above code is doing:\n```",
        strategy= "display",
        params= {
          model= "deepseek-coder:6.7b-instruct-q5_K_M",
          -- stop = [ "```" ]
        }
      }
    },


    -- all strategy "edit" have instruction as input
    edit_with_instructions = {
      -- if not specified, will use default provider
      -- provider = "ollama",
      -- model = "mistral:7b",
      type = "edit",
      strategy = "edit",
      template = "Given the follow input, {{instruction}}.\n\nInput:\n```{{filetype}}\n{{input}}\n```",
      delay = true,
      params = {
        temperature = 0.5,
        top_p = 0.99,
      },
    },
  },

  actions_paths = {
    -- default action that comes with ogpt/lua/flow/actions
    debug.getinfo(1, "S").source:sub(2):match("(.*/)") .. "actions.json",
  },
  show_quickfixes_cmd = "Trouble quickfix",
  predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
}

require("ogpt").setup(defaults)

