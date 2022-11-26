###
### Title:        ssh-secure-keygen.zsh
### Author:       https://github.com/connerwill
### Description:  Functions to generate secure ssh keys

function _ssh_secure_keygen(){
  local cleanedKeyName keyType currentDate keyDir AuthorizedKeysPath keyPath KeyName keyPublic
  tput smcup
  printf "\e[0;38;5;93mEnter Comment/KeyName \e[38;5;241m(Spaces will be replaced by underscores '_')\e[0m\n\n\t\e[38;5;201m[>\e[0m "
  read -r sshcomment

  cleanedKeyName="${sshcomment// /_}"
  keyType="ed25519"
  keyBits=256
  currentDate="$(date +%Y-%m-%d)"
  keyDir="${HOME}/.ssh"
  AuthorizedKeysPath="${HOME}/.ssh/authorized_keys"

  printf "\e[0;38;5;93mSelect Key Type (Default: %s %s)\e[0m\n" "${keyType}" "${keyBits}"
  printf "\e[0;38;5;190med25519 256 is more secure\e[0m\n\n"
  printf "\t\e[0;38;5;33mPress '1' To Use %s %s\e[0m\n" "${keyType}" "${keyBits}"
  printf "\t\e[0;38;5;33mPress '2' To Use rsa 4096\e[0m\n\n"
  read -r keyTypeChoice
  if [[ "${keyTypeChoice}" == "1" ]]; then
    keyType="ed25519"
    keyBits=256
  elif [[ "${keyTypeChoice}" == "2" ]]; then
    keyType="rsa"
    keyBits=4096
    printf "\e[0;38;5;93mAre you sure you want to use %s %s to create the SSH key?\e[0m\n" "${keyType}" "${keyBits}"
    printf "\e[0;38;5;93med25519 256 is more secure\e[0m\n "
    printf "\e[0;38;5;93mPress 'y' To Use %s %s\e[0m:  " "${keyType}" "${keyBits}"
    read -s -r -t 10 -q \
    || keyType="ed25519" \
    || keyBits=256
  else
    keyType="ed25519"
    keyBits=256
  fi
  printf "\n\e[0;38;5;33mUsing \e[0;38;5;190m%s %s\e[0m\n" "${keyType}" "${keyBits}"

  [[ -z "${cleanedKeyName}" ]] \
    && printf "\e[0;1;38;5;196mError: No Name For The Key!\e[0m\n" \
    && return 1

  [[ -z "${keyType}" ]] \
    && printf "\e[0;1;38;5;196mError: No Key Type!\e[0m\n" \
    && return 1

  [[ ! -d "${keyDir}" ]] \
    && printf "\e[0;1;38;5;196mError: '%s' Does NOT Exist!\e[0m\n" "${keyDir}" \
    && return 1

  printf "\e[0;38;5;93mPress 'y' To Add A Server Hostname to the SSH Key Name\e[0m: "
  read -s -r keyHostnameChoice

  if [[ "${keyHostnameChoice}" == "y" ]]; then
    if [[ -n "${HOST}" ]]; then
      printf "\e[0;38;5;93mPress 'y' To Use Hostname Of This Computer (\e[0;38;5;201m%s\e[0;38;5;93m) In SSH Key Name\e[0m: " "${HOST}" \
      read -s -r -t 10 -q \
        && currentHost="${HOST}-"
      [[ -z "${currentHost}" ]] \
        && printf "\e[0;38;5;93mEnter Comment/KeyName \e[38;5;241m(Spaces will be replaced by underscores '_')\e[0m\n\n\t\e[38;5;201m[>\e[0m " \
        && read -r currentHostUnclean \
        && currentHost="${currentHostUnclean// /_}-"
    fi
  elif [[ "${keyHostnameChoice}" == "n" ]]; then
    currentHost=""
  elif [[ "${keyHostnameChoice}" == "N" ]]; then
    currentHost=""
  else
    currentHost=""
  fi

  [[ -z "${currentDate}" ]] \
    && currentDate="-" \
    || currentDate="${currentDate}-"

  KeyName="${cleanedKeyName}-${currentHost}${currentDate}${keyType}"
  keyPath="${keyDir}/${KeyName}"
  [[ -z "${KeyName}" ]] \
    && printf "\e[0;1;38;5;196mError: Cannot Define Key Name!\e[0m\n" \
    && return 1

  [[ -e "${keyPath}" ]] \
    && printf "\e[0;1;38;5;196mError: Key Already Exists!\e[0m\n" \
    && return 1

  printf "\n"
  printf "\t\e[0;38;5;33mName   :\t\e[0;38;5;190m%s\e[0m\n" "${KeyName}"
  printf "\t\e[0;38;5;33mPath   :\t\e[0;38;5;190m%s\e[0m\n" "${keyPath}"
  printf "\t\e[0;38;5;33mComment:\t\e[0;38;5;190m%s\e[0m\n" "${cleanedKeyName}"
  printf "\t\e[0;38;5;33mType   :\t\e[0;38;5;190m%s\e[0m\n" "${keyType}"
  printf "\t\e[0;38;5;33mBits   :\t\e[0;38;5;190m%s\e[0m\n" "${keyBits}"
  printf "\n"
  printf "\e[0;38;5;93mPress 'y' To Create SSH Key\e[0m: "
  read -s -r -q \
    || printf "\e[0;2;38;5;190mExiting ...\e[0m\n" \
    || return 0

  printf "\n\e[0;38;5;190mGenerating SSH Key ...\e[0m\n"
  ssh-keygen \
    -v \
    -o \
    -v \
    -a "${keyBits}" \
    -t "${keyType}" \
    -C "${KeyName}" \
    -f "${keyPath}" \
      && printf "\n\e[0;38;5;82mGenerated SSH Key ...\e[0m\n" \
      || printf "\n\e[0;2;38;5;196mError: Failed Generating SSH Key!\e[0m\n" \
      || return 1

  [[ ! -e "${AuthorizedKeysPath}" ]] \
    && printf "\e[0;2;38;5;82mDONE\e[0m\n" \
    && return 0

  printf "\n\e[0;38;5;93mDo you want to add this key to \e[0;38;5;190m'Authorized_Keys'\e[0;38;5;93m?\e[0m\n"
  printf "\e[0;38;5;93mPress 'y' To Add The Generated SSH Public Key to \e[0;38;5;190m'Authorized_Keys'\e[0;38;5;93m\e[0m: "
  read -s -r -t 10 add_to_auth_keys
  if [[ "${add_to_auth_keys}" == "y" ]]; then
    printf "\n\e[0;38;5;33mAdding to Generated SSH Public Key to \e[0;38;5;190m'Authorized_Keys'\e[0m\n"
    keyPublic="$(cat "${keyPath}".pub)"
    echo "${keyPublic}" >> "${AuthorizedKeysPath}" \
      && printf "\e[0;38;5;82mAdded Generated SSH Public Key to \e[0;38;5;190m'Authorized_Keys'\e[0m\n" \
      && return 0 \
      || printf "\e[0;2;38;5;196mError: Failed To Add SSH Public Key To \e[0;38;5;190m'Authorized_Keys'\e[0;1;38;5;196m!\e[0m\n" \
      || return 1
  else
    printf "\n\e[0;2;38;5;93mNot adding key to \e[0;38;5;190m'Authorized_Keys'\e[0;2;38;5;93m ...\e[0m\n"
  fi
  printf "\n\e[0;2;38;5;46mExiting ...\e[0m\n"
  sleep 1
  tput rmcup
  printf "\n"
  printf "\t\e[0;38;5;33mName   :\t\e[0;38;5;190m%s\e[0m\n" "${KeyName}"
  printf "\t\e[0;38;5;33mPath   :\t\e[0;38;5;190m%s\e[0m\n" "${keyPath}"
  printf "\t\e[0;38;5;33mComment:\t\e[0;38;5;190m%s\e[0m\n" "${cleanedKeyName}"
  printf "\t\e[0;38;5;33mType   :\t\e[0;38;5;190m%s\e[0m\n" "${keyType}"
  printf "\t\e[0;38;5;33mBits   :\t\e[0;38;5;190m%s\e[0m\n" "${keyBits}"
  printf "\n"
}
alias ssh-secure-keygen="_ssh_secure_keygen"

  # ed25519
  # rsa4096

  ## -v   : Verbose
  # -A  -- generate host keys for all key types
  # -B  -- show the bubblebabble digest of key
  # -b  -- specify number of bits in key
  # -c  -- change comment in private and public key files
  # -C  -- provide new comment
  # -D  -- download key stored in smartcard reader
  # -e  -- export key to SECSH file format
  # -f  -- key file
  # -F  -- search for host in known_hosts file
  # -H  -- hash names in known_hosts file
  # -i  -- import key to OpenSSH format
  # -K  -- download resident keys from a FIDO authenticator
  # -k  -- generate a KRL file
  # -L  -- print the contents of a certificate
  # -M  -- moduli generation
  # -N  -- provide new passphrase
  # -p  -- change passphrase of private key file
  # -q  -- silence ssh-keygen
  # -Q  -- test whether keys have been revoked in a KRL
  # -r  -- print DNS resource record
  # -R  -- remove host from known_hosts file
  # -s  -- certify keys with CA key
  # -t  -- specify the type of the key to create
  # -v  -- verbose mode
  # -y  -- get public key from private key
  # -Y  -- signature action
  #
  #alias ssh-keygen-rsa4096='clear ; echo -n "Enter Comment (no_spaces): " && read sshcomment && clear ; KeyName="$HOST-$(date +%Y-%m-%d)-$sshcomment-rsa4096" && KeyPath="$HOME/.ssh/$KeyName" && echo -e "\nKey:\n\n$KeyPath\n\n" && s


  # sh-keygen -v -t rsa -b 4096 -C "$KeyName" -f "$KeyPath"'
