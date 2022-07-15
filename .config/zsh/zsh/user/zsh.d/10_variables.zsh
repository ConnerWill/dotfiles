###     [=]===========================================================[=]
###	  	[~] -------------------- ZSH VARIABLES -----------------------[~]
###     [=]===========================================================[=]
###{{{

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh"
export ZDOTDIR_PLUGINS="$XDG_CONFIG_HOME/zsh/plugins"
export ZSH_CUSTOM_PLUGINS="$ZDOTDIR/plugins"
export ZSHRC="$ZDOTDIR/.zshrc"
export ZSHRC_USER="$ZDOTDIR/.zshrc"
export ZSHRC_GLOBAL="/etc/zsh/zshrc"
export ZSHDDIR="$ZDOTDIR/zsh.d"
export ZSH_COMPLETIONS_DIR="$ZDOTDIR/completions/completions"
export GENCOMPL_FPATH="$ZSH_COMPLETIONS_DIR"
export GENCOMPL_PY="python"

###}}}


export ZCOMPCACHE_PATH="${XDG_CACHE_HOME}/zsh/zcompcache"

#
#
# export XDG_STATE_HOME="$HOME/.local/state"
# export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
# export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
#
#
#
# export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
#
#
#
#
#
# export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
#
# export GOPATH="$XDG_DATA_HOME"/go
#
# $HOME/.wget-hsts
#
# alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
#
#
# compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
#
# export HISTFILE="$XDG_STATE_HOME"/zsh/history
#
#
# export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
# export CARGO_HOME="$XDG_DATA_HOME"/cargo
#
# export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
#
# export HISTFILE="${XDG_STATE_HOME}"/bash/history
# export ANDROID_HOME="$XDG_DATA_HOME"/android
#
#
### uncomment lines above

### [=]==================================[=]
### [~]............ SOURCE PATH
### [=]==================================[=]
###{{{

export PATH="${PATH}:$HOME/.bin"
export PATH="${PATH}:$HOME/.local/bin"
export PATH="${PATH}:$HOME/.local/lib/bat-extras/bin"
export PATH="${PATH}:$HOME/.local/bin/Python/3.8/bin"
export PATH="${PATH}:$HOME/.local/share/gem/ruby/3.0.0/bin"
export PATH="${PATH}:$HOME/.local/share/OpenSCAD/libraries/NopSCADlib/scripts"
export PATH="${PATH}:$HOME/.local/share/OpenSCAD/libraries"
export PATH="${PATH}:/opt/nmapbar"

##    ###=========================================###
##    # According to the Zsh Plugin Standard:
##    # https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
##    
##    0=${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}
##    0=${${(M)0:#/*}:-$PWD/$0}
##    
##    # Then ${0:h} to get plugin's directory
##    
##    if [[ ${zsh_loaded_plugins[-1]} != */_set_path && -z ${fpath[(r)${0:h}]} ]] {
##        fpath+=( "${0:h}" )
##    }
##    
##    # Standard hash for plugins, to not pollute the namespace
##    typeset -gA Plugins
##    Plugins[_SET_PATH_DIR]="${0:h}"
##    
##    if [[ -d "$HOME/go/bin" ]]; then
##        export PATH="$PATH:$HOME/go/bin"
##    fi
##    
##    if [[ -d "$HOME/edirect" ]]; then
##        export PATH="$PATH:$HOME/edirect"
##    fi
##    
##    # Use alternate vim marks [[[ and ]]] as the original ones can
##    # confuse nested substitutions, e.g.: ${${${VAR\}}  <--  }
##    

###}}}

### [=]==================================[=]
### [~]........ TERM COLORS
### [=]==================================[=]
###{{{

export TERM=xterm-256color
#case $TERM in
case ${TERM} in
  iterm            |\
  linux-truecolor  |\
  screen-truecolor |\
  tmux-truecolor   |\
  xterm-truecolor  )    export COLORTERM=truecolor ;;
  vte*)
