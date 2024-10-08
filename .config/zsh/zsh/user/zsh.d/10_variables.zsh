#shellcheck disable=2148


## Path to parent directory of function directories
ZSH_FUNCTIONS_DIR="${ZSH_USER_DIR}/functions"

## Path to functions available directory. Functions are not loaded from this directory
ZSH_FUNCTIONS_AVAILABLE="${ZSH_FUNCTIONS_DIR}/functions-available"

## Path to functions enabled directory. Functions are automatically loaded from
## this directory if they have the file extension '.zsh'
ZSH_FUNCTIONS_ENABLED="${ZSH_FUNCTIONS_DIR}/functions-enabled"

## Path to the functions manual directory. Functions are not automatically loaded from this directory.
## Source functions manually in this directory (Put functions in this directory that rely on non coreutils programs)
## No need to source functions that contain commands you do not have installed ;)
ZSH_FUNCTIONS_MANUAL="${ZSH_FUNCTIONS_DIR}/functions-manual"

export ZSH_FUNCTIONS_AVAILABLE ZSH_FUNCTIONS_ENABLED ZSH_FUNCTIONS_CONFIG_DIR


### [=]==================================[=]
### [~]............ ZLUA
### [=]==================================[=]
[[ -d "${XDG_CACHE_HOME}/zsh/z.lua" ]] || mkdir -p "${XDG_CACHE_HOME}/zsh/z.lua"
export _ZL_DATA="${XDG_CACHE_HOME}/zsh/z.lua/zlua"
export _ZL_CMD="z"
export _ZL_MATCH_MODE="1"
export _ZL_ECHO="1"
export _ZL_HYPHEN="1"
export _ZL_CLINK_PROMPT_PRIORITY="99"
export _ZL_MAXAGE="100000"
export _ZL_ROOT_MARKERS=".git,.svn,.hg,.root,package.json"

### [=]==================================[=]
### [~]............ CHPWD
### [=]==================================[=]
export chpwd_recent_dirs="${chpwd_recent_dirs:-${XDG_CACHE_HOME}/zsh/.chpwd-recent-dirs}"

### [=]==================================[=]
### [~]........... MAIL
### [=]==================================[=]
[[ "${USER}" == "dampsock" ]] && export EMAIL="Conner.Will@connerwill.com"

