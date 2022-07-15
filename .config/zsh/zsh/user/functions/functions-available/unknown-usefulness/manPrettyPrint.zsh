function manPrettyPrint(){
 [[ -z "$1" ]] && echo "You must enter a manpage search term" && return 1
 man --html=cat "$1" | html2text | less --RAW-CONTROL-CHARS > "$1-manpage-wget.md" && rich --padding 1,5,1,5 --markdown --panel rounded --line-numbers --center --text-full --pager --theme one-dark --hyperlinks --no-wrap --guides "$1-manpage-wget.md"
}
