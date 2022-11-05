
zsh_timing_log_dir="${XDG_CACHE_HOME}/zsh/debug-logs/zsh_time_test_logs"
zsh_timing_log_path="${zsh_timing_log_dir}/zsh_time_test.log"
zsh_timing_diff_log_path="${zsh_timing_log_dir}/zsh_time_test_diff.log"

function remove_old_timing_logs(){
  find "${zsh_timing_log_dir}" -type f -name "*.log" | xargs -I'{}' rm -f '{}'
}
#remove_old_timing_logs

function timelogging_start(){
  local INPUT
  unset noww_start
  export noww_start
  INPUT="${1}"
  noww_start=$(date +%N)
  printf "Start:\t%s\t%s" "${noww_start}" "${INPUT}" >> "${zsh_timing_log_path}"
  printf "\n" >> "${zsh_timing_log_path}"
}

function timelogging_end(){
  local INPUT
  unset noww_end
  export noww_end
  INPUT="${1}"
  noww_end=$(date +%N)
  printf "End  :\t%s\t%s" "${noww_end}" "${INPUT}" >>"${zsh_timing_log_path}"
  printf "\n" >> "${zsh_timing_log_path}"
  #timeloggin_math "${noww_start}" "${noww_end}" "${INPUT}"
}

function timeloggin_math(){
  local INPUT_start INPUT_end
  unset noww_diff
  export noww_diff
  INPUT_start="${1}"
    INPUT_end="${2}"
        INPUT_file="${3}"
  noww_diff=$((INPUT_end - INPUT_start))
  printf "Diff :\t%s\t%s" "${noww_diff}" "${INPUT_file}" >> "${zsh_timing_log_path}"
  printf "\n\n" >> "${zsh_timing_log_path}"
  printf "%s\t\t%s\n" "${noww_diff}" "${INPUT_file}" >> "${zsh_timing_diff_log_path}"
}
