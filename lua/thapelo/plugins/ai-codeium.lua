return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"xiaket/codeium.nvim",
			event = "InsertEnter",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			opts = {
				enable_cmp_source = false,
				virtual_text = {
					enabled = true,
					manual = false,
					idle_delay = 75,
					map_keys = true,
					virtual_text_priority = 65535,
					key_bindings = {
						accept = "<Tab>",
						next = "<M-]>",
						prev = "<M-[>",
					},
				},
				workspace_root = {
					use_lsp = true,
					paths = { ".git", "package.json" },
				},
			},
		},
	},
	opts = {
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer", "codeium" },
			},
			providers = {
				codeium = { name = "Codeium", module = "codeium.blink" },
			},
		},
	},
}
