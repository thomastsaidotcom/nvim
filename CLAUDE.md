# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Overview

This is a **kickstart-modular.nvim** configuration - a modular fork of the popular kickstart.nvim. It's designed as a starting point for Neovim configuration rather than a distribution.

### Architecture

The configuration follows a modular structure:

- `init.lua` - Main entry point that loads all modules
- `lua/options.lua` - Core Neovim options and settings
- `lua/keymaps.lua` - Key mappings and custom functions
- `lua/lazy-bootstrap.lua` - Lazy.nvim plugin manager bootstrap
- `lua/lazy-plugins.lua` - Plugin definitions and configuration
- `lua/kickstart/plugins/` - Core plugin configurations (LSP, telescope, etc.)
- `lua/custom/plugins/` - User-specific plugin additions

### Plugin Management

Uses **Lazy.nvim** as the plugin manager. Key commands:
- `:Lazy` - View plugin status
- `:Lazy update` - Update all plugins
- `:checkhealth` - Check configuration health

Plugin lock file: `lazy-lock.json` (tracks exact plugin versions)

## Custom Plugins

Current custom plugins in `lua/custom/plugins/`:
- `nnn.lua` - File manager integration (`<leader>e` for current dir, `<leader>E` for picker)
- `supermaven.lua` - AI code completion (`Tab` to accept, `Ctrl+e` to clear)
- `vim-fugitive.lua` - Git integration (auto-moves fugitive windows to new tabs)

## Key Mappings Summary

### Navigation
- `H` / `L` - Previous/next tab
- `Ctrl+h/j/k/l` - Window navigation
- `<leader>e` - File manager in current directory
- `<leader>E` - File manager picker

### Buffer Management
- `<leader>bo` - Close all other buffers
- `<leader>bd` - Close current buffer
- `<leader>bn` - Open new buffer/tab

### Code Features
- `<leader>ca` - LSP code actions
- `<leader>cd` - Focus diagnostic window
- `Ctrl+.` - Copy indentation from previous line (normal/insert/visual modes)

### Custom Features
- Auto-diagnostic float on hover (CursorHold)
- Auto-comment removal on new lines
- Copy indentation functions for consistent formatting

## Development Workflow

1. **Configuration Changes**: Edit files in `lua/` directory
2. **Adding Plugins**: Create new files in `lua/custom/plugins/` or edit `lua/lazy-plugins.lua`
3. **Testing**: Use `:checkhealth` and `:Lazy` to verify setup
4. **Plugin Updates**: Run `:Lazy update` regularly

## Important Notes

- Configuration targets latest stable and nightly Neovim builds
- Requires external dependencies: git, make, unzip, C compiler, ripgrep, fd-find
- Nerd Font support enabled (`vim.g.have_nerd_font = true`)
- Leader key set to space (`<space>`)
- Clipboard sync enabled with OS

## File Structure Patterns

- Core kickstart plugins follow naming convention: `require("kickstart.plugins.name")`
- Custom plugins use: `{ import = "custom.plugins" }`
- All Lua files use consistent indentation: 2 spaces, expand tabs
- Plugin files return configuration tables for Lazy.nvim

## Troubleshooting

- Run `:checkhealth` for diagnostic information
- Check `:Lazy` for plugin status and errors
- Verify external dependencies are installed
- Review `lazy-lock.json` for plugin version conflicts