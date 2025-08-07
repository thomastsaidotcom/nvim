-- ReplaceWithRegister plugin for easy text replacement
-- Provides operators to replace text with register contents
return {
  'vim-scripts/ReplaceWithRegister',
  keys = {
    { 'gr', mode = 'x', desc = 'Replace with register' },
    { 'grr', mode = 'n', desc = 'Replace line with register' },
  },
}