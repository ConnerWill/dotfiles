# List all files, long format, colorized, permissions in octal
function ls-octal(){
  local _LS_CMD
  _LS_CMD="$(command -pv ls)"
  [[ -z "${_LS_CMD}" ]] \
    && printf "Cannot locate 'ls' in PATH\n" \
    && return 1
  "${_LS_CMD}" -l "$@" \
    | awk '{
        k=0;
        for (i=0;i<=8;i++)
          k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i));
          if (k)
            printf("%0o ",k);
            printf(" %9s  %3s %2s %5s  %6s  %s %s %s\n", $3, $6, $7, $8, $5, $9,$10, $11);
    }'
}
