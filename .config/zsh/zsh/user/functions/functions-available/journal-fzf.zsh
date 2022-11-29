function journalctl-fzf(){

  local colorzfz='hl:#FFFF00,hl+:#DD00FF,fg:#CCCCEE,fg+:#00ffff,bg:#010101,bg+:#202020,query:#FFFF00,info:#99BBee,spinner:#ff00ff,border:#770aff,label:bold:#770aff,preview-fg:#ffffff,preview-bg:#090909,marker:#00ff00,gutter:#101010,pointer:#00ffff,info:#020202,header:#191919'

  sudo --validate
 sudo journalctl \
                                      --no-pager         \
                                       --since=2000-01-01 \
--priority=5 \
                                      --no-hostname      \
| tee /dev/tty | fzf \
    --sync              \
    --no-sort           \
    --ansi              \
    --print-query       \
    --color=dark        \
    --border horizontal \
    --inline-info       \
    # --color="${colorzfz}" # < <( sudo journalctl \
    #                                   --full             \
    #                                   --all              \
    #                                   --follow           \
    #                                   --no-pager         \
    #                                   --no-hostname      \
    #                           )
  }
