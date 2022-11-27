
### [=]===========================================================[=]
###	[~] -------------------- ZSH VARIABLES -----------------------[~]
### [=]===========================================================[=]

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"

export ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"
export ZSHRC="${ZSHRC:-${ZDOTDIR/.zshrc}}"

export DOTFILES="${DOTFILES:-${HOME}/.dotfiles}"



export _ZL_CMD="z"
export _ZL_MATCH_MODE="1"
export _ZL_ECHO="1"
export _ZL_HYPHEN="1"
export _ZL_CLINK_PROMPT_PRIORITY="99"
export _ZL_MAXAGE="100000"
export _ZL_ROOT_MARKERS=".git,.svn,.hg,.root,package.json"

[[ ! -d "$XDG_CACHE_HOME/zsh/z.lua" ]] \
	&& mkdir -v -p "$XDG_CACHE_HOME/zsh/z.lua" \
	|| export _ZL_DATA="$XDG_CACHE_HOME/zsh/z.lua/zlua"

export chpwd_recent_dirs="${chpwd_recent_dirs:-${XDG_CACHE_HOME}/zsg/.chpwd-recent-dirs}"

## marked for removal
export ZSHRC_USER="${ZSHRC}"
export ZSHRC_GLOBAL="${ZSHRC_GLOBAL:-/etc/zsh/zshrc}"
## marked for removal

### [=]==================================[=]
### [~]........... MAIL
### [=]==================================[=]
export EMAIL="Conner.Will@connerwill.com"

### [=]==================================[=]
### [~]............ EDITOR
### [=]==================================[=]

#[[ "${commands[nvim]}" ]] && EDITOR="${EDITOR:-nvim}" || EDITOR="${EDITOR:-vim}"
EDITOR="${EDITOR:-${commands[nvim]:-${commands[vim]}}}"

FCEDIT="${EDITOR}"
export EDITOR FCEDIT

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
## If DISPLAY is set (running a WM or X11)
if [[ -n "$DISPLAY" ]]; then
	[[ "${commands[librewolf]}"   ]] && BROWSER="icecat"       ## Set the order of prefered browsers if when using a WM.
	[[ "${commands[icecat]}"      ]] && BROWSER="icecat"       ## Most prefered browser should go at the bottom of this first 'if' statement.
	[[ "${commands[tor-browser]}" ]] && BROWSER="tor-browser"  ## (Default: FireFox is prefered. then tor, then icecat ... etc)
	[[ "${commands[firefox]}"     ]] && BROWSER="firefox"
else
	## Is DISTRO defined?
	if [[ -n "${DISTRO}" ]]; then
		## If distro is Android
		if [[ "${DISTRO}" == "Android" || "${DISTRO}" == "android" ]]; then
    	BROWSER="xdg-open"
		## If distro is Termux
		elif [[ "${DISTRO}" == "Termux" || "${DISTRO}" == "termux" ]]; then
    	BROWSER="termux-open"
		## Otherwise try lynxs and xdg-open
		else
			[[ "${commands[lynx]}"     ]] && BROWSER="lynx"
			[[ "${commands[xdg-open]}" ]] && BROWSER="xdg-open"
		fi
	## Otherwise try lynxs and xdg-open
	else
	  [[ "${commands[lynx]}"     ]] && BROWSER="lynx"
	  [[ "${commands[xdg-open]}" ]] && BROWSER="xdg-open"
	fi
fi
## Final test
[[ "${commands[$BROWSER]}" ]] || unset BROWSER


### [=]==================================[=]
### [~]........... MAN
### [=]==================================[=]
MANPAGER='nvim +Man!'
MANWIDTH="$(( COLUMNS - (( COLUMNS / 4 )) ))"
function _set_nvim_man_pager() {
	if [ -z "$MANPAGER" ]; then  # Return if MANPAGER is already set
		NVIMBINPATH="$(which nvim)" # Check if nvim is installed
		if [ -n "$NVIMBINPATH" ]; then
			NVIMPAGER="$(which nvimpager)" # Check if nvimpager is installed
			if [ -n "$NVIMPAGER" ]; then # Define NVIMPAGER as MANPAGER
				MANPAGER="${NVIMPAGER}"
			else # Define nvim as MANPAGER
				MANPAGER='nvim +Man!'
			fi
		return 0
		else # Cannot find MANPAGER
			[[ -z "$MANPAGER" ]] \
				&& unset MANPAGER # Unset manpager
			return 0
		fi
	else # "manpager is already set to $MANPAGER"
		return 0
	fi
}; _set_nvim_man_pager; unset _set_nvim_man_pager

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

