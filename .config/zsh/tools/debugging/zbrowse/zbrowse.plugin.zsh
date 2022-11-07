#!/usr/bin/env zsh
#
# -*- mode: sh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
#
# Copyright (c) 2016-2020 Sebastian Gniazdowski and contributors
# Copyright (c) 2021-2022 zdharma-continuum and contributors

# No plugin manager is needed to use this file. All that is needed is adding:
# source {where-zbrowse-is}/zbrowse.plugin.zsh in zshrc

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"
ZBROWSE_REPO_DIR="${0:h}"
[[ ! -d "${XDG_CONFIG_HOME:-$HOME/.config}/zbrowse" ]] && command mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/zbrowse"
if [[ ${zsh_loaded_plugins[-1]} != */zbrowse && -z ${fpath[(r)${0:h}(|/)]} ]]
then
  fpath+=("${0:h}")
fi
autoload zbrowse
zle -N zbrowse
bindkey '^B' zbrowse
zmodload zsh/parameter || {
  echo "No zsh/parameter module, zdharma-continuum/zbrowse not registering itself"
  return 0
}
typeset -gAH ZBROWSE_BEFORE
typeset -gaUH ZBROWSE_IPARAMS
typeset -gaUH ZBROWSE_CHANGED_IPARAMS
typeset -gH ZBROWSE_IPARAMS_POST
typeset -gaH ZBROWSE_BLACK_LIST
ZBROWSE_BLACK_LIST=('?' '*' '$' '#' '!' '@' ZUI_PB_WORDS ZUI_PB_LEFT ZUI_PB_WORDS_BEGINNINGS ZUI_PB_RIGHT ZUI_PB_SPACES ZUI_PB_SELECTED_WORD ZUILIST_NONSELECTABLE_ELEMENTS ZUILIST_HOP_INDICES ZUILIST_ACTIVE_SEGMENTS zcurses_attrs zcurses_keycodes zcurses_windows zcurses_colors ZCURSES_COLORS ZCURSES_COLOR_PAIRS _ZSH_HIGHLIGHT_PRIOR_CURSOR _ZSH_HIGHLIGHT_PRIOR_BUFFER ZCALCPROMPT)

#
# Ran before command
#

# FUNCTION: __zbrowse_preexec() {{{
__zbrowse_preexec() {
  ZBROWSE_BEFORE[types]="${(j: :)${(qkv)parameters[@]}}"
  ZBROWSE_BEFORE[values]=""
  local -a __elems
  local __param __param2 __value_str __text __last
  for __param in "${ZBROWSE_CHANGED_IPARAMS[@]}"
  do
    if [[ "${(Pt)__param}" = *association* ]]
    then
      __elems=("${(Pkv@)__param}")
      __last="${__elems[-1]}"
      __elems=("${(@)__elems[1,50]}")
      __text="${__elems[*]}"
    elif [[ "${(Pt)__param}" = *array* ]]
    then
      __param2="${__param}[-1]"
      __last="${(P)__param2}"
      __param2="${__param}[1,50]"
      __elems=("${(@P)__param2}")
      __text="${__elems[*]}"
    else
      __text="${(P)__param}"
      __last="${__text[-10,-1]}"
      __text="${__text[1,300]}"
    fi
    __value_str="$__text$__last"
    ZBROWSE_BEFORE[values]+="${(q)__param} ${(q)__value_str} "
  done
  return 0
} # }}}

#
# Ran after command
#

# FUNCTION: __zbrowse_precmd() {{{
__zbrowse_precmd() {
  builtin setopt localoptions extendedglob
  local ZBROWSE_TYPES_AFTER="${(j: :)${(qkv)parameters[@]}}"
  [[ "${ZBROWSE_BEFORE[types]}" != *[$'! \t']* || "$ZBROWSE_TYPES_AFTER" != *[$'! \t']* ]] && return 0
  local -A params_before params_after
  params_before=("${(z)ZBROWSE_BEFORE[types]}")
  params_after=("${(z)ZBROWSE_TYPES_AFTER}")
  ZBROWSE_BEFORE[types]=""
  local __key
  typeset -aU __keys
  __keys=("${(k)params_after[@]}" "${(k)params_before[@]}")
  for __key in "${__keys[@]}"
  do
    __key="${(Q)__key}"
    [[ -n "${ZBROWSE_BLACK_LIST[(er)$__key]}" || "${(Pt)__key}" = *special* ]] && continue
    if [[ -z "${params_before[$__key]}" ]]
    then
      ZBROWSE_IPARAMS+=("$__key")
      ZBROWSE_CHANGED_IPARAMS[1,0]=("$__key")
    elif [[ "${params_after[$__key]}" != "${params_before[$__key]}" ]]
    then
      ZBROWSE_CHANGED_IPARAMS[1,0]=("$__key")
    fi
  done
  local -A __before_values
  if [[ -n "${ZBROWSE_BEFORE[values]}" ]]
  then
    __before_values=("${(z)ZBROWSE_BEFORE[values]}")
    __before_values=("${(Qkv)__before_values[@]}")
  fi
  local __size_limit
  zstyle -s ':plugin:zbrowse' var-size-limit __size_limit || __size_limit="2048"
  local data_dir="${XDG_CONFIG_HOME:-$HOME/.config}/zbrowse"
  local -a __elems __all_elems
  local __param __param2 __value_str __text __all_text __last
  for __param in "${ZBROWSE_CHANGED_IPARAMS[@]}"
  do
    if [[ "${(Pt)__param}" = *association* ]]
    then
      __all_elems=("${(Pkv@)__param}")
      __all_text="${(j::)__all_elems}"
      __last="${__all_elems[-1]}"
      __elems=("${(@)__all_elems[1,50]}")
      __text="${__elems[*]}"
      __all_elems=("${(qqqq@)__all_elems}")
      [[ -z "$__text" ]] && continue
      [[ "${#__all_text}" -gt "$__size_limit" ]] && continue
      [[ "$__text$__last" != "${__before_values[$__param]}" ]] && print -r -- "association ${(q)__param} ${__all_elems[*]}" >>| "$data_dir"/param.log
    elif [[ "${(Pt)__param}" = *array* ]]
    then
      __all_text="${(Pj::)__param}"
      __param2="${__param}[-1]"
      __last="${(P)__param2}"
      __param2="${__param}[1,50]"
      __text="${(Pj: :)__param2}"
      [[ -z "$__text" ]] && continue
      [[ "${#__all_text}" -gt "$__size_limit" ]] && continue
      __all_elems=("${(P@)__param}")
      __all_elems=("${(qqqq@)__all_elems}")
      [[ "$__text$__last" != "${__before_values[$__param]}" ]] && print -r -- "array ${(q)__param} ${__all_elems[*]}" >>| "$data_dir"/param.log
    else
      __all_text="${(P)__param}"
      [[ "${#__all_text}" -gt "$__size_limit" ]] && continue
      __last="${__all_text[-10,-1]}"
      __text="${__all_text[1,300]}"
      __all_text="${(qqqq)__all_text}"
      [[ -z "$__text" ]] && continue
      [[ "$__text$__last" != "${__before_values[$__param]}" ]] && print -r -- "scalar ${(q)__param} ${__all_text}" >>| "$data_dir"/param.log
    fi
  done
} # }}}

autoload -Uz add-zsh-hook
add-zsh-hook preexec __zbrowse_preexec
add-zsh-hook precmd __zbrowse_precmd

# vim:ft=zsh sw=2 sts=2 et foldmarker={{{,}}} foldmethod=marker
