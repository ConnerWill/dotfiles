<div align="center">

<!---<img width="480" height="320" src="/media/{{repo_name}}-banner.png">--->
  
  <img width="480" height="320" src="/media/banner.png">

# *neovim lua plugin boilerplate*
<!-- **{{repo_name}}** -->
  
> **Structure of a `neovim` plugin to make it easier to get started writing `neovim` plugins.**
<!-- > *[*{{repo_name}}*](https://example.com)* -->
  

  
![GitHub last commit](https://img.shields.io/github/last-commit/ConnerWill/{{repo_name}})
![GitHub issues](https://img.shields.io/github/issues-raw/ConnerWill/{{repo_name}})
![GitHub repo size](https://img.shields.io/github/repo-size/ConnerWill/{{repo_name}})
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=mirrored)](https://gitlab.com/ConnerWill/{{repo_name}})
![GitHub](https://img.shields.io/github/license/ConnerWill/{{repo_name}})
![GitHub Repo stars](https://img.shields.io/github/stars/ConnerWill/{{repo_name}}?style=social)

---
</div>

# Table of Contents
<details>
  <summary>Expand Table of Contents</summary>

  ---
  
* [{{repo_name}}](#{{repo_name}})
* [Table of Contents](#table-of-contents)
* [Overview](#overview)
  * [Description](##description)
  * [Demo](##demo)
* [Installation](#installation)
  * [Dependencies](##dependencies)
    * [Dependency-1-Installation](###dependency-1-installation)
  * [Setup](##setup)
* [Usage](#usage)
* [Customization](#customization)
  * [Configuration File](##configuration-file)
    * [Hotkeys](###hotkeys)
  * [Environment Variables](#environment-variables)
* [Other](#other)

  ---
  
<p align="right">(<a href="#top">back to top</a>)</p>

</details>  
  
# Overview

## Description

I forget the structure of a `neovim` plugin every single time. So I created the
boilerplate to make it easier to get started writing `neovim` plugin.

## Demo

[YouTube video](https://youtu.be/6ch28A_YICQ)

<p align="right">(<a href="#top">back to top</a>)</p>

# Installation

## Setup

1. Clone this repository

```console
git clone https://github.com/ConnerWill/{{repo_name}}.git
```
* clone the project `git clone https://github.com/s1n7ax/neovim-lua-plugin-boilerplate`
* go to the project folder `cd neovim-lua-plugin-boilerplate`
* start editing `nvim --cmd "set rtp+=."`
* reference the dev configurations `:luafile dev/init.lua`
* run the greetings.greet() function using `,w` keybind

## Dependencies

* dependency-1
* dependency-2

<p align="right">(<a href="#top">back to top</a>)</p>

# Usage

[More info](doc/presentation.md)


<p align="right">(<a href="#top">back to top</a>)</p>

# Customization

## Configuration File

### Hotkeys

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







## Environment Variables

> *(https://example.com)*

**```ENVVAR```**
: *<kbd>string</kbd>*
: environment variable description. 

**```ENVVAR2```**
: *<kbd>bool</kbd>*
: environment variable description.

**```ENVVAR3```**
: *<kbd>string</kbd>*
: environment variable description. 

**```ENVVAR4```**
: *<kbd>bool</kbd>*
: environment variable description.

<p align="right">(<a href="#top">back to top</a>)</p>


# Tables

### Large

<details>
  <summary>Expand Large Table</summary>

<!---
UPPERLEFT_TITLE="TEST"
UPPERLEFT_CONTENT="test"

UPPERMIDDLE_TITLE="TEST"
UPPERMIDDLE_CONTENT="TEST"

UPPERRIGHT_TITLE="TEST"
UPPERRIGHT_CONTENT="test"

LOWERLEFT_TITLE="TEST"
LOWERLEFT_CONTENT="test"

LOWERMIDDLE_TITLE="TEST"
LOWERMIDDLE_CONTENT="test"

LOWERRIGHT_TITLE="TEST"
LOWERRIGHT_CONTENT="test"
--->


<div align="center">

<table border="0" width="100%">
<col style="width:33%">
<col style="width:33%">
<col style="width:33%">
<tbody>
<tr style="border: 0px !important;">
<td valign="top" style="border: 0px !important;"><b>$UPPERLEFT_TITLE</b>$UPPERLEFT_CONTENT</td>
<td valign="top" style="border: 0px !important;"><b>$UPPERMIDDLE_TITLE</b>$UPPERMIDDLE_CONTENT</td>
<td valign="top" style="border: 0px !important;"><b>$UPPERRIGHT_TITLE</b>$UPPERRIGHT_CONTENT</td>
</tr>
<tr style="border: 0px !important;">
<td valign="top" style="border: 0px !important;"><b>$LOWERLEFT_TITLE</b>$LOWERLEFT_CONTENT</td>
<td valign="top" style="border: 0px !important;"><b>$LOWERMIDDLE_TITLE</b>$LOWERMIDDLE_CONTENT</td>
<td valign="top" style="border: 0px !important;"><b>$LOWERRIGHT_TITLE</b>$LOWERRIGHT_CONTENT</td></tr>
</tbody>
</table>

</div>

<p align="right">(<a href="#top">back to top</a>)</p>

</details>  


### Small

<details>
  <summary>Expand Small Table</summary>


<div align="center">

| xxh-shell                            | status    | [something](https://example.com)                                                     | demo |   |
|--------------------------------------|-----------|--------------------------------------------------------------------------------------|------|---|
| **[something](https://example.com)   | `content` | <a href="https://asciinema.org/a/osSEzqnmH9pMYEZibNe2K7ZL7" target="_blank">demo</a> |      |   |
| **[something](https://example.com)   | `content` | <a href="https://asciinema.org/a/rCiT9hXQ5IdwqOwg6rifyFZzb" target="_blank">demo</a> |      |   |
| **[something](https://example.com)   |           |                                                                                      |      |   |
| **[something](https://example.com)   | `content` | <a href="https://asciinema.org/a/314508" target="_blank">demo</a>                    |      |   |
| **[something](https://example.com)** | beta      |                                                                                      |      |   |
| **[something](https://example.com)** | alpha     |                                                                                      |      |   |
| **[something](https://example.com)** | alpha     |                                                                                      |      |   |


</div>

<p align="right">(<a href="#top">back to top</a>)</p>

</details>  



# Other

<p align="right">(<a href="#top">back to top</a>)</p>

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

<p align="right">(<a href="#top">back to top</a>)</p>

</details>  

---

<div align="center">
### **{{repo_name}}** 
  
> *Bottom Text*
  
---
</div>

