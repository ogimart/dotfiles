# Unix Development Environment — dotfiles

Terminal-first development environment with install and config files
for **macOS** and **Ubuntu**.

## Installation

```sh
cd ~ && git clone git@github.com:ogimart/dotfiles.git && cd dotfiles
./scripts/install.sh     # build deps, Homebrew, Brewfile packages, Rust
./scripts/stow-config.sh # symlink configs into ~ and ~/.config with stow
```

`install.sh` installs prerequisites (`Command Line Tools for Xcode` on macOS,
`build-essential` on Ubuntu), then Homebrew, then the packages in `Brewfile`,
followed by Rust installation.

Optionally, copy `git/.gitconfig.example` to `~/.gitconfig` and set your name
and email.

## Environment

| | |
|---|---|
| Editor | neovim |
| Shell | zsh |
| Terminal | ghostty, tmux |
| Languages | rust, c, c++, python, lisp, scheme |
| Build | cargo, make, cmake, ninja |
| Git | git-delta, lazygit |
| Utilities | fzf, ripgrep, fd, bat, eza, stow, mosh, rlwrap |
| LSP / Lint | rust-analyzer, clangd, ty, ruff, lua-language-server |
| Profiling | perf (linux), valgrind (linux) |
| VMs | lima |
| AI Agents | opencode, llama.cpp |

`gmake`, `tmux`, `lima` and `opencode` are installed on macOS only;
`ghostty` is commented out and assumed to be installed manually.

On Ubuntu, add `zsh` to `/etc/shells` and make it the default login shell:
```sh
sudo chsh -s $(which zsh) $USER
```
Log out and back in to apply.

## UI

* Theme: [Catppuccin Mocha](https://github.com/catppuccin)
* Font: [MonoLisa](https://www.monolisa.dev)

## License

[The Unlicense](LICENSE)
