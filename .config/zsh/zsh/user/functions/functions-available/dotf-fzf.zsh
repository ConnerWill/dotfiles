  # Enhanced Git Status (Open multiple files with tab + diff preview)
  fzf-dotf-status() {

    tput smcup
    clear
      local selected
      git --git-dir=$DOTFILES --work-tree=$HOME rev-parse --git-dir > /dev/null 2>&1 \
        || printf "\e[0;1;38;5;190;48;5;196m\t\t\t\tΣΣΣΣΣΣΣΣΣΣΣΣ\nᵈªʳⁿ\t\t\t\t\n\t\t WTF ?!?!?!\t\n\n\e[0m\n\n\e[0;1;38;5;201m\t\t You aint in no git repo\e[0m\n\e[0;1;3;4;38;5;87;48;5;201m\n\n\t\t Cant do shit ...\t\t\n\t\t\n\n\n\e[0m\n" \
        || return 1
        # || printf "\e[0;1;3;4;38;5;190;48;5;196m\t\tWTF?!?!?!\e[0\n\nm\e[0;1;38;5;201mYou aint in no git repo\e[0m\n\e[0;1;3;4;38;5;87;48;5;201mCant do shit ...\e[0m\n" \
      selected=$( \
        git --git-dir=$DOTFILES --work-tree=$HOME -c color.status=always status --short \
          | fzf                                                                                                                                                       \
              --height 50% "$@"                                                                                                                                       \
              --border                                                                                                                                                \
              -m                                                                                                                                                      \
              --ansi                                                                                                                                                  \
              --reverse                                                                                                                                               \
              --inline-info                                                                                                                                           \
              --preview-window='down,80%'                                                                                                                             \
              --header-first                                                                                                                                          \
              --color='fg:#00FFFF,bg:#101010,hl:#4909bb,hl+:#ff00ff,preview-fg:#ffffff,preview-bg:#020202,gutter:#000000,header:#666666,border:#900aff'               \
              --header="$(git --git-dir=$DOTFILES --work-tree=$HOME remote get-url --all origin)"                                                                     \
              --nth 2..,..                                                                                                                                            \
              --preview "(git --git-dir=$DOTFILES --work-tree=$HOME diff --color=always --text -- {-1} | sed 1,4d; cat {-1}) | head -500"                             \
              --bind 'ctrl-/:toggle-preview'                                                                                                                          \
              --bind 'pgdn:preview-page-down'                                                                                                                         \
              --bind 'pgup:preview-page-up'                                                                                                                           \
              --bind 'j:down'                                                                                                                                         \
              --bind 'k:up'                                                                                                                                           \
              --bind "J:preview-down"                                                                                                                                 \
              --bind "K:preview-up"                                                                                                                                   \
              --bind 'home:last'                                                                                                                                      \
              --bind 'end:first'                                                                                                                                      \
              --bind "ctrl-p:execute(${PAGER} {})"                                                                                                                    \
              --bind "ctrl-e:execute(${EDITOR} {})"                                                                                                                   \
              --bind "enter:execute(git --git-dir=$DOTFILES --work-tree=$HOME diff --color=always --text -- {-1} | sed 1,4d; cat {-1} | less --RAW-CONTROL-CHARS)"    \
              --bind "ctrl-a:execute(git --git-dir=$DOTFILES --work-tree=$HOME add -v {})"                                                                            \
              --bind "ctrl-r:execute(git --git-dir=$DOTFILES --work-tree=$HOME rm --cached {})" \
              --bind "ctrl-e:execute(${EDITOR} {1})" \
          | cut -c4- \
            | sed 's/.* -> //' \
      )
      if [[ $selected ]]; then
        for prog in ${selected};
        do
          "${EDITOR}" "${prog}"
        done
      fi
    # tput rmcup
  }

  # Checkout to existing branch or else create new branch. gco <branch-name>.
  # Falls back to fuzzy branch selector list powered by fzf if no args.
  fzf-dotf-checkout(){
      if git --git-dir=$DOTFILES --work-tree=$HOME rev-parse --git-dir > /dev/null 2>&1; then
          if [[ "$#" -eq 0 ]]; then
              local branches branch
              branches=$(git --git-dir=$DOTFILES --work-tree=$HOME branch -a) &&
              branch=$(echo "$branches" |
              fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m -- --reverse --color='fg:#00FFFF,fg+:#ff0000,bg:#202020v,hl:#eeff00,hl+:#ff00ff' --header="$(git --git-dir=$DOTFILES --work-tree=$HOME remote get-url --all origin)" ) &&
              git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
       elif git --git-dir=$DOTFILES --work-tree=$HOME rev-parse --verify --quiet "$@" || git --git-dir=$DOTFILES --work-tree=$HOME branch --remotes | grep  --extended-regexp "^[[:space:]]+origin/${*}" ]; then
              echo "Checking out to existing branch"
              git --git-dir=$DOTFILES --work-tree=$HOME checkout "$*"
          else
              echo "Creating new branch"
              git --git-dir=$DOTFILES --work-tree=$HOME checkout -b "$*"
          fi
      else
        printf "\e[0;1;38;5;190;48;5;196m\t\t\t\tΣΣΣΣΣΣΣΣΣΣΣΣ\nᵈªʳⁿ\t\t\t\t\n\t\t WTF ?!?!?!\t\n\n\e[0m\n\n\e[0;1;38;5;201m\t\t You aint in no git repo\e[0m\n\e[0;1;3;4;38;5;87;48;5;201m\n\n\t\t Cant do shit ...\t\t\n\t\t\n\n\n\e[0m\n"
        printf "\e[0;1;38;5;87;48;5;46m\t \t\t \t\t \t\t \t\t \t\t \t\t \t\t \t         ⇙⇐⇖⇑⇗⇒⇘⇓\t \t\t \t\t \t\t \t\t \t\t \t       \e[0m\e[0;1;38;5;8m\t \t\t \t\t \t\t \t\t \t\t \t\t \t\t \t\t \t         bye\e[0m\e[0;1;3;4;38;5;249;48;5;8m∞πΣ±_‹[]\e[0m"
        return 1
      fi
  }


