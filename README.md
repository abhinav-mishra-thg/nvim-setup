## Installation:

Clone the repo in `~/.config/nvim/`

## Tmux Configuration

---

### 1. Install tmux (if not already installed)

```bash
# macOS
brew install tmux

# Ubuntu/Debian
sudo apt install tmux
```

### 2. Create tmux config file

Add the following to `~/.tmux.conf`:

```bash
set -g default-terminal "screen-256color"

unbind %
bind | split-window -h

unbind '"'
bind - split-window -v

unbind r
bind r source-file ~/.tmux.conf

bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5
bind -r h resize-pane -L 5

bind -r m resize-pane -Z

set -g mouse on

set-window-option -g mode-keys vi

bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'pbcopy' # copy text with "y"

unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode after dragging with mouse

# Enable clipboard integration for macOS
set -g set-clipboard on
set -as terminal-features ',*:clipboard'

# tpm plugin
set -g @plugin 'tmux-plugins/tpm'

# list of tmux plugins
set -g @plugin 'christoomey/vim-tmux-navigator' # for navigating panes and vim/nvim with Ctrl-hjkl
set -g @plugin 'jimeh/tmux-themepack' # to configure tmux theme
set -g @plugin 'tmux-plugins/tmux-resurrect' # persist tmux sessions after computer restart
set -g @plugin 'tmux-plugins/tmux-continuum' # automatically saves sessions for you every 15 minutes

set -g @themepack 'powerline/default/cyan' # use this theme for tmux

set -g @resurrect-capture-pane-contents 'on' # allow tmux-ressurect to capture pane contents
set -g @continuum-restore 'off' # disable automatic restore - use prefix + Ctrl-r to restore manually

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

### 3. Install TPM (Tmux Plugin Manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 4. Install tmux plugins

1. Start tmux: `tmux`
2. Press `prefix + I` (capital i, as in Install) to fetch and install plugins
3. Press `prefix + r` to reload tmux config

---

## Lazygit Configuration

### 1. Install lazygit

```bash
# macOS
brew install lazygit

# Ubuntu/Debian
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

### 2. Create nvim-edit wrapper script

Create the file `~/.local/bin/nvim-edit` with the following content:

```bash
#!/bin/bash

if [ -n "$NVIM" ]; then
    # Get absolute path of the file
    if [ -f "$1" ]; then
        filepath=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
    elif [ -n "$1" ]; then
        filepath="$1"
    else
        exit 0
    fi

    # Close the terminal (lazygit), then open the file in main window
    nvim --server "$NVIM" --remote-send "<C-\\><C-N>:q<CR>:e ${filepath}<CR>"
else
    # Fallback to regular nvim
    nvim "$@"
fi
```

Make it executable:

```bash
chmod +x ~/.local/bin/nvim-edit
```

### 3. Create lazygit config

Create the file `~/Library/Application Support/lazygit/config.yml` (macOS) or `~/.config/lazygit/config.yml` (Linux) with:

```yaml
customCommands:
  - key: 'o'
    context: 'files'
    description: 'open file in nvim'
    command: '$HOME/.local/bin/nvim-edit "{{.SelectedFile.Name}}"'
  - key: 'o'
    context: 'commitFiles'
    description: 'open file in nvim'
    command: '$HOME/.local/bin/nvim-edit "{{.SelectedCommitFile.Name}}"'
```

For macOS:
```bash
mkdir -p "$HOME/Library/Application Support/lazygit"
# Then create the config.yml file in that directory
```

For Linux:
```bash
mkdir -p ~/.config/lazygit
# Then create the config.yml file in that directory
```

### 4. Usage

- Open lazygit in Neovim with `<leader>lg`
- Press `o` on any file to open it in the main Neovim buffer (lazygit will close automatically)

---
