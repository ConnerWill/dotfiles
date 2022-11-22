<div align="justify">
 <div align="center">
  <img src="/docs/assets/nvim-screenshot.jpg">

# **ｎｅｏｖｉｍ**

> *NeoVim configuration*

```ocaml
NVIM / LUA
```

![GitHub last commit](https://img.shields.io/github/last-commit/ConnerWill/dotfiles)
![GitHub issues](https://img.shields.io/github/issues-raw/ConnerWill/dotfiles)
![GitHub repo size](https://img.shields.io/github/repo-size/ConnerWill/dotfiles)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=mirrored)](https://gitlab.com/ConnerWill/dotfiles)
![GitHub](https://img.shields.io/github/license/ConnerWill/dotfiles)
![GitHub Repo stars](https://img.shields.io/github/stars/ConnerWill/dotfiles?style=social)

</div>

---

## Installation

> *Clone this repository*
```console
git clone https://github.com/ConnerWill/dotfiles.git
```

***

> *Test full config in docker*
```shell
git clone https://github.com/connerwill/dotfiles   \
  && docker run                                    \
    -v $PWD/dotfiles:/root                         \
    -it                                            \
    archlinux                                      \
    sh -c "ln -rs ~/.config/zsh/.zshenv ~/ && pacman -Syv --noconfirm zsh git fzf luacheck editorconfig-checker selene-linter shellcheck neovim && nvim -c ":PackerSync"
```

> *Test full config in docker*
```shell
docker run -it archlinux \
    sh -c "ln -rs ~/.config/zsh/.zshenv ~/ && pacman -Syv --noconfirm zsh git fzf luacheck editorconfig-checker selene-linter shellcheck neovim && --bare --config status.showUntrackedFiles=no --verbose --progress https://github.com/ConnerWill/dotfiles.git ~/.dotfiles && git --work-tree=$HOME --git-dir=~/.dotfiles checkout --force main && nvim -c ':PackerSync'"
```




***

<p align="right">
  [<a href="https://gitlab.com/ConnerWill/dotfiles">GitLab Mirror</a>]
</p>

---

 <div align="center">


<img src="/docs/assets/nvim-screenshot.jpg">

| ![lf screenshot](https://user-images.githubusercontent.com/10108377/140654098-bafadfdf-76d9-43ac-87b9-e42308ea11a3.png) | ![zsh screenshot](https://user-images.githubusercontent.com/10108377/140654211-2bd25f1a-2677-4cf7-ab2e-d043e65e40e5.png) | ![fzf screenshot](https://user-images.githubusercontent.com/10108377/140654357-1bc87a9c-b395-458c-81d4-ce992c589fac.png) |
| ----------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ |

</div>

# Table of Contents

<br>


<details>
 <summary><b>Table of Contents</b></summary>

  ---

* [ｎｅｏｖｉｍ](#ｎｅｏｖｉｍ)
* [Table of Contents](#table-of-contents)
* [Overview](#overview)
  * [Description](##description)
  * [ScreenShots](##screenshots)
  * [Demo](##demo)
* [Installation](#installation)
  * [Setup](##setup)
* [Usage](#usage)
* [Customization](#customization)
  * [Configuration Files](##configuration-files)
    * [Hotkeys](###hotkeys)
* [Other](#other)

  ---

</details>


# Overview

## Description


## ScreenShots


## Demo

<div align="center"><img width="1190" height="780" src="assets/replace-placeholders-demo.gif"></div>

# Usage

<p align="right">(<a href="#top">back to top</a>)</p>

# Customization

## Configuration Files

### Hotkeys


<!--
<kbd>CTRL</kbd>
<kbd>ALT</kbd>
<kbd>SHIFT</kbd>
<kbd>CAPSLOCK</kbd>
<kbd>ENTER</kbd>
<kbd>RETURN</kbd>
<kbd>FN</kbd>
<kbd>~</kbd>
<kbd>TAB</kbd>
<kbd>F1</kbd>
<kbd>BACKSPACE</kbd>
<kbd>HOME</kbd>
<kbd>END</kbd>
<kbd>PgUp</kbd>
<kbd>PgDn</kbd>
<kbd>INSERT</kbd>
<kbd>DELETE</kbd>
<kbd>DEL</kbd>
<kbd>`CTRL`</kbd>
<kbd>```CTRL```</kbd>
<kbd>`↓`</kbd>
<kbd>`←`</kbd>
<kbd>`→`</kbd>
<kbd>`↑`</kbd>
*<kbd>`</kbd>*
-->

# Other

<div align="center">
  <details>
    <summary>Click to expand contributing section</summary>

## Contributing

---

Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

  <p align="right">(<a href="#top">back to top</a>)</p>
</details>

</div>

---

<footer>
 <nav data-content="bottom">
  <div align="center">
   <div id="foot">
    <span id="bottom">
     <p>
     <strong>
dotfiles
     </strong>
     </p>
    </span>
   </div>
   <div id="foot2">
    <span id="bottom2">
     <p>
     <strong>
dotfiles
     </strong>
     </p>
    </span>
   </div>
  </div>
 </nav>
</footer>

> *Bottom Text*
</div>
