<div align="justify">
 <div align="center">
  <img src="/docs/assets/nvim-screenshot.jpg">

| ![lf screenshot](https://user-images.githubusercontent.com/10108377/140654098-bafadfdf-76d9-43ac-87b9-e42308ea11a3.png) | ![zsh screenshot](https://user-images.githubusercontent.com/10108377/140654211-2bd25f1a-2677-4cf7-ab2e-d043e65e40e5.png) | ![fzf screenshot](https://user-images.githubusercontent.com/10108377/140654357-1bc87a9c-b395-458c-81d4-ce992c589fac.png) |
| ----------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ |

# **ｄｏｔｆｉｌｅｓ**

> *My Personal dotfiles*

```ocaml
ＺＳＨ  /  ＮＶＩＭ  /  ＴＭＵＸ  /  ＡＷＥＳＯＭＥＷＭ
```

[![shellcheck](https://github.com/ConnerWill/dotfiles/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/ConnerWill/dotfiles/actions/workflows/shellcheck.yml)
[![Test ZSH Configuration](https://github.com/ConnerWill/dotfiles/actions/workflows/zsh-test.yml/badge.svg)](https://github.com/ConnerWill/dotfiles/actions/workflows/zsh-test.yml)
[![Test Dotfiles Installation](https://github.com/ConnerWill/dotfiles/actions/workflows/install-test.yml/badge.svg)](https://github.com/ConnerWill/dotfiles/actions/workflows/install-test.yml)

[![GitHub last commit](https://img.shields.io/github/last-commit/ConnerWill/dotfiles)](https://github.com/ConnerWill/dotfiles)
[![GitHub issues](https://img.shields.io/github/issues-raw/ConnerWill/dotfiles)](https://github.com/ConnerWill/dotfiles)
[![GitHub repo size](https://img.shields.io/github/repo-size/ConnerWill/dotfiles)](https://github.com/ConnerWill/dotfiles)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=mirrored)](https://gitlab.com/ConnerWill/dotfiles)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://github.com/ConnerWill/dotfiles/blob/main/docs/LICENSE)
[![GitHub Repo stars](https://img.shields.io/github/stars/ConnerWill/dotfiles?style=social)](https://github.com/ConnerWill/dotfiles/stargazers)

</div>

---

## Documentation

Individual configurations have their own documentation:

- [**ZSH**](/.config/zsh/docs/README.md) — modular shell config, custom functions, plugins, and toggles
- [**Neovim**](/.config/nvim/README.md) — LazyVim-based editor setup, plugins, and colorschemes

---

## Installation

### Install Script

[`install-dotfiles.sh`](/.config/zsh/install-dotfiles.sh)

```bash
curl --silent -L "https://raw.githubusercontent.com/ConnerWill/dotfiles/refs/heads/main/.config/zsh/install-dotfiles.sh" | bash
```

### Standard Installation

```shell
git clone \
 --bare                                                    \
 --config status.showUntrackedFiles=no                     \
 --config core.excludesfile="${HOME}/.dotfiles/.gitignore" \
 --verbose --progress                                      \
 https://github.com/ConnerWill/dotfiles.git "${HOME}/.dotfiles"
```

```diff
- This will overwrite existing files! Make sure to backup first!
```

```shell
git --work-tree="${HOME}" --git-dir="${HOME}/.dotfiles" checkout --force main \
 && git --work-tree="${HOME}" --git-dir="${HOME}/.dotfiles" -C "${HOME}" submodule update --init --recursive \
 && exec zsh
```

---

## Test dotfiles With Docker

### Docker Run

```bash
docker run -it --rm archlinux bash -c 'curl --silent -L "https://raw.githubusercontent.com/ConnerWill/dotfiles/refs/heads/main/.config/zsh/install-dotfiles.sh" | DOTFILES_ASSUME_YES=1 bash ; exec zsh'
```

### Dockerfile

```bash
# Clone dotfiles as a normal repository
git clone --recurse-submodules https://github.com/connerwill/dotfiles.git ./connerwill-dotfiles

# Move into cloned repository
cd ./connerwill-dotfiles

# Move to ZSH configuration directory
cd "$(git rev-parse --show-toplevel)/.config/zsh"

# Build Dockerfile
docker build --tag connerwill-dotfiles-zsh:latest .

# Run the Docker container
docker run        \
    --rm          \
    --interactive \
    --tty         \
    connerwill-dotfiles-zsh:latest
```

---

## Dotfiles Manager (dotf)

- [dotf](https://github.com/connerwill/dotf)

---

## Plugin Manager (zplugin)

- [zplugin](/.config/zsh/zsh/user/functions/functions-manual/zplugin/docs/README.md)

---

## Contributing

<details>
  <summary>Click to expand contributing section</summary>

---

Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b AmazingFeature`)
3. Commit your Changes (`git commit -m 'Added some AmazingFeature'`)
4. Push to the Branch (`git push origin AmazingFeature`)
5. Open a Pull Request

</details>

---

<div align="center">

```ocaml
░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀
░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█
░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀
```

</div>

<!--

## ZSH

<div align="center">

```ocaml

┍────────────────────────────────────────────────┐
│         ███▀▀▀███▄█▀▀▀█▄█████▀  ▀████▀▀        │
│          █▀   ███▄██    ▀█ ██      ██          │
│          ▀   ███ ▀███▄     ██      ██          │
│             ███    ▀█████▄ ██████████          │
│            ███   ▄     ▀██ ██      ██          │
│           ███   ▄██     ██ ██      ██          │
│         █████████▀█████▀▄████▄  ▄████▄▄        │
├────────────────────────────────────────────────┤
│ ░░░▒▒▒▓▓▓███ ＺＳＨ ＣＯＮＦＩＧ ███▓▓▓▒▒▒░░░░  │
└────────────────────────────────────────────────┘

```

</div>


| Unchecked | Checked |
| --------- | ------- |
| &#9744;   | &#9745; |

-->
