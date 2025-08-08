return {
	"yioneko/nvim-vtsls",
	ft = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("vtsls").config({
			-- automatically trigger renaming of extracted symbol
			refactor_auto_rename = true,
			refactor_move_to_file = {
				-- If dressing.nvim is installed, telescope will be used for selection prompt. Use this to customize
				-- the opts for telescope picker.
				telescope_opts = function(items, default) end,
			},
			settings = {
				complete_function_calls = true,
				vtsls = {
					enableMoveToFileCodeAction = true,
					autoUseWorkspaceTsdk = true,
					experimental = {
						completion = {
							enableServerSideFuzzyMatch = true,
						},
					},
				},
				typescript = {
					updateImportsOnFileMove = { enabled = "always" },
					suggest = {
						completeFunctionCalls = true,
					},
					inlayHints = {
						enumMemberValues = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						parameterNames = { enabled = "literals" },
						parameterTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						variableTypes = { enabled = false },
					},
				},
			},
		})
	end,
}

