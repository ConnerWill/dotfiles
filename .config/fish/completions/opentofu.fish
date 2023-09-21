
function __complete_opentofu
    set -lx COMP_LINE (commandline -cp)
    test -z (commandline -ct)
    and set COMP_LINE "$COMP_LINE "
    /usr/bin/opentofu
end
complete -f -c opentofu -a "(__complete_opentofu)"

