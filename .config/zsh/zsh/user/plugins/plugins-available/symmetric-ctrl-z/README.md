# symmetric-ctrl-z

[![License](https://img.shields.io/badge/license-MIT-007EC7)](/LICENSE)
[![built for](https://img.shields.io/badge/built%20for-%20%F0%9F%A6%93%20zshzoo-black)][zshzoo]
[![works with prezto](https://img.shields.io/badge/works%20with-%E2%9D%AF%E2%9D%AF%E2%9D%AF%20prezto-red)](#install-for-prezto)

> This plugin allows you to use CTRL-z to bring background processes back to the
foreground

## Description

Based on [fancy-ctrl-z](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fancy-ctrl-z).

## Installation

### Install with a Zsh plugin manager

To install using a Zsh plugin manager, add the following to your .zshrc

- [pz]: `pz source zshzoo/symmetric-ctrl-z`
- [zcomet]: `zcomet load zshzoo/symmetric-ctrl-z`
- [zgenom]: `zgenom load zshzoo/symmetric-ctrl-z`
- [znap]: `znap source zshzoo/symmetric-ctrl-z`

### Install manually, without a plugin manager

To install manually, first clone the repo:

```zsh
git clone https://github.com/zshzoo/symmetric-ctrl-z ${ZDOTDIR:-~}/.zplugins/symmetric-ctrl-z
```

Then, in your .zshrc, add the following line:

```zsh
source ${ZDOTDIR:-~}/.zplugins/symmetric-ctrl-z/symmetric-ctrl-z.zsh
```

### Install for Prezto

To install with [Prezto][prezto], first clone the repo from an interactive Zsh session:

```zsh
# make sure your $ZPREZTODIR is set
ZPREZTODIR=${ZPREZTODIR:-~/.zprezto}
# clone the repo to a prezto contrib dir
git clone https://github.com/zshzoo/symmetric-ctrl-z $ZPREZTODIR/contrib/symmetric-ctrl-z/external
# set up the contrib
echo "source \${0:A:h}/external/symmetric-ctrl-z.plugin.zsh" > $ZPREZTODIR/contrib/symmetric-ctrl-z/init.zsh
```

Then, add the plugin to your Prezto plugins list in .zpreztorc

```zsh
zstyle ':prezto:load' pmodule \
  ... \
  symmetric-ctrl-z \
  ...
```

[ohmyzsh]: https://github.com/ohmyzsh/ohmyzsh
[prezto]: https://github.com/sorin-ionescu/prezto
[zshzoo]: https://github.com/zshzoo/zshzoo
[pz]: https://github.com/mattmc3/pz
[zcomet]: https://github.com/agkozak/zcomet
[zgenom]: https://github.com/jandamm/zgenom
[znap]: https://github.com/marlonrichert/zsh-snap
