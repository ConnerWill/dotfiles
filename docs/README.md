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
 --recurse-submodules                                      \
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
    --recurse-submodules                                      \
    https://github.com/ConnerWill/dotfiles.git "${DOTFILES}"  \
 && git --work-tree="${HOME}" --git-dir="${DOTFILES}" checkout --force main \
 && exec zsh

```

Installation Script (`base64`)

```bash
echo 'IyEvdXNyL2Jpbi9lbnYgYmFzaAoKc2V0IC1lCgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgUmVwb3NpdG9yeSBVUkxzIGFuZCBEaXJlY3RvcmllcwojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRPVEZJTEVTX1JFUE89Imh0dHBzOi8vZ2l0aHViLmNvbS9Db25uZXJXaWxsL2RvdGZpbGVzLmdpdCIKRE9URklMRVNfRElSPSIke0hPTUV9Ly5kb3RmaWxlcyIKRE9URl9SRVBPPSJodHRwczovL2dpdGh1Yi5jb20vQ29ubmVyV2lsbC9kb3RmLmdpdCIKRE9URl9ESVI9IiR7WlNIX0ZVTkNUSU9OU19NQU5VQUw6LSR7WERHX0NPTkZJR19IT01FOi0ke0hPTUV9Ly5jb25maWd9L3pzaC96c2gvdXNlci9mdW5jdGlvbnMvZnVuY3Rpb25zLW1hbnVhbC9kb3RmfSIKVkVSQk9TRT0xCgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgRnVuY3Rpb246IHNob3dfYXNjaWlfaGVsbG8KIyBEZXNjcmlwdGlvbjogRGlzcGxheXMgYW4gQVNDSUkgYXJ0IGJhbm5lciB3aXRoIHJlcG9zaXRvcnkgaW5mb3JtYXRpb24uCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KZnVuY3Rpb24gc2hvd19hc2NpaV9oZWxsbygpewogIHByaW50ZiAiXHgxQlswOzE7NDszODs1OzIwMW0iCiAgY2F0IDw8RU9BCkBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQApFT0EKICBwcmludGYgIlx4MUJbMDsxOzM7Mzg7NTs1MW0iCiAgY2F0IDw8RU9CCi4gICAgICAgICAgICAgICAgJHtET1RGX1JFUE99ICAgICAgICAgICAgICAgICAgIC4KRU9CCiAgcHJpbnRmICJceDFCWzA7MTs0OzM4OzU7MjAxbSIKICBjYXQgPDxFT0MKQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBACkVPQwogIHByaW50ZiAiXHgxQlswOzM4OzU7NTdtIgogIGNhdCA8PEVPQgouICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4KLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuCi4gICAgICAgICAgICAgICAgICAgICAuLSs9PT09PT09LS0tOjouLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLgouICAgICAgICAgICAgICAgICAgIDo9KyMjQEBAQEBAQEBAQEBAQCVAQEAjLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4KLiAgICAgICAgICAgICAgICAuPToqPUAjQEBAQEBAJUBAQEBAQEBAQEBAQCUrLiAgICAgIC4uICAgICAgICAgICAgICAgICAgICAuCi4gIC4uLjo6Li4gICAgLjorLio9JSUlQEBAQEBAKiVAQEBAQEBAQEBAQEBAJSMtLiAgICAuLiAgICAgICAgICAgICAgICAgICAgLgouIC4lQEBAJSUlJSotLT0uPSorQCNAQEBAQEBAQD0jQEBAQEBAQEBAQEBAQEBAIyMtLjouLjogICAgICAgICAgICAgICAgICAgIC4KLiAqQEBAQEBAQEBAQEBAQD0lQCMjJSUjIyMjIyorJSUjJSUlJSUlJSUlJSVAQEBAKiUjQCUlIyorPTouLiAgICAgICAgICAgICAuCi49JSMuLi4uLi4uLi4uLi4uLi4uLi4uLjo6Ojo6OjotLTotKyNAQEBAQEBAQEBAQEBAIyolQEBAQEAlJSMrPSsqKzouICAgICAgLgouI0BAKj0tOi06Oi4tQEAjKiolQEAtLiAgICAgICArJSUuICAgIC4uLi4gLiAuLi4uLi4uLi4uLi4uLi46LT0rIyVAQCUrOi4gIC4KLi4jJUBAQEBAQEAlKkBAQEBAQEBAPS4jQEBAQCVAQEBAQEBAJSUlJSUjIyMqPTotOi4uLi4uLiAgLiMlJSMjJT0uICAgIC46PS4uCiMlIyMjKiorKysrQEBAQCs6Oi0jQEBAOi0tLT09KysqKiojIyMlJSUlQEBAQEBAIyUqQEBAQEBAOipAQEBAQEAjKyUlKz09I0AuLgo9QEBAQEBAQEBAQEBAKi4gICAgIDpAQEBAQEBAQEBAQCUlJSUlIyMqKioqKysrPS0tLTo6Oi4uOkBAQCUtOj1AQEAtOjo6Oi4uLi4KLj0jKisrQEBAQEBAQC4gOkBAJS4gPUBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQD0gICAgLipAQEBAQEBAQEAtCi4gIC46PSMlQEBAQCUuID1AQEA6ID1AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQCMuLkBAPS46QEBAQEBAQEA6LgouICAgICAgICAgIC5APSAgLjouIC4lJSsrOi4uOjo6Ojo6Ojo6LS0tLS0tLS09PT0jJSUlJSUlJUAjLi4lQC0uOkAlJSUlJT0gIC4KLiAgICAgICAgICAgLiUjOi4gLj1AJS4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtQCsgICAgLioqLiAgICAgICAuCi4gICAgICAgICAgICAuOiNAQEAjLS4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC1AQCs9KkArLiAgICAgICAgLgouICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4tLTouICAgICAgICAgIC4KRU9CCiAgcHJpbnRmICJceDFCWzA7MTs0OzM4OzU7MjAxbSIKICBjYXQgPDxFT0EKQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBACkVPQQogIHByaW50ZiAiXHgxQlswbSIKICBzbGVlcCAxCn0KCgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgRnVuY3Rpb246IHNob3dfYXNjaWlfZ29vZGJ5ZQojIERlc2NyaXB0aW9uOiBEaXNwbGF5cyBhbiBBU0NJSSBhcnQgZ29vZGJ5ZQojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCmZ1bmN0aW9uIHNob3dfYXNjaWlfZ29vZGJ5ZSgpewogIHByaW50ZiAiXHgxQlswOzE7NDszODs1OzIwMW0iCiAgY2F0IDw8RU9BCkBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQApFT0EKICBwcmludGYgIlx4MUJbMDsxOzM4OzU7NDZtIgogIGNhdCA8PEVPQQorLS0tLS0tKy4gICAgICArLS0tLS0tKyAgICAgICArLS0tLS0tKyAgICAgICArLS0tLS0tKyAgICAgIC4rLS0tLS0tKwp8XGAuICAgIHwgXGAuICAgIHxcICAgICB8XCAgICAgIHwgICAgICB8ICAgICAgL3wgICAgIC98ICAgIC4nIHwgICAgLid8CnwgIFxgKy0tKy0tLSsgICB8ICstLS0tKy0rICAgICArLS0tLS0tKyAgICAgKy0rLS0tLSsgfCAgICstLS0rLS0rJyAgfAp8ICAgfCAgfCAgIHwgICB8IHwgICAgfCB8ICAgICB8ICAgICAgfCAgICAgfCB8ICAgIHwgfCAgIHwgICB8ICB8ICAgfAorLS0tKy0tKy4gIHwgICArLSstLS0tKyB8ICAgICArLS0tLS0tKyAgICAgfCArLS0tLSstKyAgIHwgIC4rLS0rLS0tKwogXGAuIHwgICAgXGAufCAgICBcfCAgICAgXHwgICAgIHwgICAgICB8ICAgICB8LyAgICAgfC8gICAgfC4nICAgIHwgLicKICAgXGArLS0tLS0tKyAgICAgKy0tLS0tLSsgICAgICstLS0tLS0rICAgICArLS0tLS0tKyAgICAgKy0tLS0tLSsnCkVPQQogIHByaW50ZiAiXHgxQlswOzE7MzszODs1OzIwMW0iCiAgY2F0IDw8RU9CCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR09PREJZRSA6KQpFT0IKICBwcmludGYgIlx4MUJbMDsxOzM4OzU7NDZtIgogIGNhdCA8PEVPQwogICAuKy0tLS0tLSsgICAgICstLS0tLS0rICAgICArLS0tLS0tKyAgICAgKy0tLS0tLSsgICAgICstLS0tLS0rLgogLicgfCAgICAuJ3wgICAgL3wgICAgIC98ICAgICB8ICAgICAgfCAgICAgfFwgICAgIHxcICAgIHxcYC4gICAgfCBcYC4KKy0tLSstLSsnICB8ICAgKy0rLS0tLSsgfCAgICAgKy0tLS0tLSsgICAgIHwgKy0tLS0rLSsgICB8ICBcYCstLSstLS0rCnwgICB8ICB8ICAgfCAgIHwgfCAgICB8IHwgICAgIHwgICAgICB8ICAgICB8IHwgICAgfCB8ICAgfCAgIHwgIHwgICB8CnwgICwrLS0rLS0tKyAgIHwgKy0tLS0rLSsgICAgICstLS0tLS0rICAgICArLSstLS0tKyB8ICAgKy0tLSstLSsgICB8CnwuJyAgICB8IC4nICAgIHwvICAgICB8LyAgICAgIHwgICAgICB8ICAgICAgXHwgICAgIFx8ICAgIFxgLiB8ICAgXGAuIHwKKy0tLS0tLSsnICAgICAgKy0tLS0tLSsgICAgICAgKy0tLS0tLSsgICAgICAgKy0tLS0tLSsgICAgICBcYCstLS0tLS0rCgogICAuKy0tLS0tLSsgICAgICstLS0tLS0rICAgICArLS0tLS0tKyAgICAgKy0tLS0tLSsgICAgICstLS0tLS0rLgogLicgfCAgICAgIHwgICAgL3wgICAgICB8ICAgICB8ICAgICAgfCAgICAgfCAgICAgIHxcICAgIHwgICAgICB8IFxgLgorICAgfCAgICAgIHwgICArIHwgICAgICB8ICAgICArICAgICAgKyAgICAgfCAgICAgIHwgKyAgIHwgICAgICB8ICAgKwp8ICAgfCAgICAgIHwgICB8IHwgICAgICB8ICAgICB8ICAgICAgfCAgICAgfCAgICAgIHwgfCAgIHwgICAgICB8ICAgfAp8ICAuKy0tLS0tLSsgICB8ICstLS0tLS0rICAgICArLS0tLS0tKyAgICAgKy0tLS0tLSsgfCAgICstLS0tLS0rLiAgfAp8LicgICAgICAuJyAgICB8LyAgICAgIC8gICAgICB8ICAgICAgfCAgICAgIFwgICAgICBcfCAgICBcYC4gICAgICBcYC58CistLS0tLS0rJyAgICAgICstLS0tLS0rICAgICAgICstLS0tLS0rICAgICAgICstLS0tLS0rICAgICAgXGArLS0tLS0tKwpFT0MKICBwcmludGYgIlx4MUJbMDsxOzQ7Mzg7NTsyMDFtIgogIGNhdCA8PEVPQQpAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEAKRU9BCn0KCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBGdW5jdGlvbjogd3JpdGVfZXJyb3IKIyBEZXNjcmlwdGlvbjogUHJpbnRzIGFuIGVycm9yIG1lc3NhZ2Ugd2l0aCByZWQgZm9ybWF0dGluZy4KIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpmdW5jdGlvbiB3cml0ZV9lcnJvcigpewogIGxvY2FsIGlucHV0X21zZz0iJDEiCiAgcHJpbnRmICJceDFCWzA7MTs0ODs1OzE5NjszODs1OzI1NW1bRVJST1JdXHgxQlswOzM4OzU7MjU1bSAgOiBceDFCWzA7Mzg7NTsxOTZtJXNceDFCWzBtXG4iICIke2lucHV0X21zZ30iCn0KCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBGdW5jdGlvbjogd3JpdGVfdmVyYm9zZQojIERlc2NyaXB0aW9uOiBQcmludHMgYSB2ZXJib3NlIG1lc3NhZ2UgaWYgVkVSQk9TRSBtb2RlIGlzIGVuYWJsZWQuCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KZnVuY3Rpb24gd3JpdGVfdmVyYm9zZSgpewogIGxvY2FsIGlucHV0X21zZz0iJDEiCiAgaWYgW1sgIiR7VkVSQk9TRX0iID09IDEgXV07IHRoZW4KICAgIHByaW50ZiAiXHgxQlswOzE7NDg7NTsyMTszODs1OzIyNm1bVkVSQk9TRV1ceDFCWzA7Mzg7NTsyNTVtOiBceDFCWzA7Mzg7NTsyMjZtJXNceDFCWzBtXG4iICIke2lucHV0X21zZ30iCiAgZmkKfQoKIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIEZ1bmN0aW9uOiBpc19pbnN0YWxsZWQKIyBEZXNjcmlwdGlvbjogQ2hlY2tzIGlmIGEgcHJvZ3JhbSBpcyBpbnN0YWxsZWQgYW5kIGF2YWlsYWJsZSBpbiBQQVRILgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCmZ1bmN0aW9uIGlzX2luc3RhbGxlZCgpewogIGxvY2FsIGlucHV0X3Byb2dyYW09IiQxIgogIGlmIGNvbW1hbmQgLXYgIiR7aW5wdXRfcHJvZ3JhbX0iID4vZGV2L251bGwgMj4mMTsgdGhlbgogICAgcmV0dXJuIDAKICBlbHNlCiAgICB3cml0ZV9lcnJvciAiQ291bGQgbm90IGZpbmQgJyR7aW5wdXRfcHJvZ3JhbX0nIGluIFBBVEguIE1ha2Ugc3VyZSBpdCBpcyBpbnN0YWxsZWQgYW5kIGlzIGluIHlvdXIgUEFUSCIKICAgIHJldHVybiAxCiAgZmkKfQoKIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIEZ1bmN0aW9uOiBpbnN0YWxsX2RlcGVuZGVuY2llcwojIERlc2NyaXB0aW9uOiBEZXRlY3RzIHRoZSBPUyBhbmQgcGFja2FnZSBtYW5hZ2VyLCB0aGVuIGluc3RhbGxzIHJlcXVpcmVkIGRlcGVuZGVuY2llcy4KIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpmdW5jdGlvbiBpbnN0YWxsX2RlcGVuZGVuY2llcygpewogIHdyaXRlX3ZlcmJvc2UgIkluc3RhbGxpbmcgZGVwZW5kZW5jaWVzLi4uIgoKICAjIERldGVjdCBPUyB0eXBlIHVzaW5nIHVuYW1lCiAgT1NfVFlQRT0kKHVuYW1lIC1zKQogIGxvY2FsIFBLR19NQU5BR0VSPSIiCiAgbG9jYWwgREVQRU5ERU5DSUVTPSgpCgogIGlmIFtbICIke09TX1RZUEV9IiA9PSAiRGFyd2luIiBdXTsgdGhlbgogICAgIyBtYWNPUzogVXNlIEhvbWVicmV3CiAgICBpZiAhIGNvbW1hbmQgLXYgYnJldyA+L2Rldi9udWxsIDI+JjE7IHRoZW4KICAgICAgd3JpdGVfZXJyb3IgIkhvbWVicmV3IGlzIG5vdCBpbnN0YWxsZWQuIFBsZWFzZSBpbnN0YWxsIEhvbWVicmV3IGZpcnN0OiBodHRwczovL2JyZXcuc2giCiAgICAgIGV4aXQgMQogICAgZmkKICAgIFBLR19NQU5BR0VSPSJicmV3IgogICAgIyBEZWZpbmUgZGVwZW5kZW5jeSBsaXN0IGZvciBtYWNPUy4gQWRqdXN0IHBhY2thZ2UgbmFtZXMgaWYgbmVjZXNzYXJ5LgogICAgREVQRU5ERU5DSUVTPSgiZ2l0IiAienNoIiAiY3VybCIgImJhdCIpCiAgZWxpZiBbWyAiJHtPU19UWVBFfSIgPT0gIkxpbnV4IiBdXTsgdGhlbgogICAgIyBMaW51eDogRGV0ZWN0IGF2YWlsYWJsZSBwYWNrYWdlIG1hbmFnZXIuCiAgICBpZiBjb21tYW5kIC12IGFwdC1nZXQgPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgICAgIFBLR19NQU5BR0VSPSJhcHQtZ2V0IgogICAgICBERVBFTkRFTkNJRVM9KCJnaXQiICJ6c2giICJjdXJsIiAiYmF0IiAibHNkIikKICAgIGVsaWYgY29tbWFuZCAtdiBwYWNtYW4gPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgICAgIFBLR19NQU5BR0VSPSJwYWNtYW4iCiAgICAgIERFUEVOREVOQ0lFUz0oImdpdCIgInpzaCIgImN1cmwiICJiYXQiICJsc2QiKQogICAgZWxpZiBjb21tYW5kIC12IGRuZiA+L2Rldi9udWxsIDI+JjE7IHRoZW4KICAgICAgUEtHX01BTkFHRVI9ImRuZiIKICAgICAgREVQRU5ERU5DSUVTPSgiZ2l0IiAienNoIiAiY3VybCIpCiAgICBlbGlmIGNvbW1hbmQgLXYgeXVtID4vZGV2L251bGwgMj4mMTsgdGhlbgogICAgICBQS0dfTUFOQUdFUj0ieXVtIgogICAgICBERVBFTkRFTkNJRVM9KCJnaXQiICJ6c2giICJjdXJsIikKICAgIGVsc2UKICAgICAgd3JpdGVfZXJyb3IgIlVuc3VwcG9ydGVkIExpbnV4IHBhY2thZ2UgbWFuYWdlci4gUGxlYXNlIGluc3RhbGwgZGVwZW5kZW5jaWVzIG1hbnVhbGx5LiIKICAgICAgZXhpdCAxCiAgICBmaQogIGVsc2UKICAgIHdyaXRlX2Vycm9yICJVbnN1cHBvcnRlZCBPUzogJHtPU19UWVBFfS4gUGxlYXNlIGluc3RhbGwgZGVwZW5kZW5jaWVzIG1hbnVhbGx5LiBBbGwgeW91IHJlYWxseSBuZWVkIGlzIGdpdCBhbmQgenNoIgogICAgZXhpdCAxCiAgZmkKCiAgd3JpdGVfdmVyYm9zZSAiRGV0ZWN0ZWQgT1M6ICR7T1NfVFlQRX0iCiAgd3JpdGVfdmVyYm9zZSAiVXNpbmcgcGFja2FnZSBtYW5hZ2VyOiAke1BLR19NQU5BR0VSfSIKCiAgIyBMb29wIHRocm91Z2ggZWFjaCBkZXBlbmRlbmN5IGFuZCBpbnN0YWxsIGlmIG5vdCBhbHJlYWR5IGluc3RhbGxlZAogIGZvciBwa2cgaW4gIiR7REVQRU5ERU5DSUVTW0BdfSI7IGRvCiAgICBpZiAhIGNvbW1hbmQgLXYgIiR7cGtnfSIgPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgICAgIHdyaXRlX3ZlcmJvc2UgIkluc3RhbGxpbmcgJHtwa2d9Li4uIgogICAgICBjYXNlICIke1BLR19NQU5BR0VSfSIgaW4KICAgICAgICBicmV3KQogICAgICAgICAgYnJldyBpbnN0YWxsICIke3BrZ30iCiAgICAgICAgICA7OwogICAgICAgIGFwdC1nZXQpCiAgICAgICAgICBzdWRvIGFwdC1nZXQgdXBkYXRlICYmIHN1ZG8gYXB0LWdldCBpbnN0YWxsIC15ICIke3BrZ30iCiAgICAgICAgICA7OwogICAgICAgIGRuZikKICAgICAgICAgIHN1ZG8gZG5mIGluc3RhbGwgLXkgIiR7cGtnfSIKICAgICAgICAgIDs7CiAgICAgICAgcGFjbWFuKQogICAgICAgICAgc3VkbyBwYWNtYW4gLVN5IC0tbm9jb25maXJtICIke3BrZ30iCiAgICAgICAgICA7OwogICAgICAgIHl1bSkKICAgICAgICAgIHN1ZG8geXVtIGluc3RhbGwgLXkgIiR7cGtnfSIKICAgICAgICAgIDs7CiAgICAgICAgKikKICAgICAgICAgIHdyaXRlX2Vycm9yICJQYWNrYWdlIG1hbmFnZXIgJHtQS0dfTUFOQUdFUn0gaXMgbm90IHN1cHBvcnRlZCBpbiB0aGlzIHNjcmlwdC4iCiAgICAgICAgICBleGl0IDEKICAgICAgICAgIDs7CiAgICAgIGVzYWMKICAgIGVsc2UKICAgICAgd3JpdGVfdmVyYm9zZSAiJHtwa2d9IGlzIGFscmVhZHkgaW5zdGFsbGVkLiIKICAgIGZpCiAgZG9uZQp9CgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgRnVuY3Rpb246IGNsb25lX2RvdGZpbGVzCiMgRGVzY3JpcHRpb246IENsb25lcyB0aGUgZG90ZmlsZXMgcmVwb3NpdG9yeSBhcyBhIGJhcmUgcmVwb3NpdG9yeS4KIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpmdW5jdGlvbiBjbG9uZV9kb3RmaWxlcygpewogIGlmIFtbIC1kICIke0RPVEZJTEVTX0RJUn0iIF1dOyB0aGVuCiAgICB3cml0ZV9lcnJvciAiRG90ZmlsZXMgZGlyZWN0b3J5IGFscmVhZHkgZXhpc3RzOiAke0RPVEZJTEVTX0RJUn0gLiBSZW1vdmUgdGhpcyBkaXJlY3RvcnkgaWYgeW91IHdhbnQgdG8gcmVpbnN0YWxsIgogICAgcmV0dXJuIDEKICBlbHNlCiAgICB3cml0ZV92ZXJib3NlICJDbG9uaW5nIGRvdGZpbGVzOiAke0RPVEZJTEVTX1JFUE99IHRvIGRpcmVjdG9yeTogJHtET1RGSUxFU19ESVJ9IgogICAgZ2l0IGNsb25lICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgIC0tYmFyZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgICAtLWNvbmZpZyBzdGF0dXMuc2hvd1VudHJhY2tlZEZpbGVzPW5vICAgICAgICAgICAgICAgICAgIFwKICAgICAgLS1jb25maWcgY29yZS5leGNsdWRlc2ZpbGU9IiR7RE9URklMRVNfRElSfS8uZ2l0aWdub3JlIiBcCiAgICAgIC0tcmVjdXJzZS1zdWJtb2R1bGVzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgICAtLXZlcmJvc2UgLS1wcm9ncmVzcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgIiR7RE9URklMRVNfUkVQT30iICIke0RPVEZJTEVTX0RJUn0iCiAgZmkKfQoKIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIEZ1bmN0aW9uOiBjbG9uZV9kb3RmCiMgRGVzY3JpcHRpb246IENsb25lcyB0aGUgZG90ZiByZXBvc2l0b3J5LgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCmZ1bmN0aW9uIGNsb25lX2RvdGYoKXsKICBpZiBbWyAtZCAiJHtET1RGX0RJUn0iIF1dOyB0aGVuCiAgICB3cml0ZV9lcnJvciAiRG90ZiBkaXJlY3RvcnkgYWxyZWFkeSBleGlzdHM6ICR7RE9URl9ESVJ9IgogICAgcmV0dXJuIDEKICBlbHNlCiAgICB3cml0ZV92ZXJib3NlICJDbG9uaW5nIGRvdGY6ICR7RE9URl9SRVBPfSB0byBkaXJlY3Rvcnk6ICR7RE9URl9ESVJ9IgogICAgZ2l0IGNsb25lICIke0RPVEZfUkVQT30iICIke0RPVEZfRElSfSIKICBmaQp9CgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgTWFpbiBFeGVjdXRpb24KIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKIyBEaXNwbGF5IEFTQ0lJIGFydCBiYW5uZXIKc2hvd19hc2NpaV9oZWxsbwoKIyBJbnN0YWxsIHJlcXVpcmVkIGRlcGVuZGVuY2llcyBiYXNlZCBvbiBPUyBkZXRlY3Rpb24KaW5zdGFsbF9kZXBlbmRlbmNpZXMKCiMgRW5zdXJlIGNyaXRpY2FsIGNvbW1hbmRzIGFyZSBpbnN0YWxsZWQgKHRoaXMgY2hlY2sgaXMgcmVkdW5kYW50IGlmIGluc3RhbGxfZGVwZW5kZW5jaWVzIGlzIHJ1bikKaXNfaW5zdGFsbGVkICJnaXQiCmlzX2luc3RhbGxlZCAienNoIgoKIyBVbmNvbW1lbnQgdGhlc2UgbGluZXMgaWYgeW91IHdhbnQgdG8gY2xvbmUgdGhlIHJlcG9zaXRvcmllcyBhdXRvbWF0aWNhbGx5OgpjbG9uZV9kb3RmaWxlcwpjbG9uZV9kb3RmCgojIERpc3BsYXkgQVNDSUkgYXJ0IGJhbm5lciAyCnNob3dfYXNjaWlfZ29vZGJ5ZQo=' | base64 -d | bash
```

Installation Script Online

```bash
curl --silent -L "https://raw.githubusercontent.com/ConnerWill/dotfiles/refs/heads/main/.config/zsh/install-dotfiles.sh" | bash
```

</details>

</details>

<details>
 <summary><b>Test dotfiles in Docker</b></summary>

<br>

> **Test ZSH configuration in Docker**

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

<details>
 <summary><b>Test dotfiles in Docker - OLD METHOD</b></summary>

> **Test full config in Docker**
```shell
git clone --recurse-submodules https://github.com/connerwill/dotfiles \
  && docker run                                                       \
    -v $PWD/dotfiles:/root                                            \
    -it                                                               \
    archlinux                                                         \
    sh -c "ln -rs ~/.config/zsh/.zshenv ~/ && pacman -Sy --noconfirm zsh tmux git fzf bat lsd neovim && chsh --shell /usr/bin/zsh && exec zsh"
```

> **Test ZSH with no extra packages**
```shell
git clone --recurse-submodules https://github.com/connerwill/dotfiles \
  && docker run                                                       \
    -v $PWD/dotfiles:/root                                            \
    -it                                                               \
    archlinux                                                         \
    sh -c "ln -rs ~/.config/zsh/.zshenv ~/ && pacman -Sy --noconfirm zsh && chsh --shell /usr/bin/zsh && exec zsh"
```

<br>

</details>

<br>

</details>

---

<!--

# Features

- [x] Fully featured ZSH configuration
  - [x]
- [x] Mars
- [ ] TODO

-->


# Configurations

* **Xresources**
* **awesome**
* **bat**
* fish
* **git**
* **kitty**
* **lynx**
* **nano**
* **nvim**
* powershell
* **sx**
* **termux**
* **tmux**
* **zsh**


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


| Unchecked | Checked |
| --------- | ------- |
| &#9744;   | &#9745; |

-->
