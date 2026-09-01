# Unix Development Environment

Terminal-first development environment for macOS and Linux.

## Installation

```sh
cd ~ && git clone git@github.com:ogimart/dotfiles.git && cd dotfiles
./scripts/install.sh     # build deps, Homebrew, Brewfile packages, Rust
./scripts/stow-config.sh # symlink configs into ~ and ~/.config with stow
```

`install.sh` installs prerequisites (Xcode command line tools on macOS,
`build-essential` on Ubuntu), then Homebrew, then the packages in `Brewfile`,
followed by Rust installation.

Optionally, copy `git/.gitconfig.example` to `~/.gitconfig` and set your name
and email.

## Environment

| | |
|---|---|
| Editor | neovim |
| Shell | bash |
| Terminal | ghostty, tmux |
| Languages | rust, c, c++, python |
| Build | cmake, ninja, cargo |
| Git | git-delta, lazygit |
| Utilities | fzf, ripgrep, fd, tree, bat, stow |
| LSP / Lint | rust-analyzer, clangd, ruff, lua-language-server |
| Profiling | perf (linux), valgrind (linux) |
| VMs | lima |
| AI Agent | opencode |

`bash`, `tmux`, `lima` and `opencode` are installed on macOS only; `ghostty` is commented out and assumed to be installed manually.

## UI

* Theme: [Catppuccin Mocha](https://github.com/catppuccin)
* Font: [MonoLisa](https://www.monolisa.dev)

## License

[The Unlicense](LICENSE)
