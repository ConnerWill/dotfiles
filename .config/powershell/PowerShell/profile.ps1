
$PWSHDOTDIR="$(Split-Path -Path $PROFILE.CurrentUserAllHosts)"    
$_PWSH_ENTRY_DIR="pwsh"
$_PWSH_USER="user"
$_PWSH_LOAD_DIR="$PWSHDOTDIR\$_PWSH_ENTRY_DIR\$_PWSH_USER"
$_PWSHDOTDIR_D="$_PWSH_LOAD_DIR\pwsh.d"

Get-ChildItem -Path $_PWSHDOTDIR_D | ForEach-Object {
    . $_.FullName
}
