local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    print("Installing packer. Restart Neovim...")
    return true
  end
  return false
end

-- install packer if it isnt already installed
ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("Packer not found")
  vim.notify("Packer not found")
  return
end

-- run PackerCompile whenever plugins.lua is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

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

    use {
      'rmagatti/auto-session',
      config = function()
        require("auto-session").setup {
          log_level = "error",
          auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" }, -- Suppress session create/restore if in one of these
          auto_save_enabled = true,
        }
      end
    }

    -- resizing windows
    use({
      "simeji/winresizer",
      config = function()
        vim.cmd([[let g:winresizer_keycode_finish=96 ]])
      end,
    })

    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "nvim-treesitter/nvim-treesitter",
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope-live-grep-args.nvim",
      },
      config = function()
        require("plugins.telescope")
      end,
    })

    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    })

    use({
      "ThePrimeagen/harpoon",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugins.harpoon")
      end,
    })

    -- the statusline at the bottom
    use({
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        "WhoIsSethDaniel/lualine-lsp-progress.nvim",
      },
      config = function()
        require("plugins.lualine")
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

    use({ "williamboman/mason.nvim",
      requires = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        require("plugins.mason")
      end,
    })

    use({
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
        require("plugins.lsp-saga")
      end,
    })
    -- saga outline is buggy
    -- use({ 'simrat39/symbols-outline.nvim',
    --   config = function()
    --     require("plugins.symbols-outline")
    --   end })

    use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters and code actions
    use({ "ray-x/lsp_signature.nvim", requires = "neovim/nvim-lspconfig" })
    use({ "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim" })

    -- buffers and window management
    use({ "marklcrns/vim-smartq",
      config = function()
        require("plugins.smartq")
      end,
    })

    use({ "Asheq/close-buffers.vim",
      config = function()
        require("plugins.close-buffers")
      end,
    })

    use {
      "zbirenbaum/copilot.lua",
      event = "VimEnter",
      config = function()
        vim.defer_fn(function()
          require("copilot").setup()
        end, 100)
      end,
    }
    use {
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua" },
      config = function()
        require("copilot_cmp").setup({
          method = "getCompletionsCycling",
          formatters = {
            label = require("copilot_cmp.format").format_label_text,
            -- insert_text = require("copilot_cmp.format").format_insert_text,
            insert_text = require("copilot_cmp.format").remove_existing,
            preview = require("copilot_cmp.format").deindent,
          },
        })
      end
    }

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
        "lukas-reineke/cmp-under-comparator"
      },
      config = function()
        require("plugins.cmp")
      end,
    })

    -- snippets engine
    use({ "L3MON4D3/LuaSnip" })

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
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- not sure if this is really used. does toggleterm use it?
    -- would be useful for running heavier commands in the bg
    -- or as part of another plugin that did heavy bg work
    use({
      "skywind3000/asyncrun.vim",
      config = function()
        require("plugins.asyncrun")
      end,
    })

    -- this is an (unmaintained) treesitter plugin.
    -- config is in the `rainbow` attribute in treesitter.lua
    use({
      "p00f/nvim-ts-rainbow",
    })

    -- autoclose and autorename html tags (html,tsx,vue,svelte,php,rescript)
    -- this is a treesitter plugin. config is the `autotag` attribute in treesitter.lua
    use({
      "windwp/nvim-ts-autotag",
      config = function()
        require('nvim-ts-autotag').setup()
      end,
    })

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("plugins.autopairs")
      end,
      event = "VimEnter",
    })

    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugins.toggleterm")
      end,
      event = "VimEnter",
    })

    use({
      "tpope/vim-dadbod",
      opt = true,
      requires = {
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
    })

    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("plugins.git-signs")
      end,
    })

    -- preview markdown
    use({ "ellisonleao/glow.nvim",
      config = function()
        require("glow").setup({
          style = "dark",
          pager = true,
        })
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

    --  interacting with and manipulating Vim marks
    use({
      "chentoast/marks.nvim",
      config = function()
        require("plugins.marks")
      end,
    })

    -- adds various text objects to give you more targets to operate on
    use({ "wellle/targets.vim" })
    -- movement, like sneak
    use({ "ggandor/leap.nvim",
      config = function()
        require("plugins.leap")
      end,
    })

    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")

    use("chrisbra/csv.vim")

    -- run python tests from the buffer
    use({
      "janko-m/vim-test",
      config = function()
        require("plugins.test")
      end,
    })

    use("hashivim/vim-vagrant")

    -- highlights the XML/HTML tags that enclose your cursor location.
    use({ "valloric/matchtagalways" })

    -- highlight matching tags in html, js, jsx, vue, svelte
    use({
      "leafOfTree/vim-matchtag",
      config = function()
        require("plugins.vim-matchtag")
      end,
    })

    -- syntax highlighting for requirements.txt files
    use("raimon49/requirements.txt.vim")
    use({
      "pearofducks/ansible-vim",
      config = function()
        require("plugins.ansible-vim")
      end,
    })

    -- file explorer
    use({
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("plugins.nvim-tree")
      end,
      event = "VimEnter",
    })

    -- COLORS + colorschemes

    -- show hexcodes etc with a bg that matches the color they represent
    -- off by default, use :ColorHighlight! to toggle. see :h colorizer
    use({ "chrisbra/Colorizer" })
    use({
      "folke/lsp-colors.nvim",
      config = function()
        require("plugins.lsp-colors")
      end,
    })
    use("tanvirtin/monokai.nvim")
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
    snapshot_path = vim.fn.stdpath("config") .. "/packer-snapshots/",
  },
})
