# ~/.bashrc — bootstrap stub.
# Bash only reads from a fixed set of startup files (~/.bashrc for interactive
# non-login shells). It has no ~/.config / $ZDOTDIR support like zsh, so this
# file exists purely to source the real config from ~/.config/bash.

# Kiro CLI pre block. Keep at the top of this file. (tool-managed)
[[ -f "${HOME}/.local/share/kiro-cli/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/bashrc.pre.bash"


# Load personal bash config from ~/.config/bash
[[ -f "${HOME}/.config/bash/bashrc" ]] && source "${HOME}/.config/bash/bashrc"


# Kiro CLI post block. Keep at the bottom of this file. (tool-managed)
[[ -f "${HOME}/.local/share/kiro-cli/shell/bashrc.post.bash" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/bashrc.post.bash"
