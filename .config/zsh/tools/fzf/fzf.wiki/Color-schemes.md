## `--color`

You can partially or completely customize the default color configuration of fzf with `--color` option. 

```sh
# --color=[BASE_SCHEME][,COLOR:ANSI]
fzf --color=bg+:24
fzf --color=light,fg:232,bg:255,bg+:116,info:27
```

The name of the base color scheme is followed by custom color mappings. ANSI color code of -1 denotes terminal default foreground/background color.

The color specification can be quite long if fully customized, so it's advised that you put it in `$FZF_DEFAULT_OPTS`. You can also split it into multiple `--color`s like follows:

```sh
export FZF_DEFAULT_OPTS='
  --color fg:124,bg:16,hl:202,fg+:214,bg+:52,hl+:231
  --color info:52,prompt:196,spinner:208,pointer:196,marker:208
'
```

#### Base scheme

(default: dark on 256-color terminal, otherwise 16)

- `dark`    Color scheme for dark 256-color terminal
- `light`   Color scheme for light 256-color terminal
- `16`      Color scheme for 16-color terminal
- `bw`      No colors. No further customization is allowed.

#### Color configuration

| Color        | Description                                                       |
| --           | --                                                                |
| `fg`         | Text                                                              |
| `bg`         | Background                                                        |
| `preview-fg` | Preview window text                                               |
| `preview-bg` | Preview window background                                         |
| `hl`         | Highlighted substrings                                            |
| `fg+`        | Text (current line)                                               |
| `bg+`        | Background (current line)                                         |
| `gutter`     | Gutter on the left (defaults to `bg+`)                            |
| `hl+`        | Highlighted substrings (current line)                             |
| `info`       | Info                                                              |
| `border`     | Border of the preview window and horizontal separators (--border) |
| `prompt`     | Prompt                                                            |
| `pointer`    | Pointer to the current line                                       |
| `marker`     | Multi-select marker                                               |
| `spinner`    | Streaming input indicator                                         |
| `header`     | Header                                                            |


#### 24-bit colors

The latest version of fzf supports 24-bit colors.

```sh
# Solarized colors
export FZF_DEFAULT_OPTS='
  --color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75
  --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07
  --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07
'
```

## Web color picker for fzf

https://minsw.github.io/fzf-color-picker/

## Color schemes (256-colors)

### Red

```sh
--color fg:124,bg:16,hl:202,fg+:214,bg+:52,hl+:231
--color info:52,prompt:196,spinner:208,pointer:196,marker:208
```