esac

###}}}
### [=]==================================[=]
### [~]............ BROWSER
### [=]==================================[=]

###{{{
##  If in GUI
[[ -n "$DISPLAY" ]] &&
	export BROWSER="/usr/bin/firefox"

##  If in TTY
[[ -z "$DISPLAY" ]] &&
	export BROWSER="/usr/bin/lynx"

###}}}
### [=]==================================[=]
### [~]............ EDITOR
### [=]==================================[=]

###{{{
export EDITOR="nvim"
export FCEDIT="$EDITOR"
#export EDITOR="nano"
#export EDITOR="vim"

###}}}
### [=]==================================[=]
### [~]........... MANPAGER
### [=]==================================[=]
###{{{
#export MANPATH="/usr/local/man:$MANPATH"
#export MANPATH="/usr/share/man:$MANPATH"
#export MANPATH="$HOME/.local/lib/bat-extras/man:$MANPATH"
#export MANPATH="$ZDOTDIR/zsh-man:$MANPATH"
#export ZSH_MANPATH="$ZDOTDIR/zsh-man:$ZSH_MANPATH"
export MANPAGER='nvim +Man!'
# export MANWIDTH=999
export MANWIDTH=120


function _set_nvim_man_pager() {
	if [ -z "$MANPAGER" ]; then  # Return if MANPAGER is already set
		export NVIMBINPATH
		NVIMBINPATH="$(which nvim)" # Check if nvim is installed
		if [ -n "$NVIMBINPATH" ]; then
			export NVIMPAGER
			NVIMPAGER="$(which nvimpager)" # Check if nvimpager is installed
			if [ -n "$NVIMPAGER" ]; then # Define NVIMPAGER as MANPAGER
				MANPAGER="${NVIMPAGER}"
			else # Define nvim as MANPAGER
				MANPAGER='nvim +Man!'
			fi
		export MANPAGER="$MANPAGER" # Export MANPAGER
		return 0
		else # Cannot find MANPAGER
			[[ -z "$MANPAGER" ]] \
				&& unset MANPAGER # Unset manpager 
			return 0
		fi
	else # "manpager is already set to $MANPAGER"
		return 0
	fi
}
_set_nvim_man_pager
#unfunction _set_nvim_man_pager

###{{{
##  Could also set nvim as manpager with:
##    export MANPAGER="nvim -c 'set ft=man' -"
##  Or vim as manpager with:
##    export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
##  Or bat as MANPAGER with:
##    export MANPAGER="sh -c 'col -bx | bat -l man -p'"

##  INFODIR contains a colon-separated list of directories
##  in which the info command searches for the info pages,
##    e.g., /usr/share/info:/usr/local/share/info

###}}}

###}}}
## [=]==================================[=]
## [~]............ PAGER
## [=]==================================[=]
###{{{
#    -F --quit-if-one-screen    exit if entire file fits on first screen
#    -R --RAW-CONTROL-CHARS     display control chars; keep track of screen effects
#    -i --ignore-case           ignore case in searches that lack uppercase
export PAGER="less"
export PAGER="bat"
export BAT_PAGER="less -RFi"
export GH_PAGER="/usr/bin/bat"
export BAT_CONFIG_PATH="${XDG_CONFIG_HOME}/bat/config"
export BAT_THEME="Dracula" #"TwoDark" "Coldark-Dark"


