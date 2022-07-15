<div align="center">
<!---
<img width="480" height="320" src="/media/cht-fzf-banner.png">
--->

### **cheat-fzf**
> *Browse UNIX/Linux Command Cheatsheets from [cht.sh](https://cht.sh)|[cheat.sh](https://cheat.sh) using [fzf](https://github.com/junegunn/fzf)*

![GitHub last commit](https://img.shields.io/github/last-commit/ConnerWill/cheat-fzf)
![GitHub issues](https://img.shields.io/github/issues-raw/ConnerWill/cheat-fzf)
![GitHub repo size](https://img.shields.io/github/repo-size/ConnerWill/cheat-fzf)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=mirrored)](https://gitlab.com/ConnerWill/cheat-fzf)
![GitHub](https://img.shields.io/github/license/ConnerWill/cheat-fzf)
![GitHub Repo stars](https://img.shields.io/github/stars/ConnerWill/cheat-fzf?style=social)

</div>

---

# Table of Contents
<details>
    <summary>Click to expand table of contents</summary>

  ---

* [<strong>cheat-fzf</strong>](https://github.com/ConnerWill/cheat-fzf)
* [Table of Contents](#table-of-contents)
* [Overview](#overview)
   * [Description](#description)
* [Installation](#installation)
   * [Dependencies](#dependencies)
   * [Setup](#setup)
* [Usage](#usage)
* [Other](#other)
   * [Contributing](#contributing)

  ---

  <p align=right>(<a href=#top>back to top</a>)</p>
</details>


# Overview
## Description

**Browse UNIX/Linux Command Cheatsheets from [cht.sh](https://cht.sh)|[cheat.sh](https://cheat.sh) using [fzf](https://github.com/junegunn/fzf)**


<!---
## Demo

<p align="right">(<a href="#top">back to top</a>)</p>
--->

# Installation
## Dependencies

*   **fzf**
*   **curl**

*Make [fzf](https://github.com/junegunn/fzf) is installed as it is the meat and potatoes of this script.*

## Setup

1. *Clone* this repository

  ```gitattributes
  git clone https://github.com/ConnerWill/cheat-fzf.git
  ```
  
2. To source this script, add the line below to your `.zshrc`|`.bashrc`|*etc...*
*Replace the example path to the location of **cheat-fzf***

>   zsh
  ```zsh
    [[ -f "${ZDOTDIR:-$HOME}/plugins/cheat-fzf/cht-fzf.sh" ]] && source "${ZDOTDIR:-$HOME}/plugins/cheat-fzf/cht-fzf.sh"
  ```

<p align="right">(<a href="#top">back to top</a>)</p>

# Usage

Once cht-fzf is sourced, you can start it by running either `cheat-fzf`, `cht-fzf`, or `chtfzf`

```shell-script
chtfzf
```
```shell-script
cht-fzf
```
```shell-script
cheat-fzf
```
---

If the script is run without a search query, and it will display the main screen of [cht.sh](https://cht.sh).

Running the command with a search query is will open the cheetsheet for that query.

Running the command with '*special flags*' will display those pages

---

> Example of running *`cht-fzf`* with the search query of *'fzf'* will open available cheetsheets for *'fzf'*. 
```shell-script
chtfzf fzf
```

> Example of running *`cht-fzf`* with the search query of '*`:list`*' will open all of the available cheetsheets in fzf. *(personal favorite)*
```shell-script
chtfzf :list
```
---

List of some of the available '*special pages*' in `cht.sh`
Visit [cht.sh](https://cht.sh/:help) for more information.

```yml
    Special pages:

        :help               this page
        :list               list all cheat sheets
        :post               how to post new cheat sheet
        :cht.sh             shell client (cht.sh)
        :bash_completion    bash function for tab completion
        :styles             list of color styles
        :styles-demo        show color styles usage examples
        :random             fetches a random cheat sheet
```

> *I suggest reading the [`fzf`](https://github.com/junegunn/fzf) and [`cheat.sh`](https://github.com/chubin/cheat.sh) documentation if you would like more information about those programs specifically*

<p align="right">(<a href="#top">back to top</a>)</p>

# Other

<!-- CONTRIBUTING -->
## Contributing

<details>
  <summary>Click to expand contributing section</summary>

  ---

Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

</details>

[fzf](https://github.com/junegunn/fzf)

[cheat.sh](https://github.com/chubin/cheat.sh)

[cht.sh](https://cht.sh)

<p align="right">(<a href="#top">back to top</a>)</p>
