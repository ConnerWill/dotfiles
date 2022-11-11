timelogging_start "10"
### [=]===========================================================[=]
###	[~] -------------------- ZSH VARIABLES -----------------------[~]
### [=]===========================================================[=]
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSHRC="$ZDOTDIR/.zshrc"
export ZSHRC_USER="${ZSHRC}"
export ZSHRC_GLOBAL="/etc/zsh/zshrc"
export ZCOMPCACHE_PATH="${XDG_CACHE_HOME}/zsh/zcompcache"
export COMPDUMPFILE=${COMPDUMPFILE:-${XDG_CACHE_HOME}/zsh/zcompdump}
export DOTFILES="${HOME}/.dotfiles"
export LESSHISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/less/lesshist"
[[ ! -d $(dirname "${LESSHISTFILE}") ]] && mkdir -p $(dirname "${LESSHISTFILE}")

### [=]==================================[=]
### [~]........ TERM COLORS
### [=]==================================[=]
export CLICOLOR=1
export TERM=xterm-256color
case ${TERM} in
  iterm            |\
  linux-truecolor  |\
  screen-truecolor |\
  tmux-truecolor   |\
  xterm-truecolor  )    export COLORTERM=truecolor ;;
  vte*)
esac

### [=]==================================[=]
### [~]............ BROWSER
### [=]==================================[=]
[[ -n "$DISPLAY" ]] && export BROWSER="/usr/bin/firefox"
[[ -z "$DISPLAY" ]] && export BROWSER="/usr/bin/lynx"

### [=]==================================[=]
### [~]............ EDITOR
### [=]==================================[=]
export EDITOR="nvim" # "nano" # "vim"
export FCEDIT="$EDITOR"
export NVIMDIR="$XDG_CONFIG_HOME/nvim"

### [=]==================================[=]
### [~]........... MANPAGER
### [=]==================================[=]
export MANPAGER='nvim +Man!'
MANWIDTH="$(( $COLUMNS - (( $COLUMNS / 4 )) ))"
export MANWIDTH #=120
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

