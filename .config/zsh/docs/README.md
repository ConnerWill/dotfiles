# ZSH

These are the files/directories that are sourced on ZSH startup

```
.
├── zsh/
│   └── user/
│       ├── completion/
│       ├── fpath/
│       ├── functions/
│       │   ├── functions-available
│       │   └── functions-enabled
│       ├── plugins/
│       │   ├── plugins-available
│       │   └── plugins-enabled
│       └── zsh.d/
│           ├── 00_pre.zsh
│           ├── 09_path.zsh
│           ├── 10_variables.zsh
│           ├── 20_options.zsh
│           ├── 21_history.zsh
│           ├── 30_modules.zsh
│           ├── 40_plugins.zsh
│           ├── 50_keybindings.zsh
│           ├── 60_functions.zsh
│           ├── 70_aliases.zsh
│           ├── 71_vendor_aliases.zsh
│           ├── 75_OS_specific.zsh
│           ├── 80_hooks.zsh
│           ├── 82_colors.zsh
│           ├── 83_vcs_prompts.zsh
│           ├── 85_highlighting.zsh
│           ├── 90_completions.zsh
│           ├── 98_post.zsh
│           └── 99_keybindings.zsh
├── .zshenv
├── .zshrc
├── .zlogin
└── .zprofile
```

# Docker

You can test out my ZSH configuration in Docker

> Build the Docker container

```bash
docker build --tag connerwill-dotfiles-zsh:latest .
```

> Run the Docker container

```bash
docker run        \
    --rm          \
    --interactive \
    --tty         \
    connerwill-dotfiles-zsh:latest
```
