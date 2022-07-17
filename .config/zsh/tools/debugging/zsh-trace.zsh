
#
#ZSH_TRACE_LOG_DIR="$ZDOTDIR/tests/traces"
#[[ ! -d "$ZSH_TRACE_LOG_DIR" ]] \
#  && mkdir -p -v "$ZSH_TRACE_LOG_DIR"


function _zsh_trace(){

  local ZSH_TRACE_LOG_DIR="$ZDOTDIR/tests/traces"
  local ZSH_TRACE_LOG_NAME="$(date +'%Y%m%d-%H%M%S')-zsh-trace-log.log"

  [[ ! -d "$ZSH_TRACE_LOG_DIR" ]] \
    && mkdir -p -v "$ZSH_TRACE_LOG_DIR"
  echo -e "\e[1;38;5;82mStarting trace of ZSH ...\e[0m" ; sleep 0.2
  zsh -o -v SOURCE_TRACE 2&> "$ZSH_TRACE_LOG_DIR/$ZSH_TRACE_LOG_NAME"
  exit

  ### View Only Errors In Trace
  #cat "$HOME/temporary/zsh-trace.log" | grep -e '^[^\+]'
}
alias zsh_trace="_zsh_trace"


function zshtraceextended(){

  local ZSH_TRACE_LOG_DIR="$ZDOTDIR/tests/traces"
  local ZSH_TRACE_LOG_NAME="$(date +'%Y%m%d-%H%M%S')-zsh-extended-trace-log.log"

  [[ ! -d "$ZSH_TRACE_LOG_DIR" ]] \
    && mkdir -p -v "$ZSH_TRACE_LOG_DIR"

  echo -e "\e[1;38;5;190mStarting extened trace of ZSH ...\e[0m" ; sleep 0.2
  zsh -o SOURCE_TRACE 2&> "$ZSH_TRACE_LOG_DIR/$ZSH_TRACE_LOG_NAME"

  ### Run Trace On ZSH Startup
  zsh -xv 2&> "$ZSH_TRACE_LOG_DIR/$ZSH_TRACE_LOG_NAME"
  exit

  _zsh_trace

  ### View Only Errors In Trace
  #cat "$HOME/temporary/zsh-trace.log" | grep -e '^[^\+]'
}


alias zshtrace-extended="zshtraceextended"
#zshtraceextended
