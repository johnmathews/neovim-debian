-- use {
--   'myusername/example',        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--   requiring a string which matches one of these patterns, the plugin will be loaded.
-- }

local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer. Restart Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("Packer not found")
  vim.notify("Packer not found")
  return
end

return packer.startup({
  function(use)
    use("wbthomason/packer.nvim")
    use("lewis6991/impatient.nvim")

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")

    use("nathom/filetype.nvim")

    use("dstein64/vim-startuptime")

    use({
      "folke/which-key.nvim",
      config = function()
        require("plugins.whichkey")
      end,
    })

    -- neovim entrance screen
    use({
      "goolord/alpha-nvim",
      config = function()
        require("plugins.alpha")
      end,
    })

    -- finding the project root and setting it as the working directory
    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("plugins.project")
      end,
    })

    -- saving sessions
    use("tpope/vim-obsession")

    -- resizing windows
    use({
      "simeji/winresizer",
      config = function()
        vim.cmd([[let g:winresizer_keycode_finish=96 ]])
      end,
    })

    -- find anything
    use({
      "nvim-telescope/telescope.nvim",
      -- commit = "23e28d066a55a8e33bff33196f7bd65ea3ecbdbe",
      requires = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "nvim-treesitter/nvim-treesitter",
        "neovim/nvim-lspconfig",
      },
      config = function()
        require("plugins.telescope")
      end,
    })
    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    })
    use({
      "ThePrimeagen/harpoon",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugins.harpoon")
      end,
    })

    -- the buffer names at the top
    use({
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins.bufferline")
      end,
    })

    -- the statusline at the bottom
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("plugins.lualine")
      end,
    })

    -- shows what method or function you're in
    use({
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugins.gps")
      end,
    })

    -- comments
    use({
      "numToStr/Comment.nvim",
      requires = {
        "nvim-treesitter/nvim-treesitter",
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      config = function()
        require("plugins.comment")
      end,
    })

    -- use("lukas-reineke/lsp-format.nvim")
    use({ "neovim/nvim-lspconfig" })
    use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
    use({ "tamago324/nlsp-settings.nvim" }) -- language server settings defined in json for
    use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters and code actions
    use({ "onsails/lspkind-nvim", requires = "famiu/bufdelete.nvim" })
    use({ "ray-x/lsp_signature.nvim", requires = "neovim/nvim-lspconfig" })
    use({ "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim" })
    use({ "RishabhRD/nvim-lsputils", requires = "RishabhRD/popfix" })

    -- normal copilot setup
    use({
      "github/copilot.vim",
      config = function()
        require("plugins.copilot-simple")
      end,
    })

    -- creates a copilot server that a cmp source can access (like an lsp server)
    -- cmp is not setup to use this source yet - i cant figure out how to make it work.
    -- use {
    --   "zbirenbaum/copilot.lua",
    --   event = { "VimEnter" },
    --   config = function()
    --     vim.defer_fn(function()
    --       require("plugins.copilot")
    --     end, 100)
    --   end,
    -- }
    -- copilot as a cmp completion source
    -- cmp is not setup to use this source yet - i cant figure out how to make it work.
    -- use {
    --   "zbirenbaum/copilot-cmp",
    --   module = "copilot_cmp",
    -- }

    -- completions
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        require("plugins.cmp")
      end,
    })
    -- snippets in cmp completion window
    use("saadparwaiz1/cmp_luasnip")

    -- snippets engine
    use({ "L3MON4D3/LuaSnip" })

    -- library of snippets
    use({ "rafamadriz/friendly-snippets" })

    -- tame the quickfix window
    use({ "romainl/vim-qf" })

    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("plugins.treesitter")
      end,
      requires = {
        "nvim-treesitter/playground",
      },
    })

    use({
      "skywind3000/asyncrun.vim",
      config = function()
        require("plugins.asyncrun")
      end,
    })

    use({
      "p00f/nvim-ts-rainbow",
      config = function()
        require("plugins.rainbow")
      end,
    })

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("plugins.autopairs")
      end,
    })

    use({
      "windwp/nvim-ts-autotag",
      config = function()
        require("plugins.autotag")
      end,
    })

    use({
      "MunifTanjim/prettier.nvim",
      config = function()
        require("plugins.prettier")
      end,
    })

    use("chrisbra/csv.vim")

    use("nvie/vim-flake8")

    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugins.toggleterm")
      end,
    })

    use("tpope/vim-fugitive")
    -- use("airblade/vim-gitgutter")
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("plugins.git-signs")
      end,
    })

    use({
      "plasticboy/vim-markdown",
      config = function()
        require("plugins.markdown")
      end,
    })
    use({
      "simnalamburt/vim-mundo",
      config = function()
        require("plugins.mundo")
      end,
    })
    use("MisanthropicBit/vim-numbers")

    use({
      "tyru/open-browser.vim",
      config = function()
        require("plugins.open-browser")
      end,
    })
    use("tpope/vim-projectionist")
    use("tpope/vim-repeat")

    --  interacting with and manipulating Vim marks
    use({
      -- "chentau/marks.nvim",
      "chentoast/marks.nvim",
      config = function()
        require("plugins.marks")
      end,
    })

    use("vim-scripts/pylint.vim")

    -- adds various text objects to give you more targets to operate on
    use("wellle/targets.vim")
    -- Jump to any location specified by two characters.
    use({
      "justinmk/vim-sneak",
      config = function()
        require("plugins.sneak")
      end,
    })

    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")

    --use({ "kana/vim-textobj-user", requires = { "whatyouhide/vim-textobj-xmlattr" } })

    use("shmup/vim-sql-syntax")
    use("godlygeek/tabular")

    -- like tagbar, but in lua
    -- tags, outline
    use({
      "simrat39/symbols-outline.nvim",
      config = function()
        require("plugins.symbols-outline")
      end,
    })

    use({
      "janko-m/vim-test",
      config = function()
        require("plugins.test")
      end,
    })

    -- cmd is the command that triggers the plugin to be loaded.
    -- need to run :GoUpdateBinaries after installing the plugin
    -- for GO language
    use({ "fatih/vim-go" })

    use("hashivim/vim-vagrant")
    use({
      "lervag/vimtex",
      config = function()
        require("plugins.vimtex")
      end,
    })

    -- highlights the XML/HTML tags that enclose your cursor location.
    use({ "valloric/matchtagalways" })

    -- syntax highlighting for requirements.txt files
    use("raimon49/requirements.txt.vim")

    use({
      "pearofducks/ansible-vim",
      config = function()
        require("plugins.ansible-vim")
      end,
    })

    use("ekalinin/Dockerfile.vim")

    -- file explorer
    use({
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("plugins.nvim-tree")
      end,
    })

    -- COLORS + colorschemes

    -- show hexcodes etc with a bg that matches the color they represent
    -- off by default, use :ColorHighlight! to toggle. see :h colorizer
    use({ "chrisbra/Colorizer" })

    use({
      "folke/lsp-colors.nvim",
      config = function()
        require("plugins.lsp_colors")
      end,
    })

    use 'tanvirtin/monokai.nvim'

    use({
      "kyazdani42/nvim-web-devicons",
    })

    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,

  config = {
    compile_path = vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua",
    max_jobs = 16,
    display = {
      open_fn = nil,
      -- open_fn = require("packer.util").float,
    },
    profile = {
      -- PackerCompile profile=true then reopen nvim and run :PackerProfile
      enable = true,
      threshold = 0.1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})