man() {
    env \
        LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
        LESS_TERMCAP_md="$(printf "\e[1;35m")" \
        LESS_TERMCAP_me="$(printf "\e[0m")" \
        LESS_TERMCAP_se="$(printf "\e[0m")" \
        LESS_TERMCAP_so="$(printf "\e[4;36m")" \
        LESS_TERMCAP_ue="$(printf "\e[0m")" \
        LESS_TERMCAP_us="$(printf "\e[3;34m")" \
        PAGER="${commands[less]:-${PAGER}}" \
        PATH="${HOME}/bin:${PATH}" \
            man "$@"
}


###}}}
### [=]==================================[=]
### [~]........... GPG / SSH
### [=]==================================[=]
###{{{
export GNUPGHOME="$XDG_CONFIG_HOME/.gnupg"
export GPG_TTY=$(tty)
export GPG_TUI_CONFIG="$XDG_CONFIG_HOME/gpg-tui/gpg-tui.toml"

#unset SSH_AGENT_PID
#SSH_AGENT_PID=""
#SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
#export PINENTRY_USER_DATA
#export XAUTHORITY
#export XMODIFIERS
#export XDG_SESSION_TYPE
#export DBUS_SESSION_BUS_ADDRESS

###}}}

### [=]==================================[=]
### [~]........... MAIL
### [=]==================================[=]
###{{{

export EMAIL="Conner.Will@outlook.com"
## The user's email address.

#export MAIL="/var/spool"
## Full path of the user's spool mailbox.

#export MAILDIR
## Full path of the user's spool mailbox if MAIL is unset. Commonly used when the spool ma

#export MAILCAPS
## Path to search for mailcap files. If unset, a RFC1524 compliant search path that is extended with NeoMutt related paths (at position two and three): "$HOME/.mailcap:/usr/share/neomutt/mailcap:/etc/mailcap:/etc/mailcap:/usr/etc/mailcap:/usr/local/etc/mailcap" will be used instead. ilbox is a maildir(5) folder.

#export MM_NOASK
## If this variable is set, mailcap are always used without prompting first.

#export NNTPSERVER
## Similar to configuration variable $news_server, specifies the domain name or address of the default NNTP server to connect. If unset, /etc/nntpserver is used but can be overridden by command line option -g.

#export RANDFILE
## Like configuration variable $entropy_file, defines a path to a file which includes random data that is used to initialize SSL library functions. If unset, ~/.rnd is used. DO NOT store important data in the specified file.

#export REPLYTO
## When set, specifies the default Reply-To address.

#export TEXTDOMAINDIR
## Defines an absolute path corresponding to /usr/share/locale that will be recognised by GNU gettext(1) and used for Native Language Support (NLS) if enabled.

#export TMPDIR
## Directory in which temporary files are created. Defaults to /tmp if unset. Configuration variable $tmpdir takes precedence over this one.

#export EGDSOCKET
## For OpenSSL since version 0.9.5, files, mentioned at RANDFILE below, can be Entropy Gathering Daemon (EGD) sockets. Also, and if exists, ~/.entropy and /tmp/entropy will be used to initialize SSL library functions. Specified sockets must be owned by the user and have permission of 600 (octal number representing).

###}}}

### [=]==================================[=]
### [~]........... TEMP
### [=]==================================[=]
###{{{

export TEMPDIR="$HOME/temporary"

###}}}

### [=]==================================[=]
### [~]........... AWESOMEWM 
### [=]==================================[=]
###{{{

AWESOMEWM_CONFIG_DIR="$XDG_CONFIG_HOME/awesome"
[[ -d "$AWESOMEWM_CONFIG_DIR" ]] \
	&& export AWESOMEWM_CONFIG_DIR \
	&& export AWESOME_THEMES_PATH="$AWESOMEWM_CONFIG_DIR/themes" 


###}}}

### [=]==================================[=]
### [~]............ Lynx
### [=]==================================[=]
###{{{
export LYNX_CONFIG_DIR_LOCAL="$XDG_CONFIG_HOME/lynx"
export LYNX_CONFIG_DIR_GLOBAL="/usr/share/lynx"
export LYNX_CFG="$LYNX_CONFIG_DIR_LOCAL/lynx.cfg"                  # This variable, if set, will override the default location and name of the global configuration file (normally, lynx.cfg) that was defined by the  LYNX_CFG_FILE  constant  in  the userdefs.h file, during installation.
export LYNX_SESSION="$LYNX_CONFIG_DIR_LOCAL/lynx_session"          # file name where lynx will store user sessions. This setting is used only when AUTO_SESSION is true. Note: the default setting will store/resume each session in a different folder under same file name (if that is allowed by operating system) when lynx is invoked from different directories.
export LYNX_LSS="$LYNX_CONFIG_DIR_LOCAL/lynx.lss"                  # This variable, if set, specifies the location of the default Lynx character style sheet file.  [Currently only meaningful if Lynx was built using curses color style support.]
export LYNX_CFG_PATH="$LYNX_CONFIG_DIR_LOCALL"                     # If  set, this variable overrides the compiled-in search-list of directories used to find the configuration files, e.g., lynx.cfg and lynx.lss.  The list is delimited with ":" (or #   ;" for Windows) like the PATH environment variable.
export LYNX_HELPFILE="$LYNX_CONFIG_DIR_GLOBAL/lynx_help_main.html" # If set, this variable overrides the compiled-in URL and configuration file URL for the Lynx help file.
export WWW_HOME="$LYNX_CONFIG_DIR_GLOBAL/lynx-homepage.html"       # This variable, if set, will override the default startup URL specified in any of the Lynx configuration files.

###}}}
### [=]==================================[=]
### [~]............ git
### [=]==================================[=]
###{{{
export GITHUB_URL="https://github.com"
export GH_URL="https://github.com"
export GH_EDITOR="/usr/bin/nvim"
export GH_BROWSER="kitty --title GitHub /usr/bin/lynx"
export GH_CONFIG_DIR="$XDG_CONFIG_HOME/gh"
export GIT_CONFIG_DIR="$XDG_CONFIG_HOME/git"
export GITIGNORE_DIR="$HOME/.gitignore-boilerplates"
export MYPROJECTS="$HOME/scripts/MYPROJECTS"
#export GH_TOKEN="$(cat $GH_CONFIG_DIR/.GH_TOKEN)"
#export GLAMOUR_STYLE="/usr/bin/bat"

###}}}
### [=]==================================[=]
### [~]............. GIMP ...............
### [=]==================================[=]
###{{{
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME/GIMP/2.10"
# export GIMPUSRSHAREPATH='/usr/share/gimp/2.0'
# export GIMPUSRLIBPATH='/usr/lib/gimp/2.0'
# export GIMPETCPATH='/etc/gimp/2.0'
export GIMPHOMECONFIGPATH='/home/dampsock/.config/GIMP/2.10'
export GIMPHOMECACHEPATH='/home/dampsock/.cache/gimp/2.10'

###}}}

### ASCIINEMA
###{{{
export VIDEODIR="$HOME/videos"
export YOUTUBEDOWNLOADSDIR="$VIDEODIR/youtube-downloads"
export ASCIINEMA_CONFIG_HOME="$XDG_CONFIG_HOME/asciinema"
export ASCIINEMA_OUTPUT_DIR="$HOME/videos/terminal-recordings"

###}}}
### [=]==================================[=]
### [~]............. NMAP ...............[~]
### [=]==================================[=]
###{{{
## Nmap Auto Output Path
export NMAPAUTOSCANOUTPUTDIR="$NMAPSCANOUTPUTDIR/local-subnet/nmap-auto"
export NMAPDIR="/usr/share/nmap"
export NMAPSCRIPTSDIR="/usr/share/nmap"
export NMAPSCANOUTPUTDIR="$HOME/security/nmap-scans"
export nmapAutomatorPATH="/scripts/pentest/nmapAutomator"

###}}}
### [=]==================================[=]
### [~]............ METASPLOIT
### [=]==================================[=]
###{{{
export METASPLOITMODULESPATH="/opt/metasploit/modules"
export METASPLOITPATH="/opt/metasploit"

###}}}
### [=]==================================[=]
### [~]......... ZSH ASCII ART
### [=]==================================[=]
###{{{
export ZSH_ASCII_ART_DIR="$HOME/.config/zsh/art-animations"

###}}}
### [=]==================================[=]
### [~]............ PYTHON
### [=]==================================[=]
###{{{
export PYTHONPATH="$HOME/.local/bin:$PATH"
export IPYTHONDIR="$HOME/.config/ipython"
export IPYTHON_CONFIG="$IPYTHONDIR/profile_default/ipython_config.py"

###}}}
### [=]==================================[=]
### [~]............ SCRIPTS
### [=]==================================[=]
###{{{
### Bash Scripts
export SCRIPTS="$HOME/scripts"
export BASHSCRIPTSDIR="$HOME/scripts/bash"
export BASHSNIPPETSDIR="$HOME/scripts/bash/development/snippets"
export BASHTEMPLATEDIR_BEST="/home/dampsock/scripts/bash/development/snippets/templates-bash/best-script-templates/extended-cd"
export BASHTEMPLATESDIR="$HOME/scripts/bash/development/snippets/templates-bash"
### Powershell Scripts
export CHEATSHEETSSCRIPTSDIR="$HOME/scripts/cheatsheets"
### Powershell Scripts
export POWERSHELLSCRIPTSDIR="$HOME/scripts/powershell"
### Python Scripts
export PYTHONSCRIPTSDIR="$HOME/scripts/python"

###}}}
### [=]==================================[=]
### [~]........... DOWNLOADS
### [=]==================================[=]
###{{{
export DOWNLOADS="$HOME/Downloads"

###}}}
### [=]==================================[=]
### [~]............ BACKUPS
### [=]==================================[=]
###{{{
export BACKUPDIR="/backups"

###}}}
### [=]==================================[=]
### [~]............ ICONS
### [=]==================================[=]
###{{{
export ICONSDIRGLOBAL="/usr/share/icons"
export ICONSDIR="$HOME/pictures/icons"
export ICONSTINYDIR="$HOME/pictures/icons/SuperTinyIcons/images"

###}}}
### [=]==================================[=]
### [~]............ FONTS
### [=]==================================[=]
###{{{
export FONTSDIRGLOBAL="/usr/share/fonts"
export FONTSDIR="/home/dampsock/.local/share/fonts"

###}}}
### [=]==================================[=]
### [~]............ THEMES
### [=]==================================[=]
###{{{
export THEMEDIRGLOBAL="/usr/share/themes"

###}}}
### [=]==================================[=]
### [~]............ CAD / 3D
### [=]==================================[=]
###{{{
### CAD
export CAD="$HOME/3D-CAD"

### 3D Models
export CADMODELSDIR="$HOME/3D-CAD/3d-models"
export MODELS="$HOME/3D-CAD/3d-models"

### OPENSCAD
export OPENSCADPATH="$HOME/.local/share/OpenSCAD/libraries"
### OpenSCAD Scripts
export OPENSCADSCRIPTSDIR="$HOME/3D-CAD/3D-CAD-scripts/openscad-scripts"

### FREECAD
export FREECAD_DIR_MOD_SYSTEM="/usr/share/freecad/Mod"
export FREECAD_DIR_MOD_USER="$HOME/.FreeCAD/Mod"
export FREECAD_DIR_MACRO_USER="$HOME/.FreeCAD/Macro"
### THINGIVERSE
export THINGIVERSEAPI='f7143904e459b01c40bf591344023919'

###}}}

### QT
###{{{
### QtProject
export QtProject_Config="/home/dampsock/.config/QtProject"
export QT_QPA_PLATFORMTHEME="/home/dampsock/.config/qt5ct"


###}}}

### [=]==================================[=]
### [~]............ MPV
### [=]==================================[=]
###{{{
### MPV Scripts
export MPVSCRIPTSDIR="$HOME/scripts/mpv-scripts"

export TRANSMISSION_HOME="$XDG_CONFIG_HOME/transmission"
export CLICOLOR=1
export BASHTEMPLATE_VERY_NICE_INDEED='/home/dampsock/scripts/bash/development/templates-bash/FULL-PACKAGE-ZSH-BASH-TEMPLATE'

###}}}

### [=]==================================[=]
### [~]............ TMUX
### [=]==================================[=]
###{{{
export TSM_HOME="$XDG_DATA_HOME/tsm"
export TSM_SESSIONS_DIR="$TSM_HOME/sessions"
export TSM_BACKUPS_DIR="$TSM_HOME/backups"
export TSM_DEFAULT_SESSION_FILE="$TSM_HOME/default-session.txt"
export TSM_BACKUPS_COUNT=30

#_**Note:** If_ $XDG_DATA_HOME_is not set **and** the_ $TSM_HOME_environment variable was not customized,_ $HOME/.local/share_will be used as fallback._

#}}}

### [=]==================================[=]
### [~].......... Z.LUA
### [=]==================================[=]
###{{{

##### Z.LUA PLUGIN
#####
# _ZL_CMD 							  change the command (default z).
# _ZL_DATA  						  change the datafile (default ~/.zlua).
# _ZL_NO_PROMPT_COMMAND		if you're handling PROMPT_COMMAND yourself.
# _ZL_EXCLUDE_DIRS				comma separated list of dirs to exclude.
# _ZL_ADD_ONCE						if set to '1' update database only if $PWD changed.
# _ZL_MAXAGE							define a aging threshold (default is 5000).
# _ZL_CD									specify your own cd command (default is builtin cd in Unix shells).
# _ZL_ECHO								if set to 1 to display new directory name after cd.
# _ZL_MATCH_MODE					if set to 1 to enable enhanced matching.
# _ZL_NO_CHECK						if set to 1 to disable path validation, use z --purge to clean
# _ZL_HYPHEN							if set to 1 to treat hyphon (-) as a normal character not a lua regexp keyword.
# _ZL_CLINK_PROMPT_PRIORITY change clink prompt register priority (default 99).



### https://github.com/skywind3000/z.lua
export _ZL_CMD="z"

[[ ! -d "$XDG_CACHE_HOME/zsh/z.lua" ]] \
	&& mkdir -v -p "$XDG_CACHE_HOME/zsh/z.lua" \
	|| export _ZL_DATA="$XDG_CACHE_HOME/zsh/z.lua/zlua"
#export _ZL_NO_PROMPT_COMMAND="
#export _ZL_EXCLUDE_DIRS="
#export _ZL_ADD_ONCE="1"
export _ZL_MAXAGE="100000"
#export _ZL_CD=""
export _ZL_ECHO="1"
export _ZL_MATCH_MODE="1"
#export _ZL_NO_CHECK=""
export _ZL_HYPHEN="1"
export _ZL_CLINK_PROMPT_PRIORITY="99"
export _ZL_ROOT_MARKERS=".git,.svn,.hg,.root,package.json"
####################
###}}}

### MISC
###{{{


export RAINBOW_CONFIGS="$XDG_CONFIG_HOME/rainbow"

export BACKUPDIR_LOCAL="$HOME/backup"
export PYENV_ROOT="$HOME/.pyenv"

export COOKIECUTTER_CONFIG="$XDG_CONFIG_HOME/cookiecutters/cookiecutter-custom-config.yaml"

export KITTY_CONFIG_DIR="$XDG_CONFIG_HOME/kitty"
export KITTY_CONFIG="$KITTY_CONFIG_DIR/kitty.conf"

export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
###}}}

export DOTFILES="${HOME}/.dotfiles"
[[ -n "${DOTFILES}" ]] && alias dotfiles="$(command -v git) --git-dir=${DOTFILES}/ --work-tree=${HOME}"