## [=]==================================[=]
## [~]............ PAGER
## [=]==================================[=]
export LESSHISTFILE="${LESSHISTFILE:-${XDG_CACHE_HOME}/less/lesshist}"
[[ ! -d $(dirname "${LESSHISTFILE}") ]] && mkdir -p "$(dirname "${LESSHISTFILE}")"

PAGER="less"
if [[ "${commands[bat]}" ]]; then
  PAGER="bat"
	BAT_PAGER="less -RFi"
	BAT_CONFIG_PATH="${XDG_CONFIG_HOME}/bat/config"
	export BAT_PAGER BAT_CONFIG_PATH
elif [[ "${commands[batcat]}" ]]; then
  PAGER="batcat"
	BAT_PAGER="less -RFi"
	BAT_CONFIG_PATH="${XDG_CONFIG_HOME}/bat/config"
	export BAT_PAGER BAT_CONFIG_PATH
else PAGER="less"; fi

export NVIMDIR="${XDG_CONFIG_HOME}/nvim"
export MANPAGER MANWIDTH NVIMBINPATH NVIMPAGER PAGER

### [=]==================================[=]
### [~]............ git
### [=]==================================[=]
GITHUB_URL="https://github.com"
GH_URL="https://github.com"
GH_EDITOR="${EDITOR:-${commands[nvim]:-${commands[vim]:-vim}}}"
GH_BROWSER="${BROWSER}"
GH_CONFIG_DIR="${XDG_CONFIG_HOME}/gh"
GIT_CONFIG_DIR="${XDG_CONFIG_HOME}/git"
GITIGNORE_DIR="${HONE}/.gitignore-boilerplates"
GIT_MAN_VIEWER="${MANPAGER:-man}"
GH_PAGER="${PAGER}"

export GITHUB_URL GH_URL GH_EDITOR GH_BROWSER GH_CONFIG_DIR GIT_CONFIG_DIR GITIGNORE_DIR GIT_MAN_VIEWER GH_PAGER

### [=]==================================[=]
### [~]........... GPG / SSH
### [=]==================================[=]
GNUPGHOME="$XDG_CONFIG_HOME/.gnupg"
GPG_TTY=$(tty)
GPG_TUI_CONFIG="$XDG_CONFIG_HOME/gpg-tui/gpg-tui.toml"
export GNUPGHOME GPG_TTY GPG_TUI_CONFIG

### [=]==================================[=]
### [~]........... TEMP
### [=]==================================[=]
export TEMPDIR="${HONE}/temporary"

### [=]==================================[=]
### [~]........... AWESOMEWM
### [=]==================================[=]
if [[ "${commands[awesome]}" ]]; then
	AWESOMEWM_CONFIG_DIR="${XDG_CONFIG_HOME}/awesome"
	[[ -d "${AWESOMEWM_CONFIG_DIR}" ]] && export AWESOMEWM_CONFIG_DIR
fi

### [=]==================================[=]
### [~]............ Kitty
### [=]==================================[=]
export KITTY_CONFIG_DIR="$XDG_CONFIG_HOME/kitty"
export KITTY_CONFIG="$KITTY_CONFIG_DIR/kitty.conf"

### [=]==================================[=]
### [~]............ Lynx
### [=]==================================[=]
if [[ -n "${commands[lynx]}" ]] ; then
	LYNXDOTDIR="${XDG_CONFIG_HOME}/lynx"
	LYNX_CFG="${LYNXDOTDIR}/lynx.cfg"                  # This variable, if set, will override the default location and name of the global configuration file (normally, lynx.cfg) that was defined by the  LYNX_CFG_FILE  constant  in  the userdefs.h file, during installation.
	LYNX_LSS="${LYNXDOTDIR}/lynx.lss"                  # This variable, if set, specifies the location of the default Lynx character style sheet file.  [Currently only meaningful if Lynx was built using curses color style support.]
	LYNX_SESSION="${XDG_CACHE_HOME}/lynx/lynx_session"          # file name where lynx will store user sessions. This setting is used only when AUTO_SESSION is true. Note: the default setting will store/resume each session in a different folder under same file name (if that is allowed by operating system) when lynx is invoked from different directories.
	LYNX_CFG_PATH="${LYNXDOTDIR}"                     # If  set, this variable overrides the compiled-in search-list of directories used to find the configuration files, e.g., lynx.cfg and lynx.lss.  The list is delimited with ":" (or #   ;" for Windows) like the PATH environment variable.
	# LYNX_HELPFILE="${LYNX_CONFIG_DIR_GLOBAL}/lynx_help_main.html" # If set, this variable overrides the compiled-in URL and configuration file URL for the Lynx help file.
	# WWW_HOME="${LYNX_CONFIG_DIR_GLOBAL}/lynx-homepage.html"       # This variable, if set, will override the default startup URL specified in any of the Lynx configuration files.
	[[ ! -d "${LYNX_SESSION:h}" ]] && mkdir -p "${LYNX_SESSION:h}"
	export LYNXDOTDIR LYNX_CFG LYNX_LSS LYNX_SESSION LYNX_CFG_PATH LYNX_HELPFILE WWW_HOME
