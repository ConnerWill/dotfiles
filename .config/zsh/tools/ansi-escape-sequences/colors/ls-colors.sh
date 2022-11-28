# Note: Using the --color option with ls may incur a noticeable performance
#       penalty when ls is run in a directory with very many entries.
#       The default settings require ls to stat(1) every single file it lists.
#       However, if you would like most of the file-type coloring but can live
#       without the other coloring options
#         (e.g. executable, orphan, sticky, other-writable, capability),
#       use dircolors to set the LS_COLORS environment variable like this:
#
#  $ eval $(dircolors -p | perl -pe 's/^((CAP|S[ET]|O[TR]|M|E)\w+).*/$1 00/' | dircolors -)
