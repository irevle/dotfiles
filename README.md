# dotfiles

Configuration files for [CachyOS](https://cachyos.org) + [Niri](https://github.com/YaLTeR/niri) + [Noctalia](https://github.com/levinit/noctalia).

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Usage

```bash
# Symlink everything into $HOME
stow bongocat fastfetch ghostty helix herdr niri noctalia yazi zsh

# Remove symlinks
stow -D bongocat fastfetch ghostty helix herdr niri noctalia yazi zsh
```

## Packages

| Package     | What it configures                                                  |
| ----------- | ------------------------------------------------------------------- |
| `bongocat`  | Bongo Cat typing overlay                                            |
| `fastfetch` | System info with custom cat ASCII art                               |
| `ghostty`   | Ghostty terminal + Noctalia theme                                   |
| `helix`     | Helix editor (theme, LSPs for HTML/JS/Python)                       |
| `herdr`     | Herdr agent environment (config, session state)                     |
| `niri`      | Niri compositor (keybinds, animations, layout, input, rules)        |
| `noctalia`  | Noctalia shell (bar, dock, control center, colorschemes, plugins)   |
| `yazi`      | Yazi file manager (tokyo-night, full-border)                        |
| `zsh`       | Zsh via Zinit, Starship prompt, completions, aliases                |
