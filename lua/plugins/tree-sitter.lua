return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{ "nvim-treesitter/playground" },
		{ "lewis6991/spellsitter.nvim" },
		{ "David-Kunz/treesitter-unit" },
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "p00f/nvim-ts-rainbow" },
	},
	build = ":TSUpdate",
	--
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "help", "javascript", "typescript", "c", "lua", "rust" },
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
