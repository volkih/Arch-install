-- This file can be loaded by calling `lua require('useins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  use 'hrsh7th/nvim-cmp'
	-- use 'quangnguyen30192/cmp-nvim-ultisnips'
  use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'micangl/cmp-vimtex'


use {
  "smjonas/snippet-converter.nvim",
  -- SnippetConverter uses semantic versioning. Example: use version = "1.*" to avoid breaking changes on version 1.
  -- Uncomment the next line to follow stable releases only.
  -- tag = "*",
  config = function()
    local template = {
      -- name = "t1", (optionally give your template a name to refer to it in the `ConvertSnippets` command)
      sources = {
        ultisnips = {
          -- Add snippets from (plugin) folders or individual files on your runtimepath...
          "./vim-snippets/UltiSnips",
          "~/.config/nvim/mysnips/tex.snippets",
          "~/.config/nvim/mysnips"
        },
        snipmate = {
          "vim-snippets/snippets",
        },
      },
      output = {
        -- Specify the output formats and paths
        vscode_luasnip = {
          "~/.config/nvim/myluasnips"
        },
      },
    }

    require("snippet_converter").setup {
      templates = { template },
      -- To change the default settings (see configuration section in the documentation)
      -- settings = {},
    }
  end
}
  -- For vsnip users.
	--Plug 'hrsh7th/cmp-vsnip'
	--Plug 'hrsh7th/vim-vsnip'

	-- For luasnip users.
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	-- use 'rafamadriz/friendly-snippets'
  -- use 'MarcWeber/vim-addon-mw-utils'  
  -- use 'tomtom/tlib_vim'
  -- use 'garbas/vim-snipmate'
	use 'lervag/vimtex'
	-- For ultisnips users.
  -- use 'SirVer/ultisnips'
  -- use 'honza/vim-snippets'
	--use 'quangnguyen30192/cmp-nvim-ultisnips'

	-- For snippy users.
	--use 'dcampos/nvim-snippy'
	--use 'dcampos/cmp-snippy'



  use 'Pocco81/true-zen.nvim'
	use 'Pocco81/auto-save.nvim'
  use 'kyazdani42/nvim-web-devicons'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
	-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	use 'tpope/vim-surround'
	use {
					'nvim-treesitter/nvim-treesitter',
					run = function()
							local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
							ts_update()
					end,
			}

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use 'jiangmiao/auto-pairs'

	use 'navarasu/onedark.nvim'

	use 'KeitaNakamura/tex-conceal.vim'
  

	use {
			'numToStr/Comment.nvim',
			config = function()
					require('Comment').setup()
			end
	}

  -- Remove the `use` here if you're using folke/lazy.nvim.
  -- use {
  --   'Exafunction/codeium.vim',
  --   config = function ()
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
  --     vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
  --     vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
  --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  --   end
  -- use {
  --   "Exafunction/codeium.nvim",
  --   requires = {
  --       "nvim-lua/plenary.nvim",
  --       "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --       require("codeium").setup({
  --       })
  --   end}
end)
