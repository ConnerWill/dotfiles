# copier

[![License](https://img.shields.io/badge/license-MIT-007EC7)](/LICENSE)
[![built for](https://img.shields.io/badge/built%20for-%20%F0%9F%A6%93%20zshzoo-black)][zshzoo]

> Clipboard utilities

## Description

[Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh) clipboard utilites as a plugin.

| command    | description                                                  |
| ---------- | ------------------------------------------------------------ |
| clipcopy   | Copy from the command line                                   |
| clippaste  | Paste to the command line                                    |
| copydir    | Copy the path of the current directory to the clipboard      |
| copyfile   | Copy the contents of a file to the clipboard                 |
| copybuffer | Copy the current command buffer to the clipboard with CTRL-o |

## Installation

### Install with a Zsh plugin manager

To install using a Zsh plugin manager, add the following to your .zshrc

- [pz]: `pz source zshzoo/copier`
- [zcomet]: `zcomet load zshzoo/copier`
- [zgenom]: `zgenom load zshzoo/copier`
- [znap]: `znap source zshzoo/copier`

### Install manually, without a plugin manager

To install manually, first clone the repo:

```zsh
git clone https://github.com/zshzoo/copier ${ZDOTDIR:-~}/.zplugins/copier
```

Then, in your .zshrc, add the following line:

```zsh
source ${ZDOTDIR:-~}/.zplugins/copier/copier.zsh
```

[zshzoo]: https://github.com/zshzoo/zshzoo
[pz]: https://github.com/mattmc3/pz
[zcomet]: https://github.com/agkozak/zcomet
[zgenom]: https://github.com/jandamm/zgenom
[znap]: https://github.com/marlonrichert/zsh-snap
