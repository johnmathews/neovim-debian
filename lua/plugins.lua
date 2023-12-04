local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  print("lazy not found")
  vim.notify("lazy not found")
  return
end

return lazy.setup({
  { "lewis6991/impatient.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  { "nathom/filetype.nvim" },
  { "dstein64/vim-startuptime" },
  { "gioele/vim-autoswap"},
  {
    -- https://github.com/cpea2506/one_monokai.nvim
    "cpea2506/one_monokai.nvim",
    config = function()
      require("plugins.one_monokai")
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("plugins.whichkey")
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("plugins.alpha")
    end,
  },
  -- finding the project root and setting it as the working directory
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.project")
    end,
  },

  -- https://github.com/rmagatti/auto-session#-command-hooks
  {
    'rmagatti/auto-session',
    config = function()
      require("plugins.auto-session")
    end
  },

  -- resizing windows
  {
    "simeji/winresizer",
    config = function()
      vim.cmd([[let g:winresizer_keycode_finish=96 ]])
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require("plugins.telescope")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.harpoon")
    end,
  },

  -- the statusline at the bottom
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "WhoIsSethDaniel/lualine-lsp-progress.nvim",
    },
    config = function()
      require("plugins.lualine")
    end,
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("plugins.comment")
    end,
  },

  -- lsp status indicator, because maybe the lualine one is broken?
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
      require "fidget".setup {
        align = {
          bottom = false, -- align fidgets along bottom edge of buffer
          right = true,   -- align fidgets along right edge of buffer
        },

      }
    end,
  },

  {
    "williamboman/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-dap"
    },
    config = function()
      require("plugins.mason")
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.null-ls")
    end
  },
  { "ray-x/lsp_signature.nvim",   dependencies = "neovim/nvim-lspconfig" },
  {
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    config = function()
      require("plugins.toggle-lsp-diagnostics")
    end
  },

  {
    "nvimdev/lspsaga.nvim",
    branch = "main",
    -- tag = "*",
    config = function()
      require("plugins.lsp-saga")
    end,
  },

  -- buffers and window management
  {
    "marklcrns/vim-smartq",
    config = function()
      require("plugins.smartq")
    end,
  },

  {
    "Asheq/close-buffers.vim",
    config = function()
      require("plugins.close-buffers")
    end,
  },

  -- AI
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   -- into video https://www.youtube.com/watch?v=7k0KZsheLP4
  --   -- api/secret managment avoiding plaintext config files https://github.com/jackMort/ChatGPT.nvim#secrets-management
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup({
  --       edit_with_instructions = {
  --         diff = false,
  --         keymaps = {
  --           close = "<C-c>",
  --           accept = "<C-y>",
  --           toggle_diff = "<C-d>",
  --           toggle_settings = "<C-o>",
  --           cycle_windows = "<Tab>",
  --           use_output_as_input = "<C-i>",
  --         },
  --       },
  --       chat = {
  --         welcome_message = "welcome..",
  --         loading_text = "Loading, please wait ...",
  --       },
  --       keymaps = {
  --         submit = "<C-s>",
  --         close = { "<C-c>" },
  --         yank_last = "<C-y>",
  --         yank_last_code = "<C-k>",
  --         scroll_up = "<C-u>",
  --         scroll_down = "<C-d>",
  --         new_session = "<C-n>",
  --         cycle_windows = "<Tab>",
  --         cycle_modes = "<C-f>",
  --         select_session = "<Space>",
  --         rename_session = "r",
  --         delete_session = "d",
  --         draft_message = "<C-d>",
  --         toggle_settings = "<C-o>",
  --         toggle_message_role = "<C-r>",
  --         toggle_system_role_open = "<C-s>",
  --         stop_generating = "<C-x>",
  --       },
  --       openai_params = {
  --         model = "gpt-3.5-turbo",
  --         frequency_penalty = 0,
  --         presence_penalty = 0,
  --         max_tokens = 300,
  --         temperature = 0,
  --         top_p = 1,
  --         n = 1,
  --       },
  --       openai_edit_params = {
  --         model = "code-davinci-edit-001",
  --         temperature = 0,
  --         top_p = 1,
  --         n = 1,
  --       },
  --       actions_paths = {},
  --       show_quickfixes_cmd = "Trouble quickfix",
  --       predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",

  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- },

  {
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end, 100)
    end,
    dependencies = {
      "copilot.lua",
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup({
        method = "getCompletionsCycling",
        formatters = {
          label = require("copilot_cmp.format").format_label_text, -- this breaks multiline suggestions sometimes
          insert_text = require("copilot_cmp.format").remove_existing,
          preview = require("copilot_cmp.format").deindent,
        },
      })
    end
  },

  -- completions
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "lukas-reineke/cmp-under-comparator"
    },
    config = function()
      require("plugins.cmp")
    end,
  },

  -- snippets engine
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugins.luasnip")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
    dependencies = {
      "nvim-treesitter/playground",
    },
  },

  -- this is an (unmaintained) treesitter plugin.
  -- config is in the `rainbow` attribute in treesitter.lua
  {
    "p00f/nvim-ts-rainbow",
  },

  -- autoclose and autorename html tags (html,tsx,vue,svelte,php,rescript)
  -- this is a treesitter plugin. config is the `autotag` attribute in treesitter.lua
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs")
    end,
    event = "VimEnter",
  },

  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.toggleterm")
    end,
    event = "VimEnter",
  },
  {
    "tpope/vim-dadbod",
    lazy = true,
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      require("plugins.dadbod").setup()
    end,
    cmd = {
      "DBUIToggle",
      "DBUI",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.git-signs")
    end,
  },

  {
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
      "tex",
      "plaintex",
      "norg",
    },
    config = function()
      require("autolist").setup()

      vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
      -- vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
      -- vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      -- vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
      -- vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
      -- vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

      -- cycle list types with dot-repeat
      vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
      vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

      -- if you don't want dot-repeat
      -- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
      -- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

      -- functions to recalculate list on edit
      vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
  },

  -- preview markdown
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
        style = "dark",
        pager = false,
      })
    end,
  },

  -- used only because it can format yaml frontmatter in a markdown blog post
  {
    "preservim/vim-markdown",
    dependencies = {
      "godlygeek/tabular",
    },
    config = function()
      require("plugins.vim-markdown")
    end,
  },

  {
    "simnalamburt/vim-mundo",
    config = function()
      require("plugins.mundo")
    end,
  },

  { "MisanthropicBit/vim-numbers" },

  {
    "tyru/open-browser.vim",
    config = function()
      require("plugins.open-browser")
    end,
  },

  --  interacting with and manipulating Vim marks
  {
    "chentoast/marks.nvim",
    config = function()
      require("plugins.marks")
    end,
  },

  -- adds various text objects to give you more targets to operate on
  { "wellle/targets.vim" },

  -- movement, like sneak
  {
    "ggandor/leap.nvim",
    config = function()
      require("plugins.leap")
    end,
  },

  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "tpope/vim-unimpaired" },

  { "chrisbra/csv.vim" },

  {
    "vim-test/vim-test",
    config = function()
      require("plugins.vim-test")
    end,
    dependencies = {
      "skywind3000/asyncrun.vim",
    },
  },

  { "hashivim/vim-vagrant" },

  -- highlights the XML/HTML tags that enclose your cursor location.
  -- { "valloric/matchtagalways" },

  -- highlight matching tags in html, js, jsx, vue, svelte
  {
    "leafOfTree/vim-matchtag",
    config = function()
      require("plugins.vim-matchtag")
    end,
  },

  -- syntax highlighting for requirements.txt files
  { "raimon49/requirements.txt.vim" },
  {
    "pearofducks/ansible-vim",
    config = function()
      require("plugins.ansible-vim")
    end,
  },

  -- file explorer
  -- https://github.com/nvim-tree/nvim-tree.lua/commits/master
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("plugins.nvim-tree")
    end,
    event = "VimEnter",
    -- commit = "8b8d457e07d279976a9baac6bbff5aa036afdc5f",
  },

  -- COLORS + colorschemes

  -- show hexcodes etc with a bg that matches the color they represent
  -- off by default, use :ColorHighlight! to toggle. see :h colorizer
  { "chrisbra/Colorizer" },

  -- required by several plugins
  { "kyazdani42/nvim-web-devicons" },

})
