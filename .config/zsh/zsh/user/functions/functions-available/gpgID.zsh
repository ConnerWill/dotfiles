function gpgID(){
  local DEFAULTKEYNAME KEYNAME
  DEFAULTKEYNAME="$(whoami)"
	KEYNAME="$1"
	[[ -n "${KEYNAME}" ]] \
    || local KEYNAME="${DEFAULTKEYNAME}"
	gpg \
    --list-signatures \
    --with-colons \
      | grep 'sig' \
        | grep "${KEYNAME}" \
          | head -n 1 \
            | cut -d':' -f5
}
