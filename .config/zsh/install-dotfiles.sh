#!/usr/bin/env bash

set -e

# -----------------------------------------------------------------------------
# Repository URLs and Directories
# -----------------------------------------------------------------------------
DOTFILES_REPO="https://github.com/ConnerWill/dotfiles.git"
DOTFILES_DIR="${HOME}/.dotfiles"
DOTF_REPO="https://github.com/ConnerWill/dotf.git"
DOTF_DIR="${ZSH_FUNCTIONS_MANUAL:-${XDG_CONFIG_HOME:-${HOME}/.config}/zsh/zsh/user/functions/functions-manual/dotf}"
VERBOSE=1

# -----------------------------------------------------------------------------
# Function: show_ascii_hello
# Description: Displays an ASCII art banner with repository information.
# -----------------------------------------------------------------------------
function show_ascii_hello(){
  printf "\x1B[0;1;4;38;5;201m"
  cat <<EOA
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
EOA
  printf "\x1B[0;1;3;38;5;51m"
  cat <<EOB
.               ${DOTFILES_REPO}                .
EOB
  printf "\x1B[0;1;4;38;5;201m"
  cat <<EOC
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
EOC
  printf "\x1B[0;38;5;57m"
  cat <<EOB
.                                                                         .
.                                                                         .
.                     .-+=======---::..                                   .
.                   :=+##@@@@@@@@@@@@@%@@@#.                              .
.                .=:*=@#@@@@@@%@@@@@@@@@@@@%+.      ..                    .
.  ...::..    .:+.*=%%%@@@@@@*%@@@@@@@@@@@@@%#-.    ..                    .
. .%@@@%%%%*--=.=*+@#@@@@@@@@=#@@@@@@@@@@@@@@@##-.:..:                    .
. *@@@@@@@@@@@@@=%@##%%#####*+%%#%%%%%%%%%%%@@@@*%#@%%#*+=:..             .
.=%#....................:::::::--:-+#@@@@@@@@@@@@@#*%@@@@@%%#+=+*+:.      .
.#@@*=-:-::.-@@#**%@@-.       +%%.    .... . ...............:-=+#%@@%+:.  .
..#%@@@@@@@%*@@@@@@@@=.#@@@@%@@@@@@@%%%%%###*=:-:......  .#%%##%=.    .:=..
#%###**++++@@@@+::-#@@@:---==++***###%%%%@@@@@@#%*@@@@@@:*@@@@@@#+%%+==#@..
=@@@@@@@@@@@@*.     :@@@@@@@@@@@%%%%%##****+++=---:::..:@@@%-:=@@@-::::....
.=#*++@@@@@@@. :@@%. =@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=    .*@@@@@@@@@-
.  .:=#%@@@@%. =@@@: =@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#..@@=.:@@@@@@@@:.
.          .@=  .:. .%%++:..:::::::::--------===#%%%%%%%@#..%@-.:@%%%%%=  .
.           .%#:. .=@%.                                 -@+    .**.       .
.            .:#@@@#-.                                   -@@+=*@+.        .
.                                                         ..--:.          .
EOB
  printf "\x1B[0;1;4;38;5;201m"
  cat <<EOA
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
EOA
  printf "\x1B[0m"
  sleep 1
}


