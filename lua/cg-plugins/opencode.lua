return {
	"sudo-tee/opencode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				anti_conceal = { enabled = false },
				file_types = { 'markdown', 'opencode_output' }
			}
		}
	},
	opts = {
		keymap = {
			global = {
				toggle = '<leader>aa',
				open_input = '<leader>ai',
				open_input_new_session = '<leader>aI',
				open_output = '<leader>ao',
				toggle_focus = '<leader>at',
				close = '<leader>aq',
				select_session = '<leader>as',
				configure_provider = '<leader>ap',
				diff_open = '<leader>ad',
				diff_next = '<leader>a]',
				diff_prev = '<leader>a[',
				diff_close = '<leader>ac',
				diff_revert_all_last_prompt = '<leader>ara',
				diff_revert_this_last_prompt = '<leader>art',
				diff_revert_all = '<leader>arA',
				diff_revert_this = '<leader>arT',
				swap_position = '<leader>ax',
			},
			window = {
				debug_messages = '<leader>aD',
				debug_output = '<leader>aO',
			},
		},
	},
}