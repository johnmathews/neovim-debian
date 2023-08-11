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

  {
    -- https://github.com/tanvirtin/monokai.nvim
    "tanvirtin/monokai.nvim",
    config = function()
      require("plugins.monokai")
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
    "glepnir/lspsaga.nvim",
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

  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
        keymaps = {
          submit = "<C-s>"
        }
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },

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
  -- use({
  --   "folke/lsp-colors.nvim",
  --   config = function()
  --     require("plugins.lsp-colors")
  --   end,
  -- })
  { "kyazdani42/nvim-web-devicons" },
})