![](https://cloud.githubusercontent.com/assets/700826/7895679/1ad280ba-06d6-11e5-80a8-1fef0857e8e3.png)

### Molokai

```sh
--color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81
--color info:144,prompt:161,spinner:135,pointer:135,marker:118
```

### Jellybeans

![](https://www.dropbox.com/s/9rte6kkct6bsz1j/fzf_jellybeans_theme.png?dl=1)

```sh
--color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
--color info:183,prompt:110,spinner:107,pointer:167,marker:215
```

### JellyX

![](https://i.imgur.com/1xHOaNk.png)

```sh
--color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
--color info:150,prompt:110,spinner:150,pointer:167,marker:174
```

### Seoul256 Dusk

![](https://i.imgur.com/y6hZCnd.png)

```sh
--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168
```

### Seoul256 Night

![](https://i.imgur.com/hui2RmM.png)

```sh
--color fg:242,bg:233,hl:65,fg+:15,bg+:234,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168
```

### Solarized Dark
![](http://i.imgur.com/lrZxNTf.png)

```sh
--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254
--color info:254,prompt:37,spinner:108,pointer:235,marker:235
```

### Solarized Light
![](http://i.imgur.com/dqVN1du.png)

```sh
--color fg:240,bg:230,hl:33,fg+:241,bg+:221,hl+:33
--color info:33,prompt:33,pointer:166,marker:166,spinner:33
```

### Alternate Solarized Light/Dark Theme

This one is easier to read (in my opinion)
because the selected row contrasts less with the text.

<img width="530" alt="screenshot 2016-05-31 22 48 01" src="https://cloud.githubusercontent.com/assets/5544532/15699519/5e58d46a-2782-11e6-8b8e-91c7a15b76fe.png">
<img width="525" alt="screenshot 2016-05-31 22 49 22" src="https://cloud.githubusercontent.com/assets/5544532/15699520/5e6a170c-2782-11e6-81b3-b781aea5aa3c.png">

```zsh
_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"
  # Uncomment for truecolor, if your terminal supports it.
  # local base03="#002b36"
  # local base02="#073642"
  # local base01="#586e75"
  # local base00="#657b83"
  # local base0="#839496"
  # local base1="#93a1a1"
  # local base2="#eee8d5"
  # local base3="#fdf6e3"
  # local yellow="#b58900"
  # local orange="#cb4b16"
  # local red="#dc322f"
  # local magenta="#d33682"
  # local violet="#6c71c4"
  # local blue="#268bd2"
  # local cyan="#2aa198"
  # local green="#859900"

  # Comment and uncomment below for the light theme.

  # Solarized Dark color scheme for fzf
  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  "
  ## Solarized Light color scheme for fzf
  #export FZF_DEFAULT_OPTS="
  #  --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
  #  --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  #"
}
_gen_fzf_default_opts
```

### [Paper color](https://github.com/NLKNguyen/papercolor-theme)

```sh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#4d4d4c,bg:#eeeeee,hl:#d7005f
    --color=fg+:#4d4d4c,bg+:#e8e8e8,hl+:#d7005f
    --color=info:#4271ae,prompt:#8959a8,pointer:#d7005f
    --color=marker:#4271ae,spinner:#4271ae,header:#4271ae'
```

![](https://raw.githubusercontent.com/thuanpham2311/img/master/fzfPapercolorTheme.png)

### Base16 colors for fzf

A collection of color schemes based on the [base16](https://github.com/chriskempson/base16) project.

<https://github.com/nicodebo/base16-fzf>

### One Dark
![](https://i.imgur.com/vAKjBlX.png)
```sh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'
```

### Nord
![](https://i.imgur.com/RqZZvA7.png)
```sh
--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
--color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
```

### Dracula
(requires Dracula theme on terminal)

![](https://i.imgur.com/Id0bNT5.png)
```sh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'
```

### Ayu Mirage
![](https://i.imgur.com/e4vPJh7.png)
```sh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#cbccc6,bg:#1f2430,hl:#707a8c
 --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
 --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
 --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'
```

### Gruvbox Dark

```sh
  --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
```

![](https://raw.githubusercontent.com/BachoSeven/mydotFiles/master/pics/screens/ricing/fzf_gruvbox.png)

### [SpaceCamp](https://github.com/jaredgorski/SpaceCamp)

```sh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#dedede,bg:#121212,hl:#666666
 --color=fg+:#eeeeee,bg+:#282828,hl+:#cf73e6
 --color=info:#cf73e6,prompt:#FF0000,pointer:#cf73e6
 --color=marker:#f0d50c,spinner:#cf73e6,header:#91aadf'
```
![](https://user-images.githubusercontent.com/40050527/112976973-b7798280-917f-11eb-832a-92714e156365.png)

### [TermSchool](https://github.com/marcopaganini/termschool-vim-theme)

Note: Truecolor theme.

```sh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color="fg:#f0f0f0,bg:#252c31,bg+:#005f5f,hl:#87d75f,gutter:#252c31"
--color="query:#ffffff,prompt:#f0f0f0,pointer:#dfaf00,marker:#00d7d7"
'
```

![](https://raw.githubusercontent.com/marcopaganini/termschool-vim-theme/83d44adaf3e65018fb1a25fe0ad3a3a89415ce85/images/termschool.png)