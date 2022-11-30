#!/usr/bin/env sh

# Implements: OSC 8 <URL> ST <Link-text> OSC 8 ST
# Prints a terminal-clickable hyperlink
# See: https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda
#
# @Params
# $1: The hyperlink URL
# $2: The optional hyperlink text (defaults to URL)
#
# @Outputs
# The terminal-clickable hyperlink
hyperlink(){ printf '\e]8;;%s\e\\%s\e]8;;\e\\\n' "$1" "${2:-$1}";}


hl=$(
  hyperlink \
    https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda \
    'OSC 8 <URL> ST <Link-text> OSC 8 ST'
)

printf 'Demo of the %s sequence\nto make hyperlinks clickable in terminal:\n\n' \
  "$hl"

hyperlink https://www.example.com/ 'Example link'
printf \\n
hyperlink https://www.example.com/
printf \\n