# -----------------------------------------------------------------------------
# Function: show_ascii_goodbye
# Description: Displays an ASCII art goodbye
# -----------------------------------------------------------------------------
function show_ascii_goodbye(){
  printf "\x1B[0;1;4;38;5;201m"
  cat <<EOA
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
EOA
  printf "\x1B[0;1;38;5;46m"
  cat <<EOA
+------+.      +------+       +------+       +------+      .+------+
|\`.    | \`.    |\     |\      |      |      /|     /|    .' |    .'|
|  \`+--+---+   | +----+-+     +------+     +-+----+ |   +---+--+'  |
|   |  |   |   | |    | |     |      |     | |    | |   |   |  |   |
+---+--+.  |   +-+----+ |     +------+     | +----+-+   |  .+--+---+
 \`. |    \`.|    \|     \|     |      |     |/     |/    |.'    | .'
   \`+------+     +------+     +------+     +------+     +------+'
EOA
  printf "\x1B[0;1;3;38;5;201m"
  cat <<EOB
                             GOODBYE :)
EOB
  printf "\x1B[0;1;38;5;46m"
  cat <<EOC
   .+------+     +------+     +------+     +------+     +------+.
 .' |    .'|    /|     /|     |      |     |\     |\    |\`.    | \`.
+---+--+'  |   +-+----+ |     +------+     | +----+-+   |  \`+--+---+
|   |  |   |   | |    | |     |      |     | |    | |   |   |  |   |
|  ,+--+---+   | +----+-+     +------+     +-+----+ |   +---+--+   |
|.'    | .'    |/     |/      |      |      \|     \|    \`. |   \`. |
+------+'      +------+       +------+       +------+      \`+------+

   .+------+     +------+     +------+     +------+     +------+.
 .' |      |    /|      |     |      |     |      |\    |      | \`.
+   |      |   + |      |     +      +     |      | +   |      |   +
|   |      |   | |      |     |      |     |      | |   |      |   |
|  .+------+   | +------+     +------+     +------+ |   +------+.  |
|.'      .'    |/      /      |      |      \      \|    \`.      \`.|
+------+'      +------+       +------+       +------+      \`+------+
EOC
  printf "\x1B[0;1;4;38;5;201m"
  cat <<EOA
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
EOA
  printf "\x1B[0m"
}

# -----------------------------------------------------------------------------
# Function: write_error
# Description: Prints an error message with red formatting.
# -----------------------------------------------------------------------------
function write_error(){
  local input_msg="$1"
  printf "\x1B[0;1;48;5;196;38;5;255m[ERROR]\x1B[0;38;5;255m  : \x1B[0;38;5;196m%s\x1B[0m\n" "${input_msg}"
}

# -----------------------------------------------------------------------------
# Function: write_verbose
# Description: Prints a verbose message if VERBOSE mode is enabled.
# -----------------------------------------------------------------------------
function write_verbose(){
  local input_msg="$1"
  if [[ "${VERBOSE}" == 1 ]]; then
    printf "\x1B[0;1;48;5;21;38;5;226m[VERBOSE]\x1B[0;38;5;255m: \x1B[0;38;5;226m%s\x1B[0m\n" "${input_msg}"
  fi
}

# -----------------------------------------------------------------------------
# Function: is_installed
# Description: Checks if a program is installed and available in PATH.
# -----------------------------------------------------------------------------
function is_installed(){
  local input_program="$1"
  if command -v "${input_program}" >/dev/null 2>&1; then
    return 0
  else
    write_error "Could not find '${input_program}' in PATH. Make sure it is installed and is in your PATH"
    return 1
  fi
}

# -----------------------------------------------------------------------------
# Function: is_dependency_satisfied
# Description: Determines whether a dependency is already available by checking
#              the command(s) that satisfy it. This is needed because the
#              package name does not always match the executable name
#              (e.g. the 'neovim' package provides the 'nvim' command, and
#              'lua5.4' provides the 'lua5.4' command). Editor packages are
#              treated as satisfied if either 'nvim' or 'vim' is present, per
#              the "neovim OR vim" requirement.
# -----------------------------------------------------------------------------
function is_dependency_satisfied(){
  local pkg="$1"
  local candidates=()

  case "${pkg}" in
    neovim|nvim|vim)
      # Any editor is fine: neovim OR vim satisfies the requirement.
      candidates=("nvim" "vim")
      ;;
    lua*)
      # Package may be lua, lua5.4, lua5.3, etc. Accept any matching command.
      candidates=("${pkg}" "lua" "lua5.4" "lua5.3" "luajit")
      ;;
    *)
      candidates=("${pkg}")
      ;;
  esac

  local cmd
  for cmd in "${candidates[@]}"; do
    if command -v "${cmd}" >/dev/null 2>&1; then
      return 0
    fi
  done
  return 1
}

# -----------------------------------------------------------------------------
# Function: run_privileged
# Description: Runs a command with root privileges. Uses 'sudo' when not already
#              running as root; otherwise runs the command directly. This lets
#              the installer work both on normal user systems (via sudo) and in
#              minimal root containers such as Alpine/Docker where sudo may be
#              absent.
# -----------------------------------------------------------------------------
function run_privileged(){
  if [[ "$(id -u)" -eq 0 ]]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    write_error "This command needs root privileges but 'sudo' is not available and you are not root: $*"
    return 1
  fi
}

# -----------------------------------------------------------------------------
# Function: enable_alpine_community_repo
# Description: Ensures Alpine's 'community' repository is enabled. Several
#              dependencies (neovim, zsh, bat, lsd, lua5.4) are published only
#              in 'community', not 'main', so 'apk add' would otherwise fail to
#              find them. This uncomments an existing commented community line
#              matching the current main mirror/release, or appends one derived
#              from the enabled 'main' repository line.
# -----------------------------------------------------------------------------
function enable_alpine_community_repo(){
  local repo_file="/etc/apk/repositories"
  [[ -f "${repo_file}" ]] || return 0

  # Already enabled? Nothing to do.
  if grep -Eq '^[^#].*/community$' "${repo_file}"; then
    write_verbose "Alpine community repository already enabled."
    return 0
  fi

  # Try to uncomment an existing commented community line.
  if grep -Eq '^#.*/community$' "${repo_file}"; then
    write_verbose "Enabling commented-out Alpine community repository..."
    run_privileged sed -i -E 's|^#(.*/community)$|\1|' "${repo_file}"
    return 0
  fi

  # Otherwise, derive a community line from the enabled main line.
  local main_line
  main_line="$(grep -E '^[^#].*/main$' "${repo_file}" | head -n1)"
  if [[ -n "${main_line}" ]]; then
    local community_line="${main_line%/main}/community"
    write_verbose "Adding Alpine community repository: ${community_line}"
    printf '%s\n' "${community_line}" | run_privileged tee -a "${repo_file}" >/dev/null
  else
    write_error "Could not determine Alpine 'main' repository to derive 'community'. Enable it manually in ${repo_file}."
  fi
}

# -----------------------------------------------------------------------------
# Function: setup_locale
# Description: Ensures the en_US.UTF-8 locale exists so that programs do not emit
#              "setlocale: LC_ALL: cannot change locale (en_US.UTF-8)" warnings.
#              The dotfiles set LC_ALL=en_US.UTF-8 (see .zshenv), but minimal
#              container images (e.g. archlinux, debian) ship without that locale
#              generated. This generates it using whatever mechanism the distro
#              provides. It is a no-op on systems where the locale already exists
#              (e.g. most desktops, macOS).
# -----------------------------------------------------------------------------
function setup_locale(){
  local target_locale="en_US.UTF-8"

  # Already available? Nothing to do.
  if command -v locale >/dev/null 2>&1; then
    if locale -a 2>/dev/null | grep -qiE '^(en_US\.utf-?8|en_US\.UTF-8)$'; then
      write_verbose "Locale ${target_locale} already available."
      return 0
    fi
  fi

  write_verbose "Generating locale: ${target_locale}"

  if [[ "$(uname -s)" == "Darwin" ]]; then
    # macOS ships UTF-8 locales; nothing to generate.
    return 0
  fi

  # Debian/Ubuntu: package 'locales' provides the locale, then locale-gen.
  if command -v apt-get >/dev/null 2>&1; then
    run_privileged apt-get install -y locales >/dev/null 2>&1 || true
  fi

  # Alpine (musl): install a UTF-8 capable locale package if available.
  if command -v apk >/dev/null 2>&1; then
    run_privileged apk add --no-cache musl-locales musl-locales-lang >/dev/null 2>&1 || true
  fi

  # Ensure the entry is present/uncommented in /etc/locale.gen (glibc distros:
  # Arch, Debian, Fedora, etc.).
  if [[ -f /etc/locale.gen ]]; then
    if grep -qE "^#\s*${target_locale}[[:space:]]+UTF-8" /etc/locale.gen; then
      run_privileged sed -i -E "s/^#\s*(${target_locale}[[:space:]]+UTF-8)/\1/" /etc/locale.gen
    elif ! grep -qE "^${target_locale}[[:space:]]+UTF-8" /etc/locale.gen; then
      printf '%s UTF-8\n' "${target_locale}" | run_privileged tee -a /etc/locale.gen >/dev/null
    fi
  fi

  # Generate the locale.
  if command -v locale-gen >/dev/null 2>&1; then
    # Debian's locale-gen takes no args; Arch's accepts them. Plain call works for both.
    run_privileged locale-gen >/dev/null 2>&1 || run_privileged locale-gen "${target_locale}" >/dev/null 2>&1 || true
  elif command -v localedef >/dev/null 2>&1; then
    # Fedora/RHEL and generic glibc fallback.
    run_privileged localedef -i en_US -f UTF-8 "${target_locale}" >/dev/null 2>&1 || true
  fi

  if command -v locale >/dev/null 2>&1 && \
     locale -a 2>/dev/null | grep -qiE '^(en_US\.utf-?8|en_US\.UTF-8)$'; then
    write_verbose "Locale ${target_locale} generated."
  else
    write_error "Could not generate locale ${target_locale}. The 'setlocale' warning is harmless and can be ignored."
  fi
}

# -----------------------------------------------------------------------------
# Function: install_dependencies
# Description: Detects the OS and package manager, then installs required dependencies.
# -----------------------------------------------------------------------------
function install_dependencies(){
  write_verbose "Installing dependencies..."

  # Detect OS type using uname
  OS_TYPE=$(uname -s)
  local PKG_MANAGER=""
  local DEPENDENCIES=()

  if [[ "${OS_TYPE}" == "Darwin" ]]; then
    # macOS: Use Homebrew
    if ! command -v brew >/dev/null 2>&1; then
      write_error "Homebrew is not installed. Please install Homebrew first: https://brew.sh"
      exit 1
    fi
    PKG_MANAGER="brew"
    # Define dependency list for macOS. Adjust package names if necessary.
    DEPENDENCIES=("git" "zsh" "curl" "bat" "lua" "neovim")
  elif [[ "${OS_TYPE}" == "Linux" ]]; then
    # Linux: Detect available package manager.
    if command -v apt-get >/dev/null 2>&1; then
      PKG_MANAGER="apt-get"
      DEPENDENCIES=("git" "zsh" "curl" "bat" "lsd" "lua5.4" "neovim" "gcc")
    elif command -v pacman >/dev/null 2>&1; then
      PKG_MANAGER="pacman"
      DEPENDENCIES=("git" "zsh" "curl" "bat" "lsd" "lua" "neovim" "gcc")
    elif command -v dnf >/dev/null 2>&1; then
      PKG_MANAGER="dnf"
      DEPENDENCIES=("git" "zsh" "curl" "lua" "neovim" "gcc")
    elif command -v yum >/dev/null 2>&1; then
      PKG_MANAGER="yum"
      DEPENDENCIES=("git" "zsh" "curl" "lua" "neovim" "gcc")
    elif command -v apk >/dev/null 2>&1; then
      PKG_MANAGER="apk"
      DEPENDENCIES=("git" "zsh" "curl" "bat" "lsd" "lua5.4" "neovim" "gcc" "musl-dev")
    else
      write_error "Unsupported Linux package manager. Please install dependencies manually."
      exit 1
    fi
  else
    write_error "Unsupported OS: ${OS_TYPE}. Please install dependencies manually. All you really need is git and zsh"
    exit 1
  fi

  write_verbose "Detected OS: ${OS_TYPE}"
  write_verbose "Using package manager: ${PKG_MANAGER}"

  # Refresh the package database once up front rather than on every package.
  # This is both faster and avoids partial-upgrade pitfalls (e.g. pacman -Sy).
  case "${PKG_MANAGER}" in
    apt-get)
      run_privileged apt-get update
      ;;
    pacman)
      run_privileged pacman -Sy --noconfirm
      ;;
    apk)
      enable_alpine_community_repo
      run_privileged apk update
      ;;
    brew)
      brew update || true
      ;;
    dnf|yum)
      # dnf/yum refresh their metadata automatically on install; no-op here.
      ;;
  esac

  # Loop through each dependency and install if not already installed
  for pkg in "${DEPENDENCIES[@]}"; do
    if ! is_dependency_satisfied "${pkg}"; then
      write_verbose "Installing ${pkg}..."
      case "${PKG_MANAGER}" in
        brew)
          brew install "${pkg}"
          ;;
        apt-get)
          run_privileged apt-get install -y "${pkg}"
          ;;
        dnf)
          run_privileged dnf install -y "${pkg}"
          ;;
        pacman)
          run_privileged pacman -S --noconfirm --needed "${pkg}"
          ;;
        yum)
          run_privileged yum install -y "${pkg}"
          ;;
        apk)
          run_privileged apk add "${pkg}"
          ;;
        *)
          write_error "Package manager ${PKG_MANAGER} is not supported in this script."
          exit 1
          ;;
      esac
    else
      write_verbose "${pkg} is already installed."
    fi
  done
}

# -----------------------------------------------------------------------------
# Function: install_yay
# Description: Installs the 'yay' AUR helper on Arch Linux. No-op on non-Arch
#              systems (no 'pacman'). 'makepkg' refuses to run as root, so this
#              is skipped when running as root.
# -----------------------------------------------------------------------------
function install_yay(){
  # Only relevant on Arch-based systems.
  if ! command -v pacman >/dev/null 2>&1; then
    return 0
  fi

  # Already installed? Nothing to do.
  if command -v yay >/dev/null 2>&1; then
    write_verbose "yay is already installed."
    return 0
  fi

  # makepkg refuses to run as root; skip rather than trying to work around it.
  if [[ "$(id -u)" -eq 0 ]]; then
    write_verbose "Running as root; skipping yay install (makepkg cannot run as root)."
    return 0
  fi

  write_verbose "Installing yay (AUR helper)..."

  local build_dir
  build_dir="$(mktemp -d)"

  if git clone https://aur.archlinux.org/yay.git "${build_dir}/yay" \
    && (cd "${build_dir}/yay" && makepkg -si --noconfirm); then
    write_verbose "yay installed successfully."
  else
    write_error "Failed to install yay."
    rm -rf "${build_dir}"
    return 1
  fi

  rm -rf "${build_dir}"
}

# -----------------------------------------------------------------------------
# Function: clone_dotfiles
# Description: Clones the dotfiles repository as a bare repository.
# -----------------------------------------------------------------------------
function clone_dotfiles(){
  if [[ -d "${DOTFILES_DIR}" ]]; then
    write_error "Dotfiles directory already exists: ${DOTFILES_DIR} . Remove this directory if you want to reinstall"
    return 1
  else
    write_verbose "Cloning dotfiles: ${DOTFILES_REPO} to directory: ${DOTFILES_DIR}"
    # Note: --recurse-submodules is intentionally omitted here. A bare repository
    # has no working tree, so submodules cannot be checked out during a bare clone.
    # Submodules are initialized separately in init_submodules() after checkout.
    git clone                                               \
      --bare                                                  \
      --config status.showUntrackedFiles=no                   \
      --config core.excludesfile="${DOTFILES_DIR}/.gitignore" \
      --verbose --progress                                    \
      "${DOTFILES_REPO}" "${DOTFILES_DIR}"
  fi
}

# -----------------------------------------------------------------------------
# Function: checkout_dotfiles
# Description: Checks out the working tree from the bare repository into HOME.
#              This is what actually installs the dotfiles into the home directory.
# -----------------------------------------------------------------------------
function checkout_dotfiles(){
  write_verbose "Checking out dotfiles into: ${HOME}"
  write_verbose "This will overwrite existing files in your home directory!"
  git                             \
    --work-tree="${HOME}"         \
    --git-dir="${DOTFILES_DIR}"   \
    checkout --force main
}

# -----------------------------------------------------------------------------
# Function: init_submodules
# Description: Initializes and updates git submodules (e.g. 'dotf') for the
#              bare dotfiles repository. Because the repo is bare, submodule
#              commands must be run with the work-tree set to HOME.
# -----------------------------------------------------------------------------
function init_submodules(){
  write_verbose "Initializing submodules into: ${HOME}"
  git                             \
    --work-tree="${HOME}"         \
    --git-dir="${DOTFILES_DIR}"   \
    -C "${HOME}"                  \
    submodule update --init --recursive
}

# -----------------------------------------------------------------------------
# Function: clone_dotf
# Description: Clones the dotf repository standalone. This is a fallback for
#              non-bare / manual setups; the normal install uses init_submodules
#              since 'dotf' is tracked as a submodule of the dotfiles repo.
# -----------------------------------------------------------------------------
function clone_dotf(){
  if [[ -d "${DOTF_DIR}" ]]; then
    write_error "Dotf directory already exists: ${DOTF_DIR}"
    return 1
  else
    write_verbose "Cloning dotf: ${DOTF_REPO} to directory: ${DOTF_DIR}"
    git clone "${DOTF_REPO}" "${DOTF_DIR}"
  fi
}

# -----------------------------------------------------------------------------
# Function: change_shell
# Description: Changes default shell
# -----------------------------------------------------------------------------
function change_shell(){
  is_installed "chsh"
  chsh --shell="$(command -v zsh)" "$(whoami)"
}

# -----------------------------------------------------------------------------
# Function: confirm_install
# Description: Prints a summary of the changes this script will make to the
#              user's system, then pauses so they can cancel (Ctrl+C) before
#              anything is modified. The countdown is interruptible: pressing
#              Enter proceeds immediately, Ctrl+C aborts. When there is no
#              interactive terminal on stdin (e.g. 'curl ... | bash'), it falls
#              back to a plain timed countdown so the pipeline still works while
#              still giving a window to cancel. Set DOTFILES_ASSUME_YES=1 to
#              skip the pause entirely (useful for automated/CI installs).
# -----------------------------------------------------------------------------
function confirm_install(){
  local delay="${DOTFILES_CONFIRM_DELAY:-10}"

  printf "\x1B[0;1;38;5;208m%s\x1B[0m\n" "This installer will make the following changes to your system:"
  printf "\x1B[0;38;5;208m"
  cat <<EOS
  1. Install dependencies via your system package manager (may require sudo):
       git, zsh, curl, bat, lsd, lua, neovim, gcc (package names vary by OS).
  2. Generate the en_US.UTF-8 locale if it is missing.
  3. Clone the dotfiles repo as a BARE repository into:
       ${DOTFILES_DIR}
  4. Check the dotfiles out into your HOME directory: '${HOME}'
     !!! This OVERWRITES existing files in your home directory
      (e.g. .zshrc, .config/*) with versions from the repo. Back up anything important. !!!
  5. Initialize git submodules (installs 'dotf' into your config).
  6. Change your default login shell to zsh (via chsh).

  Source repo: ${DOTFILES_REPO}
EOS
  printf "\x1B[0m"

  # Allow non-interactive/automated installs to skip the prompt.
  if [[ "${DOTFILES_ASSUME_YES:-0}" == "1" ]]; then
    write_verbose "DOTFILES_ASSUME_YES=1 set; skipping confirmation pause."
    return 0
  fi

  # Interactive terminal available: let the user confirm or cancel.
  if [[ -t 0 ]]; then
    printf "\x1B[0;1;38;5;226m%s\x1B[0m" \
      "Press ENTER to continue, or Ctrl+C to cancel (auto-continues in ${delay}s)... "
    # read returns non-zero on timeout; that is fine, we proceed either way.
    read -r -t "${delay}" _ || true
    printf "\n"
    return 0
  fi

  # No TTY (piped install): plain countdown so the user can still Ctrl+C.
  printf "\x1B[0;1;38;5;226mStarting in %ss... press Ctrl+C to cancel.\x1B[0m\n" "${delay}"
  local i
  for (( i = delay; i > 0; i-- )); do
    printf "\r\x1B[0;38;5;226m  %2ss \x1B[0m" "${i}"
    sleep 1
  done
  printf "\r\x1B[0;38;5;46m  Continuing...            \x1B[0m\n"
  return 0
}

# -----------------------------------------------------------------------------
# Main Execution
# -----------------------------------------------------------------------------

# Display ASCII art banner
show_ascii_hello

# Warn the user what will happen and give them a chance to cancel before any
# changes are made to their system.
confirm_install

# Note: root privileges are handled by run_privileged() during dependency
# installation. It uses 'sudo' when needed and falls back to running directly
# when already root (e.g. in Alpine/Docker containers), so 'sudo' is not a
# hard requirement here.

# Install required dependencies based on OS detection
install_dependencies

# Install the 'yay' AUR helper on Arch-based systems (no-op elsewhere).
install_yay || write_error "Failed to install yay. You can install it manually from the AUR."

# Ensure the en_US.UTF-8 locale exists (dotfiles set LC_ALL=en_US.UTF-8).
# Prevents "setlocale: LC_ALL: cannot change locale" warnings in minimal
# containers where the locale is not generated by default.
setup_locale

# Ensure critical commands are installed (this check is redundant if install_dependencies is run)
is_installed "git"
is_installed "zsh"

# Clone repos
clone_dotfiles

# Check out the dotfiles into HOME (this actually installs them)
checkout_dotfiles

# Initialize submodules (installs 'dotf' and any other submodules)
init_submodules

# Note: the 'dotf' repository is tracked as a git submodule of the dotfiles
# repo and is installed by init_submodules above. The standalone clone_dotf
# function is kept only as a fallback for manual/non-bare setups.

# Set shell
change_shell || write_error "Failed to change the default shell. You can change it manually with: chsh --shell \"\$(command -v zsh)\""

# Display ASCII art banner 2
show_ascii_goodbye
