-- Computer detection and configuration module
-- Handles computer-specific settings for different machines

local M = {}

-- Computer types
M.COMPUTER_TYPES = {
	PERSONAL = "personal",
	CG = "cg",
}

-- Manually set which computer type this is
-- Change this value to 'personal' or 'cg' depending on your computer
local CURRENT_COMPUTER = M.COMPUTER_TYPES.CG -- Change this line for each computer

function M.detect_computer()
	return CURRENT_COMPUTER
end

-- Get current computer type
M.current_computer = M.detect_computer()

-- Check if we're on a specific computer type
function M.is_personal()
	return M.current_computer == M.COMPUTER_TYPES.PERSONAL
end

function M.is_cg()
	return M.current_computer == M.COMPUTER_TYPES.CG
end

-- Computer-specific plugin configurations
M.plugins = {
	[M.COMPUTER_TYPES.PERSONAL] = {
		-- Personal-only plugins (add plugin specs here)
	},
	[M.COMPUTER_TYPES.CG] = {
		-- CG-only plugins (add plugin specs here)
	},
}

-- Get plugins for current computer
function M.get_plugins()
	return M.plugins[M.current_computer] or {}
end

-- Check if a plugin should be enabled on current computer
function M.should_enable_plugin(plugin_name)
	local plugins = M.get_plugins()
	return plugins[plugin_name] ~= false
end

return M