## [=]==================================[=]
## [~]............ PAGER
## [=]==================================[=]
export PAGER="less"
export PAGER="bat"
export BAT_PAGER="less -RFi"
export GH_PAGER="bat"
export BAT_CONFIG_PATH="${XDG_CONFIG_HOME}/bat/config"
man() {
	export MANWIDTH="$(( $COLUMNS - (( $COLUMNS / 1 )) ))"
    env \
        LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
        LESS_TERMCAP_md="$(printf "\e[1;35m")" \
        LESS_TERMCAP_me="$(printf "\e[0m")" \
        LESS_TERMCAP_se="$(printf "\e[0m")" \
        LESS_TERMCAP_so="$(printf "\e[4;36m")" \
        LESS_TERMCAP_ue="$(printf "\e[0m")" \
        LESS_TERMCAP_us="$(printf "\e[3;34m")" \
        PAGER="${commands[less]:-${PAGER}}" \
				MANWIDTH="$(( $COLUMNS - (( $COLUMNS / 1 )) ))" \
    man "$@"
}

### [=]==================================[=]
### [~]........... GPG / SSH
### [=]==================================[=]
GNUPGHOME="$XDG_CONFIG_HOME/.gnupg"
GPG_TTY=$(tty)
GPG_TUI_CONFIG="$XDG_CONFIG_HOME/gpg-tui/gpg-tui.toml"
export GNUPGHOME GPG_TTY
export GPG_TUI_CONFIG

### [=]==================================[=]
### [~]........... MAIL
### [=]==================================[=]
export EMAIL="Conner.Will@connerwill.com"

### [=]==================================[=]
### [~]........... TEMP
### [=]==================================[=]
export TEMPDIR="$HOME/temporary"

### [=]==================================[=]
### [~]........... AWESOMEWM
### [=]==================================[=]
AWESOMEWM_CONFIG_DIR="$XDG_CONFIG_HOME/awesome"
[[ -d "$AWESOMEWM_CONFIG_DIR" ]] \
	&& export AWESOMEWM_CONFIG_DIR \
	&& export AWESOME_THEMES_PATH="$AWESOMEWM_CONFIG_DIR/themes" 

### [=]==================================[=]
### [~]............ Lynx
### [=]==================================[=]
export LYNX_CONFIG_DIR_LOCAL="$XDG_CONFIG_HOME/lynx"
export LYNX_CONFIG_DIR_GLOBAL="/usr/share/lynx"
export LYNX_CFG="$LYNX_CONFIG_DIR_LOCAL/lynx.cfg"                  # This variable, if set, will override the default location and name of the global configuration file (normally, lynx.cfg) that was defined by the  LYNX_CFG_FILE  constant  in  the userdefs.h file, during installation.
export LYNX_SESSION="$LYNX_CONFIG_DIR_LOCAL/lynx_session"          # file name where lynx will store user sessions. This setting is used only when AUTO_SESSION is true. Note: the default setting will store/resume each session in a different folder under same file name (if that is allowed by operating system) when lynx is invoked from different directories.
export LYNX_LSS="$LYNX_CONFIG_DIR_LOCAL/lynx.lss"                  # This variable, if set, specifies the location of the default Lynx character style sheet file.  [Currently only meaningful if Lynx was built using curses color style support.]
export LYNX_CFG_PATH="$LYNX_CONFIG_DIR_LOCALL"                     # If  set, this variable overrides the compiled-in search-list of directories used to find the configuration files, e.g., lynx.cfg and lynx.lss.  The list is delimited with ":" (or #   ;" for Windows) like the PATH environment variable.
export LYNX_HELPFILE="$LYNX_CONFIG_DIR_GLOBAL/lynx_help_main.html" # If set, this variable overrides the compiled-in URL and configuration file URL for the Lynx help file.
export WWW_HOME="$LYNX_CONFIG_DIR_GLOBAL/lynx-homepage.html"       # This variable, if set, will override the default startup URL specified in any of the Lynx configuration files.

### [=]==================================[=]
### [~]............ git
### [=]==================================[=]
export GITHUB_URL="https://github.com"
export GH_URL="https://github.com"
export GH_EDITOR="/usr/bin/nvim"
export GH_BROWSER="kitty --title GitHub /usr/bin/lynx"
export GH_CONFIG_DIR="$XDG_CONFIG_HOME/gh"
export GIT_CONFIG_DIR="$XDG_CONFIG_HOME/git"
export GITIGNORE_DIR="$HOME/.gitignore-boilerplates"
export MYPROJECTS="$HOME/scripts/MYPROJECTS"

### [=]==================================[=]
### [~]............ SCRIPTS
### [=]==================================[=]
export SCRIPTS="$HOME/scripts"
export BASHSCRIPTSDIR="${SCRIPTS}/bash"
export BASHSNIPPETSDIR="${SCRIPTS}/bash/development/snippets"
export BASHTEMPLATEDIR_BEST="${SCRIPTS}/bash/development/snippets/templates-bash/best-script-templates/extended-cd"
export BASHTEMPLATESDIR="${SCRIPTS}/bash/development/snippets/templates-bash"
export CHEATSHEETSSCRIPTSDIR="${SCRIPTS}/cheatsheets" ### cheatsheets
export POWERSHELLSCRIPTSDIR="${SCRIPTS}/powershell" ### Powershell Scripts
export PYTHONSCRIPTSDIR="${SCRIPTS}/python" ### Python Scripts
export MPVSCRIPTSDIR="${SCRIPTS}/mpv-scripts"
export BASHTEMPLATE_VERY_NICE_INDEED="${SCRIPTS}/bash/development/templates-bash/FULL-PACKAGE-ZSH-BASH-TEMPLATE"

### [=]==================================[=]
### [~]............. GIMP ...............
### [=]==================================[=]
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME/GIMP/2.10"
export GIMPHOMECONFIGPATH='/home/dampsock/.config/GIMP/2.10'
export GIMPHOMECACHEPATH='/home/dampsock/.cache/gimp/2.10'


#### [=]==================================[=]
### [~]............. ASCIINEMA ..........
### [=]==================================[=]
export VIDEODIR="$HOME/videos"
export YOUTUBEDOWNLOADSDIR="$VIDEODIR/youtube-downloads"
export ASCIINEMA_CONFIG_HOME="$XDG_CONFIG_HOME/asciinema"
export ASCIINEMA_OUTPUT_DIR="$HOME/videos/terminal-recordings"

### [=]==================================[=]
### [~]............. NMAP ...............[~]
### [=]==================================[=]
export NMAPAUTOSCANOUTPUTDIR="$NMAPSCANOUTPUTDIR/local-subnet/nmap-auto"
export NMAPDIR="/usr/share/nmap"
export NMAPSCRIPTSDIR="/usr/share/nmap"
export NMAPSCANOUTPUTDIR="$HOME/security/nmap-scans"
export nmapAutomatorPATH="/scripts/pentest/nmapAutomator"


### [=]==================================[=]
### [~]............ METASPLOIT
### [=]==================================[=]
export METASPLOITMODULESPATH="/opt/metasploit/modules"
export METASPLOITPATH="/opt/metasploit"


### [=]==================================[=]
### [~]............ PYTHON
### [=]==================================[=]
export GENCOMPL_PY="python"
export PYTHONPATH="$HOME/.local/bin:$PATH"
export IPYTHONDIR="$HOME/.config/ipython"
export IPYTHON_CONFIG="$IPYTHONDIR/profile_default/ipython_config.py"

### [=]==================================[=]
### [~]........... DOWNLOADS
### [=]==================================[=]
export DOWNLOADS="$HOME/Downloads"

### [=]==================================[=]
### [~]............ BACKUPS
### [=]==================================[=]
export BACKUPDIR="/backups"

### [=]==================================[=]
### [~]............ ICONS
### [=]==================================[=]
export ICONSDIRGLOBAL="/usr/share/icons"
export ICONSDIR="$HOME/pictures/icons"
export ICONSTINYDIR="$HOME/pictures/icons/SuperTinyIcons/images"

### [=]==================================[=]
### [~]............ FONTS
### [=]==================================[=]
export FONTSDIRGLOBAL="/usr/share/fonts"
export FONTSDIR="${HOME}/.local/share/fonts"

### [=]==================================[=]
### [~]............ THEMES
### [=]==================================[=]
export THEMEDIRGLOBAL="/usr/share/themes"

### [=]==================================[=]
### [~]............ CAD / 3D
### [=]==================================[=]
export CAD="$HOME/3D-CAD"
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

### [=]==================================[=]
### [~]............, QT
### [=]==================================[=]
export QtProject_Config="/home/dampsock/.config/QtProject"
export QT_QPA_PLATFORMTHEME="/home/dampsock/.config/qt5ct"

### [=]==================================[=]
### [~]............ TMUX
### [=]==================================[=]
export TSM_HOME="$XDG_DATA_HOME/tsm"
export TSM_SESSIONS_DIR="$TSM_HOME/sessions"
export TSM_BACKUPS_DIR="$TSM_HOME/backups"
export TSM_DEFAULT_SESSION_FILE="$TSM_HOME/default-session.txt"
export TSM_BACKUPS_COUNT=30

export _ZL_CMD="z"
[[ ! -d "$XDG_CACHE_HOME/zsh/z.lua" ]] && mkdir -v -p "$XDG_CACHE_HOME/zsh/z.lua" || export _ZL_DATA="$XDG_CACHE_HOME/zsh/z.lua/zlua"
export _ZL_MAXAGE="100000"
export _ZL_ECHO="1"
export _ZL_MATCH_MODE="1"
export _ZL_HYPHEN="1"
export _ZL_CLINK_PROMPT_PRIORITY="99"
export _ZL_ROOT_MARKERS=".git,.svn,.hg,.root,package.json"

### MISC
export RAINBOW_CONFIGS="$XDG_CONFIG_HOME/rainbow"
export BACKUPDIR_LOCAL="$HOME/backup"
export PYENV_ROOT="$HOME/.pyenv"
export COOKIECUTTER_CONFIG="$XDG_CONFIG_HOME/cookiecutters/cookiecutter-custom-config.yaml"
export KITTY_CONFIG_DIR="$XDG_CONFIG_HOME/kitty"
export KITTY_CONFIG="$KITTY_CONFIG_DIR/kitty.conf"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export TRANSMISSION_HOME="${XDG_CONFIG_HOME}/transmission"

export WGETHSTS="${WGETHSTS:-${HOME}/.cache/.wget-hsts}"

timelogging_end 10
