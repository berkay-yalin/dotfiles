# dotfiles

trying to figure out how VimScript works

## Software

| Software                                                  | Source Code                                      |
|-----------------------------------------------------------|--------------------------------------------------|
| [a-Shell](https://holzschu.github.io/a-Shell_iOS/)        | <https://github.com/holzschu/a-shell>            |
| [AutoHotKey](https://autohotkey.com/)                     | <https://github.com/AutoHotkey/AutoHotkey>       |
| [Bash](https://www.gnu.org/software/bash/)                | <https://git.savannah.gnu.org/cgit/bash.git>     |
| [Git](https://git-scm.com/)                               | <https://git.kernel.org/pub/scm/git/git.git>     |
| [JPEGView](https://github.com/sylikc/jpegview)            | <https://github.com/sylikc/jpegview>             |
| [Karabiner-Elements](https://karabiner-elements.pqrs.org) | <https://github.com/pqrs-org/Karabiner-Elements> |
| [Neovim](https://neovim.io/)                              | <https://github.com/neovim/neovim>               |
| [PowerShell](https://microsoft.com/PowerShell)            | <https://github.com/PowerShell/PowerShell>       |
| [tmux](https://tmux.github.io/)                           | <https://github.com/tmux/tmux>                   |
| [Vifm](https://vifm.info/)                                | <https://github.com/vifm/vifm>                   |
| [Visual Studio Code](https://code.visualstudio.com/)      | <https://github.com/microsoft/vscode>            |
| [WezTerm](https://wezfurlong.org/wezterm/index.html)      | <https://github.com/wez/wezterm>                 |
| [zsh](https://www.zsh.org)                                | <https://github.com/zsh-users/zsh>               |

## Neovim Plugins

- [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim)
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [romgrk/barbar.nvim](https://github.com/romgrk/barbar.nvim)
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [junegunn/fzf](https://github.com/junegunn/fzf)
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [m-demare/hlargs.nvim](https://github.com/m-demare/hlargs.nvim)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)

## Set up MacOS

### homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### git

note: git should be installed through xcode

```bash
git config --global user.name "ostromia"

git config --global user.email "66202981+ostromia@users.noreply.github.com"

brew install gh

gh auth login
```

### dotfiles

```bash
mkdir GitHub

git clone https://github.com/ostromia/dotfiles.git "$HOME/GitHub/dotfiles"

# zsh
cp -f "$HOME/GitHub/dotfiles/zsh/.zshrc" "$HOME/.zshrc"

# git
cp -f "$HOME/GitHub/dotfiles/git/.gitconfig/" "$HOME/.gitconfig"

# vscode
cp -f "$HOME/GitHub/dotfiles/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

cp -f "$HOME/GitHub/dotfiles/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

# nvim
rsync -av --delete "$HOME/GitHub/dotfiles/nvim" "$HOME/.config/"

# wezterm
cp -f "$HOME/GitHub/dotfiles/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"
```

## Set up Windows 11

personal notes on automating the installation and configuration of certain software on Windows 11

### setup user folders

probably shouldnt be doing this but it works :/

```powershell
rm ~\Documents\ -Recurse -Force
cmd.exe /c "mklink /J C:\Users\berka\Documents C:\Users\berka\OneDrive\Documents"

rm ~\Music\ -Recurse -Force
cmd.exe /c "mklink /J C:\Users\berka\Music C:\Users\berka\OneDrive\Music"

rm ~\Pictures\ -Recurse -Force
cmd.exe /c "mklink /J C:\Users\berka\Pictures C:\Users\berka\OneDrive\Pictures"

rm ~\Videos\ -Recurse -Force
cmd.exe /c "mklink /J C:\Users\berka\Videos C:\Users\berka\OneDrive\Videos"
```

### 1 install PowerShell
```powershell
winget install -e --id Microsoft.Powershell
```

### 2 install and configure Git
```powershell
winget install -e --id Git.Git
git config --global user.email "66202981+berkay-yalin@users.noreply.github.com"
git config --global user.name "berkay-yalin"
winget install -e --id GitHub.cli
gh auth login
```

### 3.1 clone dotfiles repository
```powershell
mkdir ~/GitHub/
git clone https://github.com/berkay-yalin/dotfiles.git C:\Users\berka\GitHub\dotfiles
```

### 3.2 replace Windows Terminal with WezTerm
```powershell
winget install wez.wezterm
copy-item -path ~\GitHub\dotfiles\wezterm\.wezterm.lua -destination ~\.wezterm.lua
winget uninstall -e --id Microsoft.WindowsTerminal
```

### 3.3 install and configure Neovim
```powershell
winget install Neovim.Neovim
copy-item -path ~\GitHub\dotfiles\nvim -destination ~\AppData\Local\nvim -recurse
```

```powershell
# install vim-plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
# install plugins
nvim -c ":PlugInstall" -c ":qa"
```

```powershell
# install open-with-nvim.exe
$url = "https://api.github.com/repos/berkay-yalin/open-with-nvim/releases/latest"
Invoke-WebRequest -Uri ((Invoke-RestMethod -Uri $url).assets[0].browser_download_url) -OutFile ~\AppData\Local\nvim-data\open-with-nvim.exe
```

### 3.4 install and configure Visual Studio Code
```powershell
winget install -e --id Microsoft.VisualStudioCode
# open vscode for a second to create the Code folder in AppData
code; Start-Sleep -Seconds 1; Stop-Process -Name "Code"
copy-item ~\GitHub\dotfiles\vscode\settings.json ~\AppData\Roaming\Code\User\settings.json
copy-item ~\GitHub\dotfiles\vscode\keybindings.json ~\AppData\Roaming\Code\User\keybindings.json
```

### 3.5 install and configure JPEGView
```powershell
winget install -e --id sylikc.JPEGView
copy-item -path ~\GitHub\dotfiles\JPEGView\JPEGView.ini -destination ~\AppData\Roaming\JPEGView\JPEGView.ini
```

### 3.6 install Python
```powershell
winget install -e --id Python.Python.3.11
```

### 3.7 install node.js
```powershell
winget install Schniz.fnm
fnm env --use-on-cd | Out-String | Invoke-Expression
fnm use --install-if-missing 22
```

