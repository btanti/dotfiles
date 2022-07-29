-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Packer can manage itself
	--
	--
	use 'wbthomason/packer.nvim'
	use 'rcarriga/nvim-notify'
	use 'lewis6991/impatient.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'MunifTanjim/nui.nvim'
	use 'delphinus/cmp-ctags'
	use 'neovim/nvim-lspconfig'
	use 'dstein64/nvim-scrollview'
	use 'untitled-ai/jupyter_ascending.vim'
	use 'navarasu/onedark.nvim'
	use 'dstein64/vim-startuptime'
	use 'ludovicchabant/vim-gutentags'
	use 'tpope/vim-surround'
	use 'windwp/nvim-autopairs'
	use 'hrsh7th/cmp-buffer'
	use 'tpope/vim-fugitive'
	use 'vim-test/vim-test'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'onsails/lspkind-nvim'
	use({
	"hrsh7th/nvim-cmp",
	requires = {
	    { "jc-doyle/cmp-pandoc-references" }
	}
	})
	use 'hrsh7th/cmp-nvim-lsp'
	use("quangnguyen30192/cmp-nvim-ultisnips")
	use "lukas-reineke/indent-blankline.nvim"
	use "ray-x/lsp_signature.nvim"
	
	-- Setup nvim-cmp.
	local cmp = require('cmp')
	local lspkind = require('lspkind')
	cmp.setup {
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				menu = ({
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[Latex]",
				})
			}),
		},
	}

	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		client.server_capabilities.document_formatting = true
		client.server_capabilities.document_range_formatting = true
		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }

		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	end

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		mapping = {
			['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
			['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			['<C-e>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		},
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = 'buffer' },
		})
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
		}, {
			{ name = 'buffer' },
		})
	})

	cmp.setup.filetype('tex', {
		sources = {
		    { name = 'pandoc_references'}
		}, {
		    {name = 'ctags'},
		}
		})


	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline('/', {
		sources = {
			{ name = 'buffer' }
		}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
	})

	-- Setup lspconfig.

	cfg = {
		debug = false, -- set to true to enable debug logging
		log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
		-- default is  ~/.cache/nvim/lsp_signature.log
		verbose = false, -- show debug line number

		bind = true, -- This is mandatory, otherwise border config won't get registered.
		-- If you want to hook lspsaga or other signature handler, pls set to false
		doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
		-- set to 0 if you DO NOT want any API comments be shown
		-- This setting only take effect in insert mode, it does not affect signature help in normal
		-- mode, 10 by default

		floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

		floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
		-- will set to true when fully tested, set to false will use whichever side has more space
		-- this setting will be helpful if you do not want the PUM and floating win overlap

		floating_window_off_x = 1, -- adjust float windows x position.
		floating_window_off_y = 1, -- adjust float windows y position.


		fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
		hint_enable = true, -- virtual hint enable
		hint_prefix = "🐼 ", -- Panda for parameter
		hint_scheme = "String",
		hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
		max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
		-- to view the hiding contents
		max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
		handler_opts = {
			border = "rounded" -- double, rounded, single, shadow, none
		},

		always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

		auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
		extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
		zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

		padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

		transparency = nil, -- disabled by default, allow floating win transparent value 1~100
		shadow_blend = 36, -- if you using shadow as border use this set the opacity
		shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
		timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
		toggle_key = '<C-k>' -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
	}


	use {
		{
			"williamboman/nvim-lsp-installer",
			config = function()
				require("nvim-lsp-installer").setup({
					ui = {
						icons = {
							server_installed = "✓",
							server_pending = "➜",
							server_uninstalled = "✗"
						}
					}
				})
			end
		},
		{
			"neovim/nvim-lspconfig",
			after = "nvim-lsp-installer",
			config = function()
				local lspconfig = require("lspconfig")
				local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
				local util = require("lspconfig/util")
				lspconfig.pyright.setup {
					capabilities = capabilities,
					on_attach = on_attach
				}
       --[[                         lspconfig.texlab.setup {]]
					--[[capabilities = capabilities,]]
					--[[on_attach = on_attach]]
				--[[}]]
				lspconfig.sumneko_lua.setup {
					filetypes = { "lua" },
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
					    Lua = {
						diagnostics = {
						    globals = {'vim'}
						}
					    }
					}
				}
				lspconfig.rust_analyzer.setup {
					capabilities = capabilities,
					on_attach = on_attach
				}
				lspconfig.tsserver.setup {
					capabilities = capabilities,
					on_attach = on_attach
				}
			end
		}
	}
	use {
		"folke/which-key.nvim",
		config = function()
		   require('config.whichkey').setup()
		end
	}
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {}
		end
	}
	use 'ryanoasis/vim-devicons'
	use 'preservim/nerdcommenter'
	use 'mhinz/vim-startify'
	use 'itchyny/lightline.vim'
	use { "akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
		require("toggleterm").setup()
	end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
       --[[ use {]]
		--[["ThePrimeagen/refactoring.nvim",]]
		--[[requires = {]]
			--[[{ "nvim-lua/plenary.nvim" },]]
			--[[{ "nvim-treesitter/nvim-treesitter" }]]
		--[[}]]
	--[[}]]

	use { 'ibhagwan/fzf-lua',
		-- optional for icon support
		requires = { 'kyazdani42/nvim-web-devicons' }
	}

	local actions = require "fzf-lua.actions"
	

	require 'nvim-treesitter.configs'.setup {
		-- A list of parser names, or "all"
		ensure_installed = { "c", "lua", "rust", "python", "typescript" },
		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,
		-- List of parsers to ignore installing (for "all")
		highlight = {
			-- `false` will disable the whole extension
			enable = true,
			-- list of language that will be disabled
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
	}
	require('onedark').setup {
		-- Main options --
		style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
		transparent = false, -- Show/hide background
		term_colors = true, -- Change terminal color as per the selected theme style
		ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
		cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
		-- toggle theme style ---
		toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

		-- Change code style ---
		-- Options are italic, bold, underline, none
		-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
		code_style = {
			comments = 'italic',
			keywords = 'none',
			functions = 'none',
			strings = 'none',
			variables = 'none'
		},

		-- Custom Highlights --
		colors = {}, -- Override default colors
		highlights = {}, -- Override highlight groups

		-- Plugins Config --
		diagnostics = {
			darker = true, -- darker colors for diagnostic
			undercurl = true, -- use undercurl instead of underline for diagnostics
			background = true, -- use background color for virtual text
		},
	}
	require('onedark').load()
	require('scrollview').setup({
	    excluded_filetypes = {'nerdtree'},
	    current_only = true,
	    on_startup = true,
	    winblend = 30,
	    base = 'right',
	})
	require('nvim-autopairs').setup {}
	require("nvim-lsp-installer").setup({})
	require("lsp_signature").setup(cfg)
	local lspconfig = require('lspconfig')
	lspconfig.pyright.setup {
		capabilities = capabilities,
		on_attach = on_attach
	}
	--[[lspconfig.texlab.setup {]]
		--[[capabilities = capabilities,]]
		--[[on_attach = on_attach]]
	--[[}]]
	lspconfig.sumneko_lua.setup {
		filetypes = { "lua" },
		capabilities = capabilities,
		on_attach = on_attach
	}
	lspconfig.rust_analyzer.setup {
		capabilities = capabilities,
		on_attach = on_attach
	}
	lspconfig.tsserver.setup {
		capabilities = capabilities,
		on_attach = on_attach
	}

end)
