ZSH_TRACE_LOG_DIR="$ZDOTDIR/tests/traces"
ZSH_TRACE_LOG_NAME="$(date +'%Y%m%d-%H%M%S')-zsh-extended-trace-log.log"

[[ ! -d "$ZSH_TRACE_LOG_DIR" ]] \
  && mkdir -p -v "$ZSH_TRACE_LOG_DIR"

echo -e "\e[1;38;5;190mStarting extened trace of ZSH ...\e[0m" ; sleep 0.2
zsh -o SOURCE_TRACE 2&> "$ZSH_TRACE_LOG_DIR/$ZSH_TRACE_LOG_NAME"

### Run Trace On ZSH Startup
zsh -x 2&> "$ZSH_TRACE_LOG_DIR/$ZSH_TRACE_LOG_NAME"
exit


#zshtraceextended
