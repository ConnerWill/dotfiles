```
# b - browse chrome bookmarks
b() {
  local open ruby output
  open=xdg-open
  ruby=$(which ruby)
  output=$($ruby << EORUBY
# encoding: utf-8

require 'json'
FILE = '~/.config/google-chrome/Default/Bookmarks'
CJK  = /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/

def build parent, json
  name = [parent, json['name']].compact.join('/')  
  if json['type'] == 'folder'
    json['children'].map { |child| build name, child }
  else
    { name: name, url: json['url'] }
  end
end

def just str, width
  str.ljust(width - str.scan(CJK).length)
end

def trim str, width
  len = 0
  str.each_char.each_with_index do |char, idx|
    len += char =~ CJK ? 2 : 1
    return str[0, idx] if len > width
  end
  str
end

width = `tput cols`.to_i / 2
json  = JSON.load File.read File.expand_path FILE
items = json['roots']
        .values_at(*%w(bookmark_bar synced other))
        .compact
        .map { |e| build nil, e }
        .flatten

items.each do |item|
  name = trim item[:name], width
  puts [just(name, width),
        item[:url]].join("\t\x1b[36m") + "\x1b[m"
end
EORUBY
)

  echo -e "$output"                                            |
  fzf-tmux -u 30% --ansi --multi --no-hscroll --tiebreak=begin |
  awk 'BEGIN { FS = "\t" } { print $2 }'                       |
  xargs open &>/dev/null

}
```