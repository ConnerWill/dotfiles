function tldrfzf(){
###{{{ Check if depends are installed
  command -v tldr >/dev/null 2>&1 || printf "\e[0;38;5;196mCannot find command 'tldr' :(\e[0m" || unfunction tldrfzf || return 1
  command -v fzf  >/dev/null 2>&1 || printf "\e[0;38;5;196mCannot find command 'fzf' :(\e[0m"  || unfunction tldrfzf || return 1
  command -v bat  >/dev/null 2>&1 && less_cat='bat --color=always --paging=always' || less_cat='less'
###}}}
	local fzf_colors searchquery less_cat
  searchquery="${*}"
	fzf_colors='hl:#00ffff,hl+:#ff00ff,fg:#505050,fg+:#00ffff,bg:#010101,bg+:#202020,query:#00ff00,info:#9090a0,spinner:#ff00ff,border:#ff00ff,preview-fg:#ffffff,preview-bg:#200050,gutter:#101010,pointer:#ff00ff,info:#020202'
  tldr --list \
    | sort --random-sort \
      | fzf \
          --ansi \
          --extended \
          --sync \
          --border rounded \
          --margin 0,0,0,0 \
          --padding 0,0,0,0	\
          --header-first \
          --inline-info \
          --print-query \
          --query "${searchquery}" \
          --color="${fzf_colors}" \
          --preview='printf "\e[0;48;5;232m\t\t\e[1;38;5;14m    {}\t\t\t\t\t\t\e[0m\n"; tldr {}' \
          --preview-window='right,70%,border' \
          --bind 'enter:accept'
}
