
return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Statusbar, required nvim-web-devicons for cool icons
	use {
		'glepnir/galaxyline.nvim',
		branch = 'main',
		-- your statusline
		-- config = function() require'statusbar' end,
		-- some optional icons
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	-- Helps remember keybindings
	use {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup {
				plugins = {
					spelling = {
						enabled = true
					}
				}
			}
		end
	}

	-- Better syntax highlighting
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = require 'nvim-treesitter.configs'.setup {
			highlight = { enable = true },
			indent = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = 10000,
				-- Setting colors
				colors = {
					'#ff0000',
					'#ff7f00',
					'#ffff00',
					'#00ff00',
					'#0000ff',
					'#ff00ff',
				}
			},
			autopairs = {enable = true},
		}
	}
	-- Differentiate pairs
	use 'p00f/nvim-ts-rainbow'
	-- Show context(e.g. what function you're editing) if not in view in floating window at the top
	use {
		'romgrk/nvim-treesitter-context',
		config = require 'treesitter-context.config'.setup {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		}
	}
	-- Syntax highlighting for make files, use files, etc.
	use 'gentoo/gentoo-syntax'

	-- Visualize indentation
	--[[ use {
		"lukas-reineke/indent-blankline.nvim",
		branch = "lua"
	} ]]

	-- Easily comment and uncomment
	use 'b3nj5m1n/kommentary'

	-- Visualize colors
	use {
		'norcalli/nvim-colorizer.lua',
		config = require 'colorizer'.setup(nil, { css = true; })
	}

	-- LSP, completion, and snippets
	use {
		'neovim/nvim-lspconfig',
		config = require'lspconfig'.clangd.setup{} and require'lspconfig'.jedi_language_server.setup{}
	}
	use {
		'hrsh7th/nvim-compe',
		config = require'compe'.setup {
			enabled = true;
			autocomplete = true;
			debug = false;
			min_length = 1;
			preselect = 'enable';
			throttle_time = 80;
			source_timeout = 200;
			incomplete_delay = 400;
			max_abbr_width = 100;
			max_kind_width = 100;
			max_menu_width = 100;
			documentation = true;

			source = {
				path = true;
				nvim_lsp = true;
			};
		}

	}
	use {
		'onsails/lspkind-nvim',
		config = require('lspkind').init()
	}
	use {
		'glepnir/lspsaga.nvim',
		config = require 'lspsaga'.init_lsp_saga {
			error_sign = '',
			warn_sign = ''
		}
	}
	use {
		'simrat39/symbols-outline.nvim',
	}

	-- Git integration

	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = require('gitsigns').setup() 
	}

	-- File explorer
	use 'kyazdani42/nvim-tree.lua'

	-- Onedark theme
	-- use 'joshdick/onedark.vim'

	--[[ -- Telescope, find things easily
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	} ]]

	-- Automagically create pairs
	--[[ use {
		'windwp/nvim-autopairs',
		config = require('nvim-autopairs').setup({
			check_ts = true,
		})
	} ]]
	-- Create or delete pairs with keybinds
	use {
		'steelsojka/pears.nvim',
		config = 
			require "pears".setup(function(conf)
				conf.on_enter(function(pears_handle)
					if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
						return vim.fn["compe#confirm"]("<CR>")
					else
						pears_handle()
					end
				end)
			end)
	}
	use {
		'blackCauldron7/surround.nvim',
		config = require 'surround'.setup{}
	}
end)
