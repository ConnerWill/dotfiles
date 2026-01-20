# ==============================
# Symmetric GPG File Encryption
# ==============================
function gpg-encrypt-file() {
  local input_file output_file

  # Check for input file argument
  if [[ -z "$1" ]]; then
    print -P "%F{red}Usage:%f gpg-encrypt-file <input_file> [output_file]"
    return 1
  fi

  input_file="$1"
  output_file="${2:-${input_file}.gpg}"

  # Ensure output file ends with .gpg
  [[ "${output_file}" != *.gpg ]] && output_file="${output_file}.gpg"

  # Check input file exists
  if [[ ! -f "$input_file" ]]; then
    print -u2 -P "%F{red}Error:%f Input file '%F{yellow}${input_file}%f' does not exist."
    return 1
  fi

  # Perform encryption
  gpg \
    --symmetric \
    --cipher-algo aes256 \
    --digest-algo sha512 \
    --cert-digest-algo sha512 \
    --compress-algo none -z 0 \
    --s2k-mode 3 \
    --s2k-digest-algo sha512 \
    --s2k-count 65011712 \
    --force-mdc \
    --pinentry-mode loopback \
    --armor \
    --no-symkey-cache \
    --output "${output_file}" \
    "${input_file}"

  print -P "%F{green}Encrypted:%f '%F{cyan}${input_file}%f' -> '%F{cyan}${output_file}%f'"
}

# ==============================
# Symmetric GPG File Decryption
# ==============================
function gpg-decrypt-file() {
  local input_file output_file

  if [[ -z "$1" ]]; then
    print -P "%F{red}Usage:%f gpg-decrypt-file <input_file> [output_file]"
    return 1
  fi

  input_file="$1"
  output_file="${2:-${input_file%.gpg}}"

  # Check input file exists
  if [[ ! -f "$input_file" ]]; then
    print -u2 -P "%F{red}Error:%f Input file '%F{yellow}${input_file}%f' does not exist."
    return 1
  fi

  # Perform decryption
  gpg \
    --decrypt \
    --pinentry-mode loopback \
    --armor \
    --output "${output_file}" \
    "${input_file}"

  print -P "%F{green}Decrypted:%f '%F{cyan}${input_file}%f' -> '%F{cyan}${output_file}%f'"
}
