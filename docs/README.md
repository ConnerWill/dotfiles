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

</details>

<details>
 <summary><b>Installation Script</b></summary>

Installation Script Online

```bash
curl --silent -L "https://raw.githubusercontent.com/ConnerWill/dotfiles/refs/heads/main/.config/zsh/install-dotfiles.sh" | bash
```

Installation Script (`base64`)

```bash
echo 'IyEvdXNyL2Jpbi9lbnYgYmFzaAoKc2V0IC1lCgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgUmVwb3NpdG9yeSBVUkxzIGFuZCBEaXJlY3RvcmllcwojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRPVEZJTEVTX1JFUE89Imh0dHBzOi8vZ2l0aHViLmNvbS9Db25uZXJXaWxsL2RvdGZpbGVzLmdpdCIKRE9URklMRVNfRElSPSIke0hPTUV9Ly5kb3RmaWxlcyIKRE9URl9SRVBPPSJodHRwczovL2dpdGh1Yi5jb20vQ29ubmVyV2lsbC9kb3RmLmdpdCIKRE9URl9ESVI9IiR7WlNIX0ZVTkNUSU9OU19NQU5VQUw6LSR7WERHX0NPTkZJR19IT01FOi0ke0hPTUV9Ly5jb25maWd9L3pzaC96c2gvdXNlci9mdW5jdGlvbnMvZnVuY3Rpb25zLW1hbnVhbC9kb3RmfSIKVkVSQk9TRT0xCgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgRnVuY3Rpb246IHNob3dfYXNjaWlfaGVsbG8KIyBEZXNjcmlwdGlvbjogRGlzcGxheXMgYW4gQVNDSUkgYXJ0IGJhbm5lciB3aXRoIHJlcG9zaXRvcnkgaW5mb3JtYXRpb24uCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KZnVuY3Rpb24gc2hvd19hc2NpaV9oZWxsbygpewogIHByaW50ZiAiXHgxQlswOzE7NDszODs1OzIwMW0iCiAgY2F0IDw8RU9BCkBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQApFT0EKICBwcmludGYgIlx4MUJbMDsxOzM7Mzg7NTs1MW0iCiAgY2F0IDw8RU9CCi4gICAgICAgICAgICAgICAgJHtET1RGX1JFUE99ICAgICAgICAgICAgICAgICAgIC4KRU9CCiAgcHJpbnRmICJceDFCWzA7MTs0OzM4OzU7MjAxbSIKICBjYXQgPDxFT0MKQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBACkVPQwogIHByaW50ZiAiXHgxQlswOzM4OzU7NTdtIgogIGNhdCA8PEVPQgouICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4KLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuCi4gICAgICAgICAgICAgICAgICAgICAuLSs9PT09PT09LS0tOjouLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLgouICAgICAgICAgICAgICAgICAgIDo9KyMjQEBAQEBAQEBAQEBAQCVAQEAjLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4KLiAgICAgICAgICAgICAgICAuPToqPUAjQEBAQEBAJUBAQEBAQEBAQEBAQCUrLiAgICAgIC4uICAgICAgICAgICAgICAgICAgICAuCi4gIC4uLjo6Li4gICAgLjorLio9JSUlQEBAQEBAKiVAQEBAQEBAQEBAQEBAJSMtLiAgICAuLiAgICAgICAgICAgICAgICAgICAgLgouIC4lQEBAJSUlJSotLT0uPSorQCNAQEBAQEBAQD0jQEBAQEBAQEBAQEBAQEBAIyMtLjouLjogICAgICAgICAgICAgICAgICAgIC4KLiAqQEBAQEBAQEBAQEBAQD0lQCMjJSUjIyMjIyorJSUjJSUlJSUlJSUlJSVAQEBAKiUjQCUlIyorPTouLiAgICAgICAgICAgICAuCi49JSMuLi4uLi4uLi4uLi4uLi4uLi4uLjo6Ojo6OjotLTotKyNAQEBAQEBAQEBAQEBAIyolQEBAQEAlJSMrPSsqKzouICAgICAgLgouI0BAKj0tOi06Oi4tQEAjKiolQEAtLiAgICAgICArJSUuICAgIC4uLi4gLiAuLi4uLi4uLi4uLi4uLi46LT0rIyVAQCUrOi4gIC4KLi4jJUBAQEBAQEAlKkBAQEBAQEBAPS4jQEBAQCVAQEBAQEBAJSUlJSUjIyMqPTotOi4uLi4uLiAgLiMlJSMjJT0uICAgIC46PS4uCiMlIyMjKiorKysrQEBAQCs6Oi0jQEBAOi0tLT09KysqKiojIyMlJSUlQEBAQEBAIyUqQEBAQEBAOipAQEBAQEAjKyUlKz09I0AuLgo9QEBAQEBAQEBAQEBAKi4gICAgIDpAQEBAQEBAQEBAQCUlJSUlIyMqKioqKysrPS0tLTo6Oi4uOkBAQCUtOj1AQEAtOjo6Oi4uLi4KLj0jKisrQEBAQEBAQC4gOkBAJS4gPUBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQD0gICAgLipAQEBAQEBAQEAtCi4gIC46PSMlQEBAQCUuID1AQEA6ID1AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQCMuLkBAPS46QEBAQEBAQEA6LgouICAgICAgICAgIC5APSAgLjouIC4lJSsrOi4uOjo6Ojo6Ojo6LS0tLS0tLS09PT0jJSUlJSUlJUAjLi4lQC0uOkAlJSUlJT0gIC4KLiAgICAgICAgICAgLiUjOi4gLj1AJS4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtQCsgICAgLioqLiAgICAgICAuCi4gICAgICAgICAgICAuOiNAQEAjLS4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC1AQCs9KkArLiAgICAgICAgLgouICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4tLTouICAgICAgICAgIC4KRU9CCiAgcHJpbnRmICJceDFCWzA7MTs0OzM4OzU7MjAxbSIKICBjYXQgPDxFT0EKQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBACkVPQQogIHByaW50ZiAiXHgxQlswbSIKICBzbGVlcCAxCn0KCgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgRnVuY3Rpb246IHNob3dfYXNjaWlfZ29vZGJ5ZQojIERlc2NyaXB0aW9uOiBEaXNwbGF5cyBhbiBBU0NJSSBhcnQgZ29vZGJ5ZQojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCmZ1bmN0aW9uIHNob3dfYXNjaWlfZ29vZGJ5ZSgpewogIHByaW50ZiAiXHgxQlswOzE7NDszODs1OzIwMW0iCiAgY2F0IDw8RU9BCkBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQApFT0EKICBwcmludGYgIlx4MUJbMDsxOzM4OzU7NDZtIgogIGNhdCA8PEVPQQorLS0tLS0tKy4gICAgICArLS0tLS0tKyAgICAgICArLS0tLS0tKyAgICAgICArLS0tLS0tKyAgICAgIC4rLS0tLS0tKwp8XGAuICAgIHwgXGAuICAgIHxcICAgICB8XCAgICAgIHwgICAgICB8ICAgICAgL3wgICAgIC98ICAgIC4nIHwgICAgLid8CnwgIFxgKy0tKy0tLSsgICB8ICstLS0tKy0rICAgICArLS0tLS0tKyAgICAgKy0rLS0tLSsgfCAgICstLS0rLS0rJyAgfAp8ICAgfCAgfCAgIHwgICB8IHwgICAgfCB8ICAgICB8ICAgICAgfCAgICAgfCB8ICAgIHwgfCAgIHwgICB8ICB8ICAgfAorLS0tKy0tKy4gIHwgICArLSstLS0tKyB8ICAgICArLS0tLS0tKyAgICAgfCArLS0tLSstKyAgIHwgIC4rLS0rLS0tKwogXGAuIHwgICAgXGAufCAgICBcfCAgICAgXHwgICAgIHwgICAgICB8ICAgICB8LyAgICAgfC8gICAgfC4nICAgIHwgLicKICAgXGArLS0tLS0tKyAgICAgKy0tLS0tLSsgICAgICstLS0tLS0rICAgICArLS0tLS0tKyAgICAgKy0tLS0tLSsnCkVPQQogIHByaW50ZiAiXHgxQlswOzE7MzszODs1OzIwMW0iCiAgY2F0IDw8RU9CCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR09PREJZRSA6KQpFT0IKICBwcmludGYgIlx4MUJbMDsxOzM4OzU7NDZtIgogIGNhdCA8PEVPQwogICAuKy0tLS0tLSsgICAgICstLS0tLS0rICAgICArLS0tLS0tKyAgICAgKy0tLS0tLSsgICAgICstLS0tLS0rLgogLicgfCAgICAuJ3wgICAgL3wgICAgIC98ICAgICB8ICAgICAgfCAgICAgfFwgICAgIHxcICAgIHxcYC4gICAgfCBcYC4KKy0tLSstLSsnICB8ICAgKy0rLS0tLSsgfCAgICAgKy0tLS0tLSsgICAgIHwgKy0tLS0rLSsgICB8ICBcYCstLSstLS0rCnwgICB8ICB8ICAgfCAgIHwgfCAgICB8IHwgICAgIHwgICAgICB8ICAgICB8IHwgICAgfCB8ICAgfCAgIHwgIHwgICB8CnwgICwrLS0rLS0tKyAgIHwgKy0tLS0rLSsgICAgICstLS0tLS0rICAgICArLSstLS0tKyB8ICAgKy0tLSstLSsgICB8CnwuJyAgICB8IC4nICAgIHwvICAgICB8LyAgICAgIHwgICAgICB8ICAgICAgXHwgICAgIFx8ICAgIFxgLiB8ICAgXGAuIHwKKy0tLS0tLSsnICAgICAgKy0tLS0tLSsgICAgICAgKy0tLS0tLSsgICAgICAgKy0tLS0tLSsgICAgICBcYCstLS0tLS0rCgogICAuKy0tLS0tLSsgICAgICstLS0tLS0rICAgICArLS0tLS0tKyAgICAgKy0tLS0tLSsgICAgICstLS0tLS0rLgogLicgfCAgICAgIHwgICAgL3wgICAgICB8ICAgICB8ICAgICAgfCAgICAgfCAgICAgIHxcICAgIHwgICAgICB8IFxgLgorICAgfCAgICAgIHwgICArIHwgICAgICB8ICAgICArICAgICAgKyAgICAgfCAgICAgIHwgKyAgIHwgICAgICB8ICAgKwp8ICAgfCAgICAgIHwgICB8IHwgICAgICB8ICAgICB8ICAgICAgfCAgICAgfCAgICAgIHwgfCAgIHwgICAgICB8ICAgfAp8ICAuKy0tLS0tLSsgICB8ICstLS0tLS0rICAgICArLS0tLS0tKyAgICAgKy0tLS0tLSsgfCAgICstLS0tLS0rLiAgfAp8LicgICAgICAuJyAgICB8LyAgICAgIC8gICAgICB8ICAgICAgfCAgICAgIFwgICAgICBcfCAgICBcYC4gICAgICBcYC58CistLS0tLS0rJyAgICAgICstLS0tLS0rICAgICAgICstLS0tLS0rICAgICAgICstLS0tLS0rICAgICAgXGArLS0tLS0tKwpFT0MKICBwcmludGYgIlx4MUJbMDsxOzQ7Mzg7NTsyMDFtIgogIGNhdCA8PEVPQQpAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEAKRU9BCiAgcHJpbnRmICJceDFCWzBtIgp9CgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgRnVuY3Rpb246IHdyaXRlX2Vycm9yCiMgRGVzY3JpcHRpb246IFByaW50cyBhbiBlcnJvciBtZXNzYWdlIHdpdGggcmVkIGZvcm1hdHRpbmcuCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KZnVuY3Rpb24gd3JpdGVfZXJyb3IoKXsKICBsb2NhbCBpbnB1dF9tc2c9IiQxIgogIHByaW50ZiAiXHgxQlswOzE7NDg7NTsxOTY7Mzg7NTsyNTVtW0VSUk9SXVx4MUJbMDszODs1OzI1NW0gIDogXHgxQlswOzM4OzU7MTk2bSVzXHgxQlswbVxuIiAiJHtpbnB1dF9tc2d9Igp9CgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgRnVuY3Rpb246IHdyaXRlX3ZlcmJvc2UKIyBEZXNjcmlwdGlvbjogUHJpbnRzIGEgdmVyYm9zZSBtZXNzYWdlIGlmIFZFUkJPU0UgbW9kZSBpcyBlbmFibGVkLgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCmZ1bmN0aW9uIHdyaXRlX3ZlcmJvc2UoKXsKICBsb2NhbCBpbnB1dF9tc2c9IiQxIgogIGlmIFtbICIke1ZFUkJPU0V9IiA9PSAxIF1dOyB0aGVuCiAgICBwcmludGYgIlx4MUJbMDsxOzQ4OzU7MjE7Mzg7NTsyMjZtW1ZFUkJPU0VdXHgxQlswOzM4OzU7MjU1bTogXHgxQlswOzM4OzU7MjI2bSVzXHgxQlswbVxuIiAiJHtpbnB1dF9tc2d9IgogIGZpCn0KCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBGdW5jdGlvbjogaXNfaW5zdGFsbGVkCiMgRGVzY3JpcHRpb246IENoZWNrcyBpZiBhIHByb2dyYW0gaXMgaW5zdGFsbGVkIGFuZCBhdmFpbGFibGUgaW4gUEFUSC4KIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpmdW5jdGlvbiBpc19pbnN0YWxsZWQoKXsKICBsb2NhbCBpbnB1dF9wcm9ncmFtPSIkMSIKICBpZiBjb21tYW5kIC12ICIke2lucHV0X3Byb2dyYW19IiA+L2Rldi9udWxsIDI+JjE7IHRoZW4KICAgIHJldHVybiAwCiAgZWxzZQogICAgd3JpdGVfZXJyb3IgIkNvdWxkIG5vdCBmaW5kICcke2lucHV0X3Byb2dyYW19JyBpbiBQQVRILiBNYWtlIHN1cmUgaXQgaXMgaW5zdGFsbGVkIGFuZCBpcyBpbiB5b3VyIFBBVEgiCiAgICByZXR1cm4gMQogIGZpCn0KCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBGdW5jdGlvbjogaW5zdGFsbF9kZXBlbmRlbmNpZXMKIyBEZXNjcmlwdGlvbjogRGV0ZWN0cyB0aGUgT1MgYW5kIHBhY2thZ2UgbWFuYWdlciwgdGhlbiBpbnN0YWxscyByZXF1aXJlZCBkZXBlbmRlbmNpZXMuCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KZnVuY3Rpb24gaW5zdGFsbF9kZXBlbmRlbmNpZXMoKXsKICB3cml0ZV92ZXJib3NlICJJbnN0YWxsaW5nIGRlcGVuZGVuY2llcy4uLiIKCiAgIyBEZXRlY3QgT1MgdHlwZSB1c2luZyB1bmFtZQogIE9TX1RZUEU9JCh1bmFtZSAtcykKICBsb2NhbCBQS0dfTUFOQUdFUj0iIgogIGxvY2FsIERFUEVOREVOQ0lFUz0oKQoKICBpZiBbWyAiJHtPU19UWVBFfSIgPT0gIkRhcndpbiIgXV07IHRoZW4KICAgICMgbWFjT1M6IFVzZSBIb21lYnJldwogICAgaWYgISBjb21tYW5kIC12IGJyZXcgPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgICAgIHdyaXRlX2Vycm9yICJIb21lYnJldyBpcyBub3QgaW5zdGFsbGVkLiBQbGVhc2UgaW5zdGFsbCBIb21lYnJldyBmaXJzdDogaHR0cHM6Ly9icmV3LnNoIgogICAgICBleGl0IDEKICAgIGZpCiAgICBQS0dfTUFOQUdFUj0iYnJldyIKICAgICMgRGVmaW5lIGRlcGVuZGVuY3kgbGlzdCBmb3IgbWFjT1MuIEFkanVzdCBwYWNrYWdlIG5hbWVzIGlmIG5lY2Vzc2FyeS4KICAgIERFUEVOREVOQ0lFUz0oImdpdCIgInpzaCIgImN1cmwiICJiYXQiKQogIGVsaWYgW1sgIiR7T1NfVFlQRX0iID09ICJMaW51eCIgXV07IHRoZW4KICAgICMgTGludXg6IERldGVjdCBhdmFpbGFibGUgcGFja2FnZSBtYW5hZ2VyLgogICAgaWYgY29tbWFuZCAtdiBhcHQtZ2V0ID4vZGV2L251bGwgMj4mMTsgdGhlbgogICAgICBQS0dfTUFOQUdFUj0iYXB0LWdldCIKICAgICAgREVQRU5ERU5DSUVTPSgiZ2l0IiAienNoIiAiY3VybCIgImJhdCIgImxzZCIpCiAgICBlbGlmIGNvbW1hbmQgLXYgcGFjbWFuID4vZGV2L251bGwgMj4mMTsgdGhlbgogICAgICBQS0dfTUFOQUdFUj0icGFjbWFuIgogICAgICBERVBFTkRFTkNJRVM9KCJnaXQiICJ6c2giICJjdXJsIiAiYmF0IiAibHNkIikKICAgIGVsaWYgY29tbWFuZCAtdiBkbmYgPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgICAgIFBLR19NQU5BR0VSPSJkbmYiCiAgICAgIERFUEVOREVOQ0lFUz0oImdpdCIgInpzaCIgImN1cmwiKQogICAgZWxpZiBjb21tYW5kIC12IHl1bSA+L2Rldi9udWxsIDI+JjE7IHRoZW4KICAgICAgUEtHX01BTkFHRVI9Inl1bSIKICAgICAgREVQRU5ERU5DSUVTPSgiZ2l0IiAienNoIiAiY3VybCIpCiAgICBlbHNlCiAgICAgIHdyaXRlX2Vycm9yICJVbnN1cHBvcnRlZCBMaW51eCBwYWNrYWdlIG1hbmFnZXIuIFBsZWFzZSBpbnN0YWxsIGRlcGVuZGVuY2llcyBtYW51YWxseS4iCiAgICAgIGV4aXQgMQogICAgZmkKICBlbHNlCiAgICB3cml0ZV9lcnJvciAiVW5zdXBwb3J0ZWQgT1M6ICR7T1NfVFlQRX0uIFBsZWFzZSBpbnN0YWxsIGRlcGVuZGVuY2llcyBtYW51YWxseS4gQWxsIHlvdSByZWFsbHkgbmVlZCBpcyBnaXQgYW5kIHpzaCIKICAgIGV4aXQgMQogIGZpCgogIHdyaXRlX3ZlcmJvc2UgIkRldGVjdGVkIE9TOiAke09TX1RZUEV9IgogIHdyaXRlX3ZlcmJvc2UgIlVzaW5nIHBhY2thZ2UgbWFuYWdlcjogJHtQS0dfTUFOQUdFUn0iCgogICMgTG9vcCB0aHJvdWdoIGVhY2ggZGVwZW5kZW5jeSBhbmQgaW5zdGFsbCBpZiBub3QgYWxyZWFkeSBpbnN0YWxsZWQKICBmb3IgcGtnIGluICIke0RFUEVOREVOQ0lFU1tAXX0iOyBkbwogICAgaWYgISBjb21tYW5kIC12ICIke3BrZ30iID4vZGV2L251bGwgMj4mMTsgdGhlbgogICAgICB3cml0ZV92ZXJib3NlICJJbnN0YWxsaW5nICR7cGtnfS4uLiIKICAgICAgY2FzZSAiJHtQS0dfTUFOQUdFUn0iIGluCiAgICAgICAgYnJldykKICAgICAgICAgIGJyZXcgaW5zdGFsbCAiJHtwa2d9IgogICAgICAgICAgOzsKICAgICAgICBhcHQtZ2V0KQogICAgICAgICAgc3VkbyBhcHQtZ2V0IHVwZGF0ZSAmJiBzdWRvIGFwdC1nZXQgaW5zdGFsbCAteSAiJHtwa2d9IgogICAgICAgICAgOzsKICAgICAgICBkbmYpCiAgICAgICAgICBzdWRvIGRuZiBpbnN0YWxsIC15ICIke3BrZ30iCiAgICAgICAgICA7OwogICAgICAgIHBhY21hbikKICAgICAgICAgIHN1ZG8gcGFjbWFuIC1TeSAtLW5vY29uZmlybSAiJHtwa2d9IgogICAgICAgICAgOzsKICAgICAgICB5dW0pCiAgICAgICAgICBzdWRvIHl1bSBpbnN0YWxsIC15ICIke3BrZ30iCiAgICAgICAgICA7OwogICAgICAgICopCiAgICAgICAgICB3cml0ZV9lcnJvciAiUGFja2FnZSBtYW5hZ2VyICR7UEtHX01BTkFHRVJ9IGlzIG5vdCBzdXBwb3J0ZWQgaW4gdGhpcyBzY3JpcHQuIgogICAgICAgICAgZXhpdCAxCiAgICAgICAgICA7OwogICAgICBlc2FjCiAgICBlbHNlCiAgICAgIHdyaXRlX3ZlcmJvc2UgIiR7cGtnfSBpcyBhbHJlYWR5IGluc3RhbGxlZC4iCiAgICBmaQogIGRvbmUKfQoKIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIEZ1bmN0aW9uOiBjbG9uZV9kb3RmaWxlcwojIERlc2NyaXB0aW9uOiBDbG9uZXMgdGhlIGRvdGZpbGVzIHJlcG9zaXRvcnkgYXMgYSBiYXJlIHJlcG9zaXRvcnkuCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KZnVuY3Rpb24gY2xvbmVfZG90ZmlsZXMoKXsKICBpZiBbWyAtZCAiJHtET1RGSUxFU19ESVJ9IiBdXTsgdGhlbgogICAgd3JpdGVfZXJyb3IgIkRvdGZpbGVzIGRpcmVjdG9yeSBhbHJlYWR5IGV4aXN0czogJHtET1RGSUxFU19ESVJ9IC4gUmVtb3ZlIHRoaXMgZGlyZWN0b3J5IGlmIHlvdSB3YW50IHRvIHJlaW5zdGFsbCIKICAgIHJldHVybiAxCiAgZWxzZQogICAgd3JpdGVfdmVyYm9zZSAiQ2xvbmluZyBkb3RmaWxlczogJHtET1RGSUxFU19SRVBPfSB0byBkaXJlY3Rvcnk6ICR7RE9URklMRVNfRElSfSIKICAgIGdpdCBjbG9uZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgICAtLWJhcmUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgLS1jb25maWcgc3RhdHVzLnNob3dVbnRyYWNrZWRGaWxlcz1ubyAgICAgICAgICAgICAgICAgICBcCiAgICAgIC0tY29uZmlnIGNvcmUuZXhjbHVkZXNmaWxlPSIke0RPVEZJTEVTX0RJUn0vLmdpdGlnbm9yZSIgXAogICAgICAtLXJlY3Vyc2Utc3VibW9kdWxlcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgLS12ZXJib3NlIC0tcHJvZ3Jlc3MgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICIke0RPVEZJTEVTX1JFUE99IiAiJHtET1RGSUxFU19ESVJ9IgogIGZpCn0KCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBGdW5jdGlvbjogY2xvbmVfZG90ZgojIERlc2NyaXB0aW9uOiBDbG9uZXMgdGhlIGRvdGYgcmVwb3NpdG9yeS4KIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpmdW5jdGlvbiBjbG9uZV9kb3RmKCl7CiAgaWYgW1sgLWQgIiR7RE9URl9ESVJ9IiBdXTsgdGhlbgogICAgd3JpdGVfZXJyb3IgIkRvdGYgZGlyZWN0b3J5IGFscmVhZHkgZXhpc3RzOiAke0RPVEZfRElSfSIKICAgIHJldHVybiAxCiAgZWxzZQogICAgd3JpdGVfdmVyYm9zZSAiQ2xvbmluZyBkb3RmOiAke0RPVEZfUkVQT30gdG8gZGlyZWN0b3J5OiAke0RPVEZfRElSfSIKICAgIGdpdCBjbG9uZSAiJHtET1RGX1JFUE99IiAiJHtET1RGX0RJUn0iCiAgZmkKfQoKIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIEZ1bmN0aW9uOiBjaGFuZ2Vfc2hlbGwKIyBEZXNjcmlwdGlvbjogQ2hhbmdlcyBkZWZhdWx0IHNoZWxsCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KZnVuY3Rpb24gY2hhbmdlX3NoZWxsKCl7CiAgaXNfaW5zdGFsbGVkICJjaHNoIgogIGNoc2ggLS1zaGVsbD0iJChjb21tYW5kIC12IHpzaCkiICIkKHdob2FtaSkiCn0KCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBNYWluIEV4ZWN1dGlvbgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgojIERpc3BsYXkgQVNDSUkgYXJ0IGJhbm5lcgpzaG93X2FzY2lpX2hlbGxvCgojIEVuc3VyZSBjcml0aWNhbCBjb21tYW5kcyBhcmUgaW5zdGFsbGVkCmlzX2luc3RhbGxlZCAic3VkbyIKCiMgSW5zdGFsbCByZXF1aXJlZCBkZXBlbmRlbmNpZXMgYmFzZWQgb24gT1MgZGV0ZWN0aW9uCmluc3RhbGxfZGVwZW5kZW5jaWVzCgojIEVuc3VyZSBjcml0aWNhbCBjb21tYW5kcyBhcmUgaW5zdGFsbGVkICh0aGlzIGNoZWNrIGlzIHJlZHVuZGFudCBpZiBpbnN0YWxsX2RlcGVuZGVuY2llcyBpcyBydW4pCmlzX2luc3RhbGxlZCAiZ2l0Igppc19pbnN0YWxsZWQgInpzaCIKCiMgQ2xvbmUgcmVwb3MKY2xvbmVfZG90ZmlsZXMKY2xvbmVfZG90ZgoKIyBTZXQgc2hlbGwKY2hhbmdlX3NoZWxsCgojIERpc3BsYXkgQVNDSUkgYXJ0IGJhbm5lciAyCnNob3dfYXNjaWlfZ29vZGJ5ZQo=' | base64 -d | bash
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
