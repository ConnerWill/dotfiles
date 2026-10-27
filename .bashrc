# ~/.bashrc — bootstrap stub.
# Bash has no native $ZDOTDIR: its startup paths (~/.bashrc, ~/.bash_profile,
# ~/.profile) are compiled in. This fixed file is the one unavoidable entry
# point; it defines BDOTDIR and delegates everything else to ${BDOTDIR}.

# Kiro CLI pre block. Keep at the top of this file. (tool-managed)
[[ -f "${HOME}/.local/share/kiro-cli/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/bashrc.pre.bash"


# ZDOTDIR-equivalent: point BDOTDIR at the bash config dir and load from it.
export BDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/bash"
[[ -f "${BDOTDIR}/bashrc" ]] && source "${BDOTDIR}/bashrc"


# Kiro CLI post block. Keep at the bottom of this file. (tool-managed)
[[ -f "${HOME}/.local/share/kiro-cli/shell/bashrc.post.bash" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/bashrc.post.bash"
