









# #
# function _zshsecondaryhistory_check_add_load(){
#   if [[ ! -e "${ZSH_HISTFILE_SECONDARY}" ]]; then
#     mkdir -pv "${ZSH_HISTFILE_SECONDARY}" \
#       || printf "Error creating directory '%s' \n" "${ZSH_HISTFILE_SECONDARY}" \
#       || return 1
 export ZSH_HISTFILE_SECONDARY="${XDG_CACHE_HOME/zsh/zsh-history/hist2}"
    zshaddhistory() {
      print -sr -- "${1%%$'\n'}"
      fc -p "${ZSH_HISTFILE_SECONDARY}"
    }
zmodload -a zshaddhistory
#  fi
#}
#[[ -n "${ZSH_HISTFILE_SECONDARY}" ]] \
#  && if [[ ! _zshsecondaryhistory_check_add_load ]]; then
#        unfunction _zshsecondaryhistory_check_add_load 
#  fi
