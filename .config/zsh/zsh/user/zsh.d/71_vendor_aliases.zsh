# shellcheck disable=2148


export NVIMDIR="$XDG_CONFIG_HOME/nvim"
export WATCH_FAST_INTERVAL=0.1
export WATCH_INTERVAL=1

function draw_entire_line(){

  #############################################
  ## Usage:
  ##
  ##    $ draw_entire_line 5 "\e[0;38;5;198m"
  ##
  ##         ^             ^          ^
  ##    function        Linestyle  Color
  #############################################
  ##
  ## Replace current prompt with a blue bar
  ##
  ##    $ draw_entire_line 6 "^[[1A^[[2K^[[1A^[[2K\e[0;38;5;33m"
  ##
  ## for i in $(seq 1 255); do draw_entire_line 4 "^[[1A^[[2K\r\e[0;38;5;${i}m"; sleep 0.1; done
  ## for i in $(seq 1 255); do draw_entire_line 4 "\n^[[1A^[[2K\e[0;38;5;${i}m"; sleep 0.1; done
  ## for i in $(seq 0 16); do draw_entire_line 6 "\e[?25l\n^[[1A^[[2K\e[0;38;5;${i}m"; sleep 0.05; done; printf "\e[?25h"
  ##
  ## printf "\e[?25h" ## Restore cursor
  #############################################
  ## Index of which line type to use (1-10)
  LINECHAR="$1"
  ## Color of the linee
  colorline="${2}"
  ## Default line
  solidline="${(mr:$COLUMNS::─:)}"

  [[ "${LINECHAR}" -eq 1  ]] && solidline="${(mr:$COLUMNS::─:)}"
  [[ "${LINECHAR}" -eq 2  ]] && solidline="${(mr:$COLUMNS::═:)}"
  [[ "${LINECHAR}" -eq 3  ]] && solidline="${(mr:$COLUMNS::═:)}"
  [[ "${LINECHAR}" -eq 4  ]] && solidline="${(mr:$COLUMNS::─:)}"
  [[ "${LINECHAR}" -eq 5  ]] && solidline="${(mr:$COLUMNS::▂:)}"
  [[ "${LINECHAR}" -eq 6  ]] && solidline="${(mr:$COLUMNS::▄:)}"
  [[ "${LINECHAR}" -eq 7  ]] && solidline="${(mr:$COLUMNS::▀:)}"
  [[ "${LINECHAR}" -eq 8  ]] && solidline="${(mr:$COLUMNS::─:)}"
  [[ "${LINECHAR}" -eq 9  ]] && solidline="${(mr:$COLUMNS::─:)}"
  [[ "${LINECHAR}" -eq 10 ]] && solidline="${(mr:$COLUMNS::#:)}"

  printf "${colorline}${solidline}\e[0m"
}

### {{{ OS SPECIFIC  {{{
###   {{{ LINUX SPECIFIC
###     {{{ ARCHLINUX  SPECIFIC

SYSARCH_OSTYPE_UNIX_LINUX_ARCHLINUX="true" ## TODO:
if [[ -n "${SYSARCH_OSTYPE_UNIX_LINUX_ARCHLINUX}" ]]; then
  if command -v yay >/dev/null 2>&1; then
    alias yay='yay --color always'
    alias yayi='yay -S --color always --verbose'
    alias yayinstall='yay -S --color always --verbose'
    alias yaylist='yay -Q --color always'
    alias yays-aur='yay -Ss --color always --sortby votes --aur'
    alias yays='yay -Ss --color always --sortby votes'
    alias yaysearch-modified='yay -Ss --color always --sortby modified'
    alias yaysearch-name='yay -Ss --color always --sortby name'
    alias yaysearch-popular='yay -Ss --color always --sortby popularity'
    alias yaysearch-votes='yay -Ss --color always --sortby votes'
    alias yaysearch='yay -Ss --color always'
    alias yaysi='yay -S -ii --color always'
  fi
fi ; unset SYSARCH_OSTYPE_UNIX_LINUX_ARCHLINUX
###     }}} OARCHLINUX  SPECIFIC
###   }}} LINUX SPECIFIC
### }}} OS SPECIFIC  }}}


if command -v shellcheck >/dev/null 2>&1; then
  function bat_preview_languages(){
      local viewfile="$1"
      [[ -z "$viewfile" ]] && local viewfile="$HOME/*"
      local batlangsdirt=$(bat --list-languages | sort --reverse)
      local batlangs=$(echo "$batlangsdirt" | awk -F ":" '{print $2}' | awk -F "," '{print $1}' | awk '{print $1}')
      echo "$batlangs" | fzf --preview-window=right,80% --preview="bat --language={} --color=always $viewfile"
  } ; alias bat-preview-languages="bat_preview_languages"
fi
function c(){
    local catthis
       catthis="$1"
       [[ -z "${catthis}" ]] && return 1
       [[ -z "${PAGER}"   ]] && PAGER="less"
       [[ -f "${catthis}" ]] && "${PAGER}" "${catthis}" && return 0
    if [[ -d "${catthis}" ]]; then
      cd "${catthis}" || printf "failed to cd" || return 1
    fi
  }

#{{{ LS ALIASES
alias sl="ls"
alias ll="ls --long -A"
alias l="ls -1 -A"
alias sls="ls"




#{{{ LSD

