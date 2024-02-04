WELCOME_MESSAGE = [[
     If you don't ask the right questions,
        you don't get the right answers.
                                      ~ Robert Half
]]

local defaults = {
  debug = false,
  api_key_cmd = nil,
  default_provider = {
    -- can also support `textgenui`
    name = "ollama",
    api_host = 'http://localhost:11434',-- os.getenv("OLLAMA_API_HOST"),
    api_key = '', -- os.getenv("OLLAMA_API_KEY"),
  },
  edit_with_instructions = {
    diff = false,
    keymaps = {
      close = "<C-c>",
      accept = "<C-y>",
      toggle_diff = "<C-d>",
      toggle_parameters = "<C-o>",
      cycle_windows = "<Tab>",
      use_output_as_input = "<C-u>",
    },
  },
  chat = {
    welcome_message = WELCOME_MESSAGE,
    loading_text = "Loading, please wait ...",
    question_sign = "", -- 🙂
    answer_sign = "ﮧ", -- 🤖
    border_left_sign = "|",
    border_right_sign = "|",
    max_line_length = 120,
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
    },
    keymaps = {
      close = { "<C-c>" },
      yank_last = "<C-y>",
      yank_last_code = "<C-k>",
      scroll_up = "<C-u>",
      scroll_down = "<C-d>",
      new_session = "<C-n>",
      cycle_windows = "<Tab>",
      cycle_modes = "<C-f>",
      next_message = "<C-j>",
      prev_message = "<C-k>",
      select_session = "<CR>",
      rename_session = "r",
      delete_session = "d",
      draft_message = "<C-d>",
      edit_message = "e",
      delete_message = "d",
      toggle_parameters = "<C-o>",
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
  popup_window = {
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
      filetype = "markdown",
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
  },
  popup_input = {
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
  },

  preview_window = {
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
      -- text = {
      --   top = "",
      -- },
    },
    buf_options = {
      modifiable = false,
      readonly = false,
      filetype = "markdown",
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

  api_params = {
    model = "starling-lm:7b-alpha-q4_K_M",
    temperature = 0.8,
    top_p = 1,
  },
  api_edit_params = {
    model = "starling-lm:7b-alpha-q4_K_M",
    frequency_penalty = 0,
    presence_penalty = 0,
    temperature = 0.5,
    top_p = 1,
  },
  actions = {
    complete_code = {
      type = "chat",
      opts = {
        template =
        "Complete the following code written in {{lang}} by pasting the existing code and continuing it.\n\nExisting code:\n```{{filetype}}\n{{input}}\n```\n\n```{{filetype}}\n",
        strategy = "display",
        params = {
          model = "deepseek-coder:6.7b-instruct-q5_K_M",
          options = {}
        }
      }
    },
    grammar_correction = {
      type = "chat",
      opts = {
        template = "Correct this to standard {{lang}}:\n\n{{input}}",
        strategy = "display",
        params = {
          model = "starling-lm:7b-alpha-q4_K_M"
        }
      },
      args = {
        lang = {
          type = "string",
          optional = "true",
          default = "english"
        }
      }
    },
    translate = {
      type = "chat",
      opts = {
        template = "Translate this into {{lang}}:\n\n{{input}}",
        strategy = "display",
        params = {
          model = "starling-lm:7b-alpha-q4_K_M",
          temperature = 0.3
        }
      },
      args = {
        lang = {
          type = "string",
          optional = "true",
          default = "english"
        }
      }
    },
    keywords = {
      type = "chat",
      opts = {
        template = "Extract the main keywords from the following text.\n\n{{input}}",
        strategy = "display",
        params = {
          model = "starling-lm:7b-alpha-q4_K_M",
          temperature = 0.5,
          frequency_penalty = 0.8
        }
      }
    },
    docstring2 = {
      type = "chat",
      opts = {
        template =
        "# An elaborate, high quality docstring for the above function:\n# Writing a good docstring\n\nThis is an example of writing a really good docstring that follows a best practice for the given language. Attention is paid to detailing things like\n* parameter and return types (if applicable)\n* any errors that might be raised or returned, depending on the language\n\nI received the following code:\n\n```{{filetype}}\n{{input}}\n```\n\nThe code with a really good docstring added is below:\n\n```{{filetype}}",
        strategy = "edit",
        params = {
          model = "starling-lm:7b-alpha-q4_K_M",
          options = {}
        }
      }
    },
    add_tests = {
      type = "chat",
      opts = {
        template =
        "Implement tests for the following code.\n\nCode:\n```{{filetype}}\n{{input}}\n```\n\nTests:\n```{{filetype}}",
        strategy = "display",
        params = {
          model = "deepseek-coder:6.7b-instruct-q5_K_M",
          options = {}
        }
      }
    },
    optimize_code = {
      type = "chat",
      opts = {
        template =
        "Optimize the following code.\n\nCode:\n```{{filetype}}\n{{input}}\n```\n\nOptimized version:\n```{{filetype}}",
        strategy = "edit_code",
        params = {
          model = "deepseek-coder:6.7b-instruct-q5_K_M"
        }
      }
    },
    edit_code_with_instructions2 = {
      type = "chat",
      opts = {
        template =
        "Given the follow code snippet, {{instruction}}..\n\nCode:\n```{{filetype}}\n{{input}}\n```\n\nOptimized version:\n```{{filetype}}",
        strategy = "edit_code",
        params = {
          model = "deepseek-coder:6.7b-instruct-q5_K_M"
        }
      }
    },
    summarize = {
      type = "chat",
      opts = {
        template = "Summarize the following text.\n\nText:\n\"\"\"\n{{input}}\n\"\"\"\n\nSummary:",
        strategy = "display",
        params = {
          model = "starling-lm:7b-alpha-q4_K_M"
        }
      }
    },
    fix_bugs = {
      type = "chat",
      opts = {
        template = "Fix bugs in the below code\n\nCode:\n```{{filetype}}\n{{input}}\n```\n\nFixed code:\n```{{filetype}}",
        strategy = "edit",
        params = {
          model = "deepseek-coder:6.7b-instruct-q5_K_M"
        }
      }
    },
    explain_code = {
      type = "chat",
      opts = {
        title = " Explain Code",
        template =
        "Explain the following code:\n\nCode:\n```{{filetype}}\n{{input}}\n```\n\nUse markdown format.\nHere's what the above code is doing:\n```",
        strategy = "display",
        params = {
          model = "deepseek-coder:6.7b-instruct-q5_K_M",
          stop = "```"
        }
      }
    },
    roxygen_edit = {
      type = "chat",
      opts = {
        template =
        "Insert a roxygen skeleton to document this R function:\n\n```{{filetype}}\n[insert]\n\n{{input}}\n\n```",
        strategy = "display",
        params = {
          model = "starling-lm:7b-alpha-q4_K_M",
          temperature = 0.5,
          max_tokens = 1024
        }
      }
    },
    code_readability_analysis = {
      type = "chat",
      opts = {
        strategy = "quick_fix",
        template = "{{input}}",
        params = {
          model = "starling-lm:7b-alpha-q4_K_M",
          max_tokens = 2048,
          messages = {
            {
              role = "system",
              content =
              "\nYou must identify any readability issues in the code snippet.\nSome readability issues to consider:\n- Unclear naming\n- Unclear purpose\n- Redundant or obvious comments\n- Lack of comments\n- Long or complex one liners\n- Too much nesting\n- Long variable names\n- Inconsistent naming and code style.\n- Code repetition\nYou may identify additional problems. The user submits a small section of code from a larger file.\nOnly list lines with readability issues, in the format <line_num>|<issue and proposed solution>\nYour commentary must fit on a single line\nDo not use the range of lines but just single line number\nIf there's no issues with code respond with only: <OK>\n"
            },
            {
              role = "user",
              content =
              "\n0 public class Logic {\n1      public static void main(String[] args) {\n2         Scanner sc = new Scanner(System.in);\n3         int n = sc.nextInt();\n4         int[] arr = new int[n];\n5         for (int i = 0; i < n; i++) {\n6             arr[i] = sc.nextInt();\n7         }\n8         int[] dp = new int[n];\n9         dp[0] = arr[0];\n10         dp[1] = Math.max(arr[0], arr[1]);\n11         for (int i = 2; i < n; i++) {\n12             dp[i] = Math.max(dp[i - 1], dp[i - 2] + arr[i]);\n13         }\n14         System.out.println(dp[n - 1]);\n15     }\n16 }"
            },
            {
              role = "assistant",
              content =
              "\n0: The class name 'Logic' is too generic. A more meaningful name could be 'DynamicProgramming'\n2: The variable name 'sc' is unclear. A more meaningful name could be 'scanner'.\n3: The variable name 'n' is unclear. A more meaningful name could be 'arraySize' or 'numElements'.\n4: The variable name 'arr' unclear. A more descriptive name could be 'inputArray' or 'elementValues'.\n8: The variable name 'dp' is unclear. A more informative name could be 'maxSum' or 'optimalSolution'.\n9: There are no comments explaining the meaning of the 'dp' array values and how they relate to the problem statement.\n11: There are no comments explaining the logic and purpose of the for loop"
            },
            {
              role = "user",
              content =
              "\n0    for (let i: number = 0; i < l; i++) {\n1       let notAddr: boolean = false;\n2       // non standard input\n3       if (items[i].scriptSig && !items[i].addr) {\n4         items[i].addr = 'Unparsed address [' + u++ + ']';\n5         items[i].notAddr = true;\n6         notAddr = true;\n7       }\n8 \n9       // non standard output\n10       if (items[i].scriptPubKey && !items[i].scriptPubKey.addresses) {\n11         items[i].scriptPubKey.addresses = ['Unparsed address [' + u++ + ']'];"
            },
            {
              role = "assistant",
              content =
              "\n0: The variable name 'i' and 'l' are unclear and easily confused with other characters like '1'. More meaningful names could be 'index' and 'length' respectively.\n1: The variable name 'notAddr' is unclear and a double negative. An alternative could be 'hasUnparsedAddress'.\n3: The comment \"non standard input\" is not very informative. It could be more descriptive, e.g., \"Check for non standard input address\"\n9: The comment \"non standard output\" is not very informative. It could be more descriptive, e.g., \"Check for non standard output address\"\n10: The variable name 'items' might be more informative if changed to 'transactions' or 'txItems'.\n11: The array element 'Unparsed address [' + u++ + ']' could use a more descriptive comment, e.g., \"Assign a unique identifier to non standard output addresses\"\n11: The variable name 'u' is unclear. A more meaningful name could be 'unparsedAddressCount' or 'unparsedAddressId'."
            },
            {
              role = "user",
              content = "\n0 function BaseAction:init(opts)\n1   self.opts = opts\n2 end"
            },
            {
              role = "assistant",
              content = "<OK>"
            }
          }
        }
      }
    }
  },
  -- actions_paths = {'/home/bartosz/.config/nvim/lua/nv_ogpt/actions.json'},
  show_quickfixes_cmd = "Trouble quickfix",
  predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
}

require("ogpt").setup(defaults)