fi

### [=]==================================[=]
### [~]............ SCRIPTS
### [=]==================================[=]
export MYPROJECTS="${HOME}/MYPROJECTS"
export SCRIPTS="${HONE}/scripts"

### [=]==================================[=]
### [~]............. GIMP ...............
### [=]==================================[=]
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME/GIMP/2.10"
export GIMPHOMECONFIGPATH='/home/dampsock/.config/GIMP/2.10'
export GIMPHOMECACHEPATH='/home/dampsock/.cache/gimp/2.10'


#### [=]==================================[=]
### [~]............. ASCIINEMA ..........
### [=]==================================[=]
export VIDEODIR="${HONE}/videos"
export YOUTUBEDOWNLOADSDIR="$VIDEODIR/youtube-downloads"
export ASCIINEMA_CONFIG_HOME="$XDG_CONFIG_HOME/asciinema"
export ASCIINEMA_OUTPUT_DIR="${HONE}/videos/terminal-recordings"

### [=]==================================[=]
### [~]............. NMAP ...............[~]
### [=]==================================[=]
export NMAPAUTOSCANOUTPUTDIR="$NMAPSCANOUTPUTDIR/local-subnet/nmap-auto"
export NMAPDIR="/usr/share/nmap"
export NMAPSCRIPTSDIR="/usr/share/nmap"
export NMAPSCANOUTPUTDIR="${HONE}/security/nmap-scans"
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
export PYTHONPATH="${HONE}/.local/bin:$PATH"
export IPYTHONDIR="${HONE}/.config/ipython"
export IPYTHON_CONFIG="$IPYTHONDIR/profile_default/ipython_config.py"

### [=]==================================[=]
### [~]........... DOWNLOADS
### [=]==================================[=]
export DOWNLOADS="${HONE}/Downloads"

### [=]==================================[=]
### [~]............ BACKUPS
### [=]==================================[=]
export BACKUPDIR="/backups"
export BACKUPDIR_LOCAL="${HONE}/backup"
### [=]==================================[=]
### [~]............ ICONS
### [=]==================================[=]
export ICONSDIRGLOBAL="/usr/share/icons"
export ICONSDIR="${HONE}/pictures/icons"
export ICONSTINYDIR="${HONE}/pictures/icons/SuperTinyIcons/images"

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
export CAD="${HONE}/3D-CAD"
export CADMODELSDIR="${HONE}/3D-CAD/3d-models"
export MODELS="${HONE}/3D-CAD/3d-models"
### OPENSCAD
export OPENSCADPATH="${HONE}/.local/share/OpenSCAD/libraries"
### OpenSCAD Scripts
export OPENSCADSCRIPTSDIR="${HONE}/3D-CAD/3D-CAD-scripts/openscad-scripts"
### Freecad
export FREECAD_DIR_MOD_SYSTEM="/usr/share/freecad/Mod"
export FREECAD_DIR_MOD_USER="${HONE}/.FreeCAD/Mod"
export FREECAD_DIR_MACRO_USER="${HONE}/.FreeCAD/Macro"

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

### MISC
export RAINBOW_CONFIGS="$XDG_CONFIG_HOME/rainbow"
export PYENV_ROOT="${HONE}/.pyenv"
export COOKIECUTTER_CONFIG="$XDG_CONFIG_HOME/cookiecutters/cookiecutter-custom-config.yaml"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export TRANSMISSION_HOME="${XDG_CONFIG_HOME}/transmission"

export WGETHSTS="${WGETHSTS:-${HOME}/.cache/.wget-hsts}"
export DIALOGRC="${XDG_CONFIG_HOME}/dialog/dialogrc"