### [=]==================================[=]
### [~]............ DISPLAY
### [=]==================================[=]
## If DISPLAY is set (running a WM or X11)
if [[ -n "${DISPLAY}" ]]; then
	### [=]==================================[=]
	### [~]............ BROWSER
	### [=]==================================[=]
	[[ "${commands[librewolf]}"   ]] && BROWSER="icecat"       ## Set the order of preferred browsers if when using a WM.
	[[ "${commands[icecat]}"      ]] && BROWSER="icecat"       ## Most preferred browser should go at the bottom of this first 'if' statement.
	[[ "${commands[tor-browser]}" ]] && BROWSER="tor-browser"  ## (Default: FireFox is preferred. then tor, then icecat ... etc)
	[[ "${commands[firefox]}"     ]] && BROWSER="firefox"

	### [=]==================================[=]
	### [~]............. GIMP ...............
	### [=]==================================[=]
	if [[ "${commands[gimp]}" ]]; then
		export GIMP2_DIRECTORY="${XDG_CONFIG_HOME}/GIMP/2.10"
		export GIMPHOMECONFIGPATH="${XDG_CONFIG_HOME}/GIMP/2.10"
		export GIMPHOMECACHEPATH="${XDG_CACHE_HOME}/gimp/2.10"
	fi

	### [=]==================================[=]
	### [~]............ ICONS
	### [=]==================================[=]
	[[ -d "/usr/share/icons"                  ]] && export ICONSDIRGLOBAL="/usr/share/icons"
	[[ -d "${HOME}/pictures/icons"            ]] && export ICONSDIR="${HOME}/pictures/icons"
	[[ -d "${ICONSDIR}/SuperTinyIcons/images" ]] && export ICONSDINYDIR="${ICONSDIR}/SuperTinyIcons/images"

	### [=]==================================[=]
	### [~]............ FONTS
	### [=]==================================[=]
	[[ -d "/usr/share/fonts"           ]] && export FONTSDIRGLOBAL="/usr/share/fonts"
	[[ -d "${HOME}/.local/share/fonts" ]] && export FONTSDIR="${HOME}/.local/share/fonts"

	### [=]==================================[=]
	### [~]............ THEMES
	### [=]==================================[=]
	[[ -d "/usr/share/themes" ]] && export THEMEDIRGLOBAL="/usr/share/themes"

	### [=]==================================[=]
	### [~]............ CAD / 3D
	### [=]==================================[=]
	export CAD="${HOME}/3D-CAD"
	if [[ -d "${CAD}" ]]; then
		export CADMODELSDIR="${HOME}/3D-CAD/3d-models"
		export MODELS="${HOME}/3D-CAD/3d-models"
	fi
	if [[ "${commands[openscad]}" ]]; then
		export OPENSCADPATH="${HOME}/.local/share/OpenSCAD/libraries"
		export OPENSCADSCRIPTSDIR="${HOME}/3D-CAD/3D-CAD-scripts/openscad-scripts"
	fi
	if [[ "${commands[freecad]}" ]]; then
		export FREECAD_DIR_MOD_SYSTEM="/usr/share/freecad/Mod"
		export FREECAD_DIR_MOD_USER="${HOME}/.FreeCAD/Mod"
		export FREECAD_DIR_MACRO_USER="${HOME}/.FreeCAD/Macro"
	fi
	### [=]==================================[=]
	### [~]............ QT
	### [=]==================================[=]
 	[[ -d "${XDG_CONFIG_HOME}/QtProject" ]] && export QtProject_Config="${XDG_CONFIG_HOME}/QtProject"
	[[ -d "${XDG_CONFIG_HOME}/qt5ct" ]] && export QT_QPA_PLATFORMTHEME="${XDG_CONFIG_HOME}/qt5ct"

	### [=]==================================[=]
	### [~]............ KITTY
	### [=]==================================[=]
	if [[ "${commands[kitty]}" ]]; then
		export KITTY_CONFIG_DIR="${XDG_CONFIG_HOME}/kitty"
		export KITTY_CONFIG="${KITTY_CONFIG_DIR}/kitty.conf"
	fi

else
	if [[ -n "${DISTRO}" ]]; then                                         ## Is DISTRO defined?
		if [[ "${DISTRO}" == "Android" || "${DISTRO}" == "android" ]]; then ## If distro is Android
    	BROWSER="xdg-open"
		elif [[ "${DISTRO}" == "Termux" || "${DISTRO}" == "termux" ]]; then ## If distro is Termux
    	BROWSER="termux-open"
		else                                                                ## Otherwise try lynx and xdg-open
			[[ "${commands[lynx]}"     ]] && BROWSER="lynx"
			[[ "${commands[xdg-open]}" ]] && BROWSER="xdg-open"
		fi
	else                                                               ## Otherwise try lynxs and xdg-open
	  [[ "${commands[lynx]}"     ]] && BROWSER="lynx"
	  [[ "${commands[xdg-open]}" ]] && BROWSER="xdg-open"
	fi
fi
[[ "${commands[${BROWSER}]}" ]] || unset BROWSER                        ## Final test

