-- This file can be loaded by calling `lua require('useins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'


	-- For vsnip users.
	--Plug 'hrsh7th/cmp-vsnip'
	--Plug 'hrsh7th/vim-vsnip'

	-- For luasnip users.
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use "rafamadriz/friendly-snippets"
	use 'lervag/vimtex'
	-- For ultisnips users.
	--use 'SirVer/ultisnips'
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

end)

