toiletpreview() {
  local fonts_dir=/usr/share/figlet/fonts
  local text=${1}
  local font name sample

  if (( ! $+commands[toilet] )); then
    print -u2 "toiletpreview: 'toilet' is not installed"
    return 1
  fi

  if [[ ! -d ${fonts_dir} ]]; then
    print -u2 "toiletpreview: font directory not found: ${fonts_dir}"
    return 1
  fi

  for font in ${fonts_dir}/*.(tlf|flf)(.N); do
    name=${font:t:r}
    sample=${text:-${name}}
    print -- "${name}"
    toilet --rainbow --termwidth --filter border --directory "${fonts_dir}" --font "${name}" "${sample}" 2>/dev/null
  done
}
