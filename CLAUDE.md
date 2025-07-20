# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

<<<<<<< HEAD
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
=======
## Neovim Configuration Overview

This is a kickstart-modular.nvim configuration - a modular fork of kickstart.nvim that provides a well-documented starting point for Neovim configuration. It's NOT a distribution but a foundation for personal customization.

## Development Commands

### Plugin Management
- `:Lazy` - Check plugin status, press `?` for help, `:q` to close
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Update and clean plugins
- `:checkhealth` - Diagnose configuration issues

### Development Workflow
- `nvim` - Start Neovim (plugins auto-install on first run)
- `:Tutor` - Built-in Neovim tutorial (recommended for new users)
- `:help` - Access comprehensive help system
- `<space>sh` - Search help documentation (via Telescope)

## Architecture and Structure

### Core Configuration Files
- `init.lua` - Main entry point, sets leader key and loads modules
- `lua/options.lua` - Neovim options and settings
- `lua/keymaps.lua` - Custom keybindings and autocommands
- `lua/lazy-bootstrap.lua` - Lazy.nvim plugin manager bootstrap
- `lua/lazy-plugins.lua` - Plugin specifications and setup

### Plugin Organization
The configuration uses a modular plugin system with three main directories:

1. **kickstart/plugins/** - Core plugins from kickstart.nvim
   - LSP configuration (`lspconfig.lua`)
   - Autocompletion (`blink-cmp.lua`)
   - Fuzzy finder (`telescope.lua`)
   - File tree (`neo-tree.lua`)
   - Git integration (`gitsigns.lua`)
   - Code formatting (`conform.lua`)
   - Syntax highlighting (`treesitter.lua`)

2. **custom/plugins/** - User-specific plugin customizations
   - File manager integration (`nnn.lua`)
   - Git workflow (`vim-fugitive.lua`)

3. **plugins/** - Additional plugins
   - AI coding assistant (`codecompanion.lua`)
   - Package manager (`mason.lua`)
   - Code generation tools (`aider.lua`)

### Key Features
- **Leader Key**: `<space>` (both leader and maplocalleader)
- **Plugin Manager**: Lazy.nvim with lazy loading
- **LSP**: Full Language Server Protocol support via mason.nvim
- **Completion**: Blink completion engine
- **File Navigation**: Telescope fuzzy finder + nnn file manager
- **Git Integration**: Gitsigns + vim-fugitive
- **AI Integration**: CodeCompanion with Anthropic adapter

### Custom Keybindings
- **Buffer Management**:
  - `<leader>bo` - Close other buffers
  - `<leader>bd` - Close current buffer  
  - `<leader>bn` - Open new buffer/tab
- **File Navigation**:
  - `<leader>e` - Open nnn in current file directory
  - `<leader>E` - Open nnn picker
  - `H`/`L` - Previous/next tab
- **Code Actions**:
  - `<leader>ca` - LSP code actions
  - `<leader>cd` - Show line diagnostics (focused)
- **Window Navigation**: `<C-hjkl>` for window switching

### Configuration Conventions
- Uses 2-space indentation (tabs=2, softtabs=2, shiftwidth=2)
- Nerd Font support enabled (`vim.g.have_nerd_font = true`)
- Auto-diagnostic display on cursor hold
- Disabled auto-commenting on new lines
- Clipboard integration with OS

## Important Notes
- This configuration targets latest stable/nightly Neovim only
- External dependencies: git, make, unzip, C compiler, ripgrep, fd-find
- The `lazy-lock.json` file tracks exact plugin versions
- Custom plugins should be added to `lua/custom/plugins/`
- All plugins use lazy loading for optimal startup performance
>>>>>>> 92d0ef5 (Claude.md and lazy-lock update)
