# nvim

## Introduction

My modified version of kickstart.nvim configuration that is:

- a Full-fledged IDE environment
- Multi-file
- Documented (sort of)
- Modular

My configuration targets _only_ the latest ['stable'](https://github.com/neovim/neovim/releases/tag/stable) of Neovim. If you are experiencing issues, please make sure you have the latest versions.

Distribution Alternatives:

- [LazyVim](https://www.lazyvim.org/): A delightful distribution maintained by @folke (the author of lazy.nvim, the package manager used here)
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim): The original configuration

## Installation

Requirements:

Since this is for my personal use I use this configuration in conjunction with my [Pop!\_OS dotfiles]('https://github.com/umutondersu/dotfiles').

My dotfiles have all the necessary requirements to work with this configuration. However If you just want to use this configuration or have a non Ubuntu-based distribution/Windows the requirements should be like below:

- A nerd font
- curl
- gcc
- ripgrep
- unzip
- git
- xclip
- fd-find
- NodeJS v20 or higher
- npm
- A terminal that supports
  - truecolor
  - images (optional, if not snacks.image should be disabled)
- deno (optional for [peek.nvim](https://github.com/toppair/peek.nvim))
- Tmux (optional)
- uvx (optional for MCP Servers)
- gh (optional for `github autocompletion` and [octo.nvim](https://github.com/pwntester/octo.nvim))

See [Windows Installation](#Windows-Installation) if you have trouble with `telescope-fzf-native`

Neovim's configurations are located under the following paths, depending on your OS:

| OS                   | PATH                                      |
| :------------------- | :---------------------------------------- |
| Linux                | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| MacOS                | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)        | `%userprofile%\AppData\Local\nvim\`       |
| Windows (powershell) | `$env:USERPROFILE\AppData\Local\nvim\`    |

Clone the repository:

- on Linux and Mac

```sh
git clone https://github.com/umutondersu/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

- on Windows (cmd)

```
git clone https://github.com/umutondersu/nvim.git %userprofile%\AppData\Local\nvim\
```

- on Windows (powershell)

```
git clone https://github.com/umutondersu/nvim.git $env:USERPROFILE\AppData\Local\nvim\
```

## Post Installation

Start Neovim

```sh
nvim
```

The `Lazy` plugin manager will start automatically on the first run and install the configured plugins - as can be seen in the introduction video. After the installation is complete you can press `q` to close the `Lazy` UI and **you are ready to go**! Next time you run nvim `Lazy` will no longer show up.

If you would prefer to hide this step and run the plugin sync from the command line, you can use:

```sh
nvim --headless "+Lazy! sync" +qa
```

## Recommended Steps

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo (so that you have your own copy that you can modify) and then installing you can install to your machine using the methods above.

> **NOTE**  
> Your fork's URL will be something like this: `https://github.com/<your_github_username>/nvim.git`

## Configuration And Extension

- Inside of your copy, feel free to modify any file you like! It's your copy!
- For adding plugins, there are 3 primary options:
  - Add new configuration in `lua/custom/plugins/*` files, which will be auto sourced using `lazy.nvim` (uncomment the line importing the `custom/plugins` directory in the `init.lua` file to enable this)
  - Modify `init.lua` with additional plugins.
  - Include the `lua/kickstart/plugins/*` files in your configuration.

You can also merge updates/changes from the repo back into your fork, to keep up-to-date with any changes for the default configuration.

## Contribution

This configuration is mainly for my personal use but Pull-requests are welcome.

## FAQ

- What should I do if I already have a pre-existing neovim configuration?
  - You should back it up, then delete all files associated with it.
  - This includes your existing init.lua and the neovim files in `~/.local` which can be deleted with `rm -rf ~/.local/share/nvim/`
  - You may also want to look at the [migration guide for lazy.nvim](https://github.com/folke/lazy.nvim#-migration-guide)
- Can I keep my existing configuration in parallel to kickstart?
  - Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME` to maintain multiple configurations. For example you can install the kickstart configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative config directory and the matching local directory `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim distribution that you would like to try out.
- What if I want to "uninstall" this configuration:
  - See [lazy.nvim uninstall](https://github.com/folke/lazy.nvim#-uninstalling) information

## Windows Installation

I do not use windows so It might not work perfectly. I think the only problematic plugin is telescope-fzf-native used by dropbar.nvim plugin. You can either disable it or follow the steps below:

Installation may require installing build tools, and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake, and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
