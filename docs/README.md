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
[![GitHub last commit](https://img.shields.io/github/last-commit/ConnerWill/dotfiles)](https://github.com/ConnerWill/dotfiles)
[![GitHub issues](https://img.shields.io/github/issues-raw/ConnerWill/dotfiles)](https://github.com/ConnerWill/dotfiles)
[![GitHub repo size](https://img.shields.io/github/repo-size/ConnerWill/dotfiles)](https://github.com/ConnerWill/dotfiles)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=mirrored)](https://gitlab.com/ConnerWill/dotfiles)
[![GitHub](https://img.shields.io/github/license/ConnerWill/dotfiles)](https://github.com/ConnerWill/dotfiles/blob/main/docs/LICENSE)
[![GitHub Repo stars](https://img.shields.io/github/stars/ConnerWill/dotfiles?style=social)](https://github.com/ConnerWill/dotfiles/stargazers)

</div>

---

## Installation

<details>
 <summary><b>Standard Installation</b></summary>

<br>

> **Clone this repository to use as your dotfiles**

```shell
git clone \
 --bare                                                    \
 --config status.showUntrackedFiles=no                     \
 --config core.excludesfile="${HOME}/.dotfiles/.gitignore" \
 --verbose --progress                                      \
 https://github.com/ConnerWill/dotfiles.git "${HOME}/.dotfiles"
```

> Then checkout the main branch and exec zsh

<div align="center">

```diff
- This will overwrite existing files! Make sure to backup first!
```
</div>

```shell
git --work-tree="${HOME}" --git-dir="${HOME}/.dotfiles" checkout --force main \
 && exec zsh
```

<br>

<details>
 <summary><b>Single Command</b></summary>

<br>

 <div align="center">


 ```diff
- This will overwrite existing files! Make sure to backup first!
```

 </div>

```shell

 clear \
 && export DOTFILES="${HOME}/.dotfiles" \
 && alias dotf='git --work-tree="${HOME}" --git-dir="${DOTFILES}"' \
 && git clone \
    --bare                                                    \
    --config status.showUntrackedFiles=no                     \
    --config core.excludesfile="${DOTFILES}/.gitignore"       \
    --verbose --progress                                      \
    https://github.com/ConnerWill/dotfiles.git "${DOTFILES}"  \
 && git --work-tree="${HOME}" --git-dir="${DOTFILES}" checkout --force main \
 && exec zsh

```

</details>

</details>

<details>
 <summary><b>Test dotfiles in Docker</b></summary>

<br>

> **Test full config in Docker**
```shell
git clone https://github.com/connerwill/dotfiles   \
  && docker run                                    \
    -v $PWD/dotfiles:/root                         \
    -it                                            \
    archlinux                                      \
    sh -c "ln -rs ~/.config/zsh/.zshenv ~/ && pacman -Sy --noconfirm zsh tmux git fzf bat lsd neovim && chsh --shell /usr/bin/zsh && exec zsh"
```

> **Test ZSH with no extra packages**
```shell
git clone https://github.com/connerwill/dotfiles   \
  && docker run                                    \
    -v $PWD/dotfiles:/root                         \
    -it                                            \
    archlinux                                      \
    sh -c "ln -rs ~/.config/zsh/.zshenv ~/ && pacman -Sy --noconfirm zsh && chsh --shell /usr/bin/zsh && exec zsh"
```

<br>

</details>

---

# Features

| Unchecked | Checked |
| --------- | ------- |
| &#9744;   | &#9745; |

# Contributing

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

-->