### [=]==================================[=]
### [~]............ LYNX
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
### [~]........... MAN
### [=]==================================[=]
if [[ -n "${commands[man]}" ]] ; then
  MANPAGER='nvim +Man!'
  MANWIDTH="$(( COLUMNS - (( COLUMNS / 4 )) ))"
  MANPATH=$(man --path)
  man() {
    export MANWIDTH="$(( COLUMNS ))"
      env \
          LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
          LESS_TERMCAP_md="$(printf "\e[1;35m")" \
          LESS_TERMCAP_me="$(printf "\e[0m")" \
          LESS_TERMCAP_se="$(printf "\e[0m")" \
          LESS_TERMCAP_so="$(printf "\e[4;36m")" \
          LESS_TERMCAP_ue="$(printf "\e[0m")" \
          LESS_TERMCAP_us="$(printf "\e[3;34m")" \
          PAGER="${commands[less]:-${PAGER}}" \
          MANWIDTH="$(( COLUMNS ))" \
      man "${@}"
  }
fi

## [=]==================================[=]
## [~]............ PAGER
## [=]==================================[=]
export LESSHISTFILE="${LESSHISTFILE:-${XDG_CACHE_HOME}/less/lesshist}"
[[ ! -d $(dirname "${LESSHISTFILE}") ]] && mkdir -p "$(dirname "${LESSHISTFILE}")"
PAGER="${PAGER:-less}"
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
else
	PAGER="less"
fi
export NVIMDIR="${XDG_CONFIG_HOME}/nvim"
export MANPAGER MANWIDTH NVIMBINPATH NVIMPAGER PAGER

### [=]==================================[=]
### [~]............ GIT
### [=]==================================[=]
GITHUB_URL="https://github.com"
GH_URL="https://github.com"
GH_EDITOR="${EDITOR:-${commands[nvim]:-${commands[vim]:-vim}}}"
GH_BROWSER="${BROWSER}"
GH_CONFIG_DIR="${XDG_CONFIG_HOME}/gh"
GIT_CONFIG_DIR="${XDG_CONFIG_HOME}/git"
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
[[ -d "${HOME}/temporary" ]] && export TEMPDIR="${HOME}/temporary"

### [=]==================================[=]
### [~]........... AWESOMEWM
### [=]==================================[=]
if [[ "${commands[awesome]}" ]]; then
	AWESOMEWM_CONFIG_DIR="${XDG_CONFIG_HOME}/awesome"
	[[ -d "${XDG_CONFIG_HOME}/awesome" ]] && export AWESOMEWM_CONFIG_DIR="${XDG_CONFIG_HOME}/awesome"
fi

### [=]==================================[=]
### [~]............ SCRIPTS
### [=]==================================[=]
[[ -d "${HOME}/MYPROJECTS" ]] && export MYPROJECTS="${HOME}/MYPROJECTS"
[[ -d "${HOME}/scripts"    ]] && export SCRIPTS="${HOME}/scripts"

### [=]==================================[=]
### [~]............. ASCIINEMA ..........
### [=]==================================[=]
if [[ "${commands[asciinema]}" ]]; then
  export VIDEODIR="${HOME}/videos"
	export YOUTUBEDOWNLOADSDIR="${VIDEODIR}/youtube-downloads"
	export ASCIINEMA_CONFIG_HOME="${XDG_CONFIG_HOME}/asciinema"
	export ASCIINEMA_OUTPUT_DIR="${HOME}/videos/terminal-recordings"
fi

### [=]==================================[=]
### [~]............. NMAP ...............[~]
### [=]==================================[=]
if [[ "${commands[nmap]}" ]]; then
	export NMAPDIR="/usr/share/nmap"
	export NMAPSCRIPTSDIR="/usr/share/nmap"
	export NMAPSCANOUTPUTDIR="${HOME}/security/nmap-scans"
	export NMAPAUTOSCANOUTPUTDIR="${NMAPSCANOUTPUTDIR}/local-subnet/nmap-auto"
fi

### [=]==================================[=]
### [~]............ METASPLOIT
### [=]==================================[=]
if [[ "${commands[msf]}" || "${commands[msfconsole]}" ]]; then
	export METASPLOITMODULESPATH="/opt/metasploit/modules"
	export METASPLOITPATH="/opt/metasploit"
fi

### [=]==================================[=]
### [~]............ PYTHON
### [=]==================================[=]
if [[ "${commands[python]}" ]]; then
  GENCOMPL_PY="python"
  PYTHONPATH="${PATH}:${HOME}/.local/bin"
  IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
  IPYTHON_CONFIG="${IPYTHONDIR:-${XDG_CONFIG_HOME}/ipython}/profile_default/ipython_config.py"
  PYENV_ROOT="${HOME}/.pyenv"
  export GENCOMPL_PY PYTHONPATH IPYTHONDIR IPYTHON_CONFIG PYENV_ROOT
fi

### [=]==================================[=]
### [~]........... DOWNLOADS
### [=]==================================[=]
[[ -d "${HOME}/Downloads" ]] && export DOWNLOADS="${HOME}/Downloads"

### [=]==================================[=]
### [~]............ BACKUPS
### [=]==================================[=]
[[ -d "/backups"       ]] && export BACKUPDIR="/backups"
[[ -d "${HOME}/backup" ]] && export BACKUPDIR_LOCAL="${HOME}/backup"

### [=]==================================[=]
### [~]............ TMUX
### [=]==================================[=]
if [[ "${commands[tmux]}" ]]; then
	TSM_HOME="${XDG_DATA_HOME}/tsm"
	TSM_SESSIONS_DIR="${TSM_HOME}/sessions"
	TSM_BACKUPS_DIR="${TSM_HOME}/backups"
	TSM_DEFAULT_SESSION_FILE="${TSM_HOME}/default-session.txt"
	TSM_BACKUPS_COUNT=30
  export TSM_HOME TSM_SESSIONS_DIR TSM_BACKUPS_DIR TSM_DEFAULT_SESSION_FILE TSM_BACKUPS_COUNT
fi

### [=]==================================[=]
### [~]............ TRANSMISSION
### [=]==================================[=]
if [[ "${commands[transmission-cli]}" ]]; then
  export TRANSMISSION_HOME="${XDG_CONFIG_HOME}/transmission"
fi

### [=]==================================[=]
### [~]............ ANSIBLE
### [=]==================================[=]
if [[ "${commands[ansible]}" ]]; then
	export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg"
fi

### [=]==================================[=]
### [~]............ PACKER
### [=]==================================[=]
if [[ "${commands[packer]}" ]]; then
  PACKER_CONFIG_DIR="${PACKER_CONFIG_DIR:-${XDG_CONFIG_HOME}/packer}"
	CHECKPOINT_DISABLE=1
  export PACKER_CONFIG_DIR CHECKPOINT_DISABLE
fi

### [=]==================================[=]
### [~]............ TERRAFORM
### [=]==================================[=]
if [[ "${commands[terraform]}" ]]; then
  TF_CLI_CONFIG_FILE="${XDG_CONFIG_HOME}/terraform/terraform_config.tfrc"
  TERRAFORM_CONFIG="${TF_CLI_CONFIG_FILE}"
  TF_CLI_ARGS_apply='-auto-approve'
  export TF_CLI_CONFIG_FILE TERRAFORM_CONFIG TF_CLI_ARGS_apply
fi

### [=]==================================[=]
### [~]............ SPACECTL
### [=]==================================[=]
if [[ "${commands[spacectl]}" ]]; then
  SPACELIFT_API_KEY_ENDPOINT="" # the URL to your Spacelift account
  SPACELIFT_API_KEY_ID="" # the ID of your Spacelift API key. Available via the Spacelift application
  SPACELIFT_API_KEY_SECRET="" # the secret for your API key. Only available when the secret is created
  export SPACELIFT_API_KEY_ENDPOINT SPACELIFT_API_KEY_ID SPACELIFT_API_KEY_SECRET
fi

### [=]==================================[=]
### [~]............ WGET
### [=]==================================[=]
if [[ "${commands[wget]}" ]]; then
	export WGETHSTS="${WGETHSTS:-${HOME}/.cache/.wget-hsts}"
fi

### [=]==================================[=]
### [~]............ RAINBOW
### [=]==================================[=]
if [[ "${commands[rainbow]}" ]]; then
	export RAINBOW_CONFIGS="${XDG_CONFIG_HOME}/rainbow"
fi

### [=]==================================[=]
### [~]............ WATCH
### [=]==================================[=]
WATCH_INTERVAL=1
WATCH_FAST_INTERVAL=0.1
export WATCH_INTERVAL WATCH_FAST_INTERVAL;

### MISC
export DIALOGRC="${XDG_CONFIG_HOME}/dialog/dialogrc"

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