if [[ "${commands[lsd]}" ]]; then
  alias lsd="lsd --color always --icon always"
  alias ls="lsd --color always --icon always"
  alias 'cd ls'='lsd'
  alias ks='ls'
  alias la='ls'
  alias s='lsd'
  alias LS='lsd'
  # alias lllll='draw_entire_line 5 "\e[0;1;38;5;82m"; draw_entire_line 5 "\e[0;1;38;5;198m; lsd --long -A --sort=size --reverse --total-size; draw_entire_line 5 "\e[0;1;38;5;198m; draw_entire_line 5 "\e[0;1;38;5;198m"'
  alias lla='lsd --all --long --total-size --sizesort --reverse'
  alias lstree="lsd --almost-all --tree --total-size --human-readable ${1} 2>/dev/null"                                    # List All On One Line Recurse Sort By Modification Time Long List Reversed
  alias lst="lsd --oneline --long --almost-all --reverse --timesort --human-readable ${1} 2>/dev/null"                   # List All On One Long Line Sort By Modification Time
  alias lltree='printf "\e[0;1;38;5;46mGathering tree ...\n\n\e[0;1;38;5;33mThis may take a while\e[0;1;38;5;190m     \e[0m\n"; echo "$(lsd   --almost-all --tree --total-size -l --sort=time --human-readable --depth=10 2>/dev/null)"'
  alias l='lsd  --oneline --no-symlink --almost-all' # List All On One Line

  ## lsd flags in alieas set below require a newer version of lsd
  ## Right now, debian repos do not have a version which supports some options.
  ## REQUIRE VERSION  0.22.0 or later: https://github.com/Peltoche/lsd/releases/tag/0.22.0
  lsdversion=
  lsdversion="$(${commands[lsd]} --version 2>/dev/null | cut -d' ' -f2 )"
  islsd22(){ [[ $lsdversion == <0->.<22->.* ]]; }
  if islsd22; then
    ## LSD_UNSUPPORTED is unset, add these aliases
    alias lls="printf '\e[0;1;38;5;93m🍆💦🍑\e[0;1;3;4;38;5;199mThis could take a hot sec...\e[0m\e[0;1;38;5;93m🍄🦄🐉\e[0m\t'; date +'%Y%m%d_%H%M%S';  lsd --long --sort=size --header --color=always --total-size --date=+'%Y%m%d%H%M%S' --almost-all --dereference --blocks 'size,date,name' --reverse --permission octal 2>/dev/null"
    alias ll='lsd --oneline --long --almost-all --permission octal --date=+%Y%m%d-%H%M%S'
    alias lsl='lsd --oneline --long --almost-all --date=+%Y%m%d-%H%M%S'
    alias lsl='lsd --oneline --long --almost-all --date=+%Y%m%d-%H%M%S --sort extension'
    alias sl='lsd --oneline --long --almost-all --permission octal' # List All On One Line Sort By Extension
  else
    printf "\e[0;3;38;5;8mSome options from the 'lsd' command are not availiable in your current version.\n\nPlease upgrade to at least v0.22.0\n\nInstall with cargo:\n\n    cargo install lsd\n\nInstall binary on Debian based systems:\n\n    curl -LO 'https:/github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb' \\ \n        && [sudo] dpkg -i lsd_0.23.1_amd64.deb\n"
  fi
fi

#}}} LSD

#{{{ EXA
# _EXA=$(command -v exa | awk '{print $2}')
# if [[ -f "$_EXA" ]]; then
# ### exa
if [[ "${commands[exa]}" ]]; then
#   alias exa='exa --color always --colour-scale --icons --numeric --git --time-style=long-iso --long'
#   alias l1='exa  --oneline --all --header'
#   alias ls-l="exa --long --all"
#   alias ls-ll="exa --sort=type --tree --recurse --long --all"
  alias lst="exa --sort time --colour-scale --long --all --time-style=long-iso --no-user --no-permissions --header --no-icons  --accessed --modified"
  alias exa="exa --color always --color-scale --icons --all"
  alias l1='exa  --oneline --all --header'                        # List All On One Line
  alias lll='exa --long --octal-permissions --all --header --no-time --no-user --sort=type --colour-scale'
  alias llllll='draw_entire_line 2 "\e[0;1;38;5;93m"; lsd --long -A sort=size --reverse --total-size; draw_entire_line 2 "\e[0;1;38;5;93m"'
  alias llsa='exa --color-scale --long --all --long --icons --group-directories-first --sort=size --no-permissions --no-time --no-user --tree --level 3'
  alias ls-l="exa --sort=type --long --all"
fi



#}}}EXA
##}}}


if command -v shellcheck >/dev/null 2>&1; then
  alias shellcheck-all="shellcheck --check-sourced --enable=all --list-optional --color=always --external-sources --format=tty --wiki-link-count=20"
  function shellcheck-harden(){
    local line="────────────────────────────────────────────────────────────────────────────────"
    echo "$line"
    shellharden --suggest --syntax-suggest $1
    echo "$line"
    shellcheck --check-sourced --enable=all --color=always --external-sources --format=tty --wiki-link-count=20 $1
    echo "$line"
    shellcheck --check-sourced --enable=all --list-optional --color=always --external-sources --format=tty --wiki-link-count=20 $1
    echo "$line"
  }
fi


alias duviz="duviz --color --no-progress --max-depth=50"
alias watch="watch --color --interval 0.25 --no-title --no-wrap"
alias watch-ls="watch --color --interval 0.1 --no-title --no-wrap lsd --color always --almost-all --long --header  --date=+%Y-%m-%d_%H:%M:%S --blocks date,size,name --sort time 2>/dev/null"
alias watch-lls="watch --color --interval 0.25 --no-title --no-wrap lsd --color always --almost-all --long --header  --date=+%Y-%m-%d_%H:%M:%S --blocks date,size,name --sort size --total-size 2>/dev/null"
alias watch-duviz="watch --color --interval 0.1 --no-title --no-wrap duviz --color --no-progress --max-depth=50 2>/dev/null"
