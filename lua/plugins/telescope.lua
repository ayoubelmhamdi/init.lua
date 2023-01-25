return {
	-- telescope
	"nvim-telescope/telescope.nvim",
	version = "0.1.0",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim" },
		{
			"theprimeagen/harpoon",
			config = function()
				local mark = require("harpoon.mark")
				local ui = require("harpoon.ui")

				vim.keymap.set("n", "<leader>a", mark.add_file)
				vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

				vim.keymap.set("n", "<C-h>", function()
					ui.nav_file(1)
				end)
				vim.keymap.set("n", "<C-t>", function()
					ui.nav_file(2)
				end)
				vim.keymap.set("n", "<C-n>", function()
					ui.nav_file(3)
				end)
				vim.keymap.set("n", "<C-s>", function()
					ui.nav_file(4)
				end)
			end,
		},
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end,
}
