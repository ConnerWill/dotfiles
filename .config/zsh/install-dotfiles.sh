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
.                ${DOTF_REPO}                   .
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
    DEPENDENCIES=("git" "zsh" "curl" "bat")
  elif [[ "${OS_TYPE}" == "Linux" ]]; then
    # Linux: Detect available package manager.
    if command -v apt-get >/dev/null 2>&1; then
      PKG_MANAGER="apt-get"
      DEPENDENCIES=("git" "zsh" "curl" "bat" "lsd")
    elif command -v pacman >/dev/null 2>&1; then
      PKG_MANAGER="pacman"
      DEPENDENCIES=("git" "zsh" "curl" "bat" "lsd")
    elif command -v dnf >/dev/null 2>&1; then
      PKG_MANAGER="dnf"
      DEPENDENCIES=("git" "zsh" "curl")
    elif command -v yum >/dev/null 2>&1; then
      PKG_MANAGER="yum"
      DEPENDENCIES=("git" "zsh" "curl")
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

  # Loop through each dependency and install if not already installed
  for pkg in "${DEPENDENCIES[@]}"; do
    if ! command -v "${pkg}" >/dev/null 2>&1; then
      write_verbose "Installing ${pkg}..."
      case "${PKG_MANAGER}" in
        brew)
          brew install "${pkg}"
          ;;
        apt-get)
          sudo apt-get update && sudo apt-get install -y "${pkg}"
          ;;
        dnf)
          sudo dnf install -y "${pkg}"
          ;;
        pacman)
          sudo pacman -Sy --noconfirm "${pkg}"
          ;;
        yum)
          sudo yum install -y "${pkg}"
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
# Main Execution
# -----------------------------------------------------------------------------

# Display ASCII art banner
show_ascii_hello

# Ensure critical commands are installed
is_installed "sudo"

# Install required dependencies based on OS detection
install_dependencies

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
