--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- REFERENCE
--
-- Show type information in Rust with `<S-k>`.
--
-- Delete/kill a buffer with `<Leader>c`.
--
-- END REFERENCE

vim.opt.hlsearch = false
vim.opt.rnu = true

-- general
lvim.log.level = "warn"
lvim.colorscheme = "delek" -- light
-- lvim.colorscheme = "onedarker" -- dark
lvim.use_icons = true
lvim.builtin.cmp.experimental.ghost_text = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["t"] = {
	name = "+Toggle",
	a = { ":ASToggle<CR>", "Auto Save" },
	w = { ":set wrap!<CR>", "Line Wrapping" },
}

table.insert(
	lvim.builtin.which_key.mappings["l"],
	{ R = { ":LspRestart<CR>", "Restart" } }
)

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

-- Terminal Stuff
-- I possibly only want it like this when I'm in a Rust project.
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "vertical"
-- I wish I open the terminal to a percentage of the buffer
lvim.builtin.terminal.size = 80
lvim.builtin.terminal.open_mapping = "<Leader>\'"

-- Tree stuff
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"css",
	"fish",
	"haskell",
	"java",
	"javascript",
	"json",
	"latex",
	"lua",
	"python",
	"rust",
	"svelte",
	"typescript",
	"tsx",
	"yaml",
}

lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
	"sumneko_lua",
	"jsonls",
}

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- Additional Plugins
lvim.plugins = {
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup {
				condition = function(buf)
					local fn = vim.fn
					local utils = require("auto-save.utils.data")

					if fn.getbufvar(buf, "&modifiable") == 1
							and utils.not_in(fn.getbufvar(buf, "&filetype"), {
								-- Nothing here yet
							})
							and utils.not_in(fn.expand("%:t"), {
								"config.lua"
							})
					then
						return true
					end
					return false
				end
			}
		end,
	},
	{
		"n-shift/scratch.nvim",
		config = function()
			require("telescope").load_extension("scratch")
		end,
	},
	{
		"black-desk/fcitx5-ui.nvim",
		rocks = { 'lgi', 'dbus_proxy' }
		-- You MUST config fcitx to `ShareInputState=No`
	},
	{
		"luochen1990/rainbow",
		config = function()
			vim.g.rainbow_active = 1
		end
	},
	{
		"lervag/vimtex",
		config = function()
			vim.g.vimtex_view_method = 'zathura'
			vim.g.vimtex_quickfix_enabled = 0
		end,
	},
	"kdheepak/cmp-latex-symbols",
	"KeitaNakamura/tex-conceal.vim",
	"SirVer/ultisnips",
	"SeniorMars/typst.nvim",
	{
		"aca/emmet-ls",
		config = function()
			local lspconfig = require('lspconfig')
			local configs = require('lspconfig/configs')
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug",
					"typescriptreact", "vue" },
			})
		end,
	}
}

-- Create a scratch buffer
lvim.keys.normal_mode["<Leader>bs"] = ":ScratchNew md<CR>"

-- Open an external terminal (because the built-in terminal doesn't seem to clear properly)
-- lvim.keys.normal_mode["<Leader>\""] = ":!foot &<CR>"

-- Format on save
-- TODO: Figure out the timeout for auto-save so that auto-format doesn't happen too much.
lvim.format_on_save.enabled = false

-- Neovide
vim.o.guifont = "JetBrainsMono,Noto_Color_Emoji:h10"
if (vim.g.neovide == true) then
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 1
	vim.g.neovide_transparency = 0.90
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_scroll_animation_length = 0.3
	vim.g.neovide_cursor_animation_length = 0.05
	vim.g.neovide_cursor_trail_length = 0.5
	vim.g.neovide_hide_mouse_when_typing = true
end
