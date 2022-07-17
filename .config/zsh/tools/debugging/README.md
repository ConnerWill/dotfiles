# **DEBUGGING**

> **To run a diagnostics dump, run command:**

```shell
zsh_diagnostic_dump
```

> If you're getting weird behavior and can't find the culprit,
> run the following command to enable debug mode:

```shell
_zsh_debug_log_dir="${XDG_CACHE_HOME}/zsh/debug-logs"
[[ ! -d "${_zsh_debug_log_dir}" ]] && mkdir -pv "${_zsh_debug_log_dir}"
_zsh_debug_log_path="${_zsh_debug_log_dir}/$(date +'%Y%m%d%H%M%S')_zsh_debug.log"
zsh -xv 2> >(tee "${_zsh_debug_log_path}" &>/dev/null)
```

> *Afterwards, reproduce the behavior (i.e. if it's a particular command, run it), and*
>
> *When you're done, run exit to stop the debugging session.*
>
> *This will create a log file*

**`${XDG_CACHE_HOME}/zsh/debug-logs/$(date +'%Y%m%d%H%M%S')_zsh_debug.log`**

> *With a trace of every command executed and its output.*
>
> *You can then upload this file and create an issue or debug it yourself* **:)**
>
> *If you only need to debug the session initialization, you can do so with the command:*

```shell
_zsh_debug_log_dir="${XDG_CACHE_HOME}/zsh/debug-logs"
[[ ! -d "${_zsh_debug_log_dir}" ]] && mkdir -pv "${_zsh_debug_log_dir}"
_zsh_debug_log_path="${_zsh_debug_log_dir}/$(date +'%Y%m%d%H%M%S')_zsh_debug.log"
zsh -xvic exit &> "${_zsh_debug_log_path}"
${PAGER:-less} ${_zsh_debug_log_path}"
```

> *To list all keybindings, run this command:*

```shell
bindkey -l | xargs -I{} zsh --onecmd -c "printf '\e[0;1;38;5;46m======================\e[0m\n\t{}\t\t\n\e[0;1;38;5;46m======================\e[0m\n' && bindkey -R -M '{}'" | less --RAW-CONTROL-CHARS
```

> *Or:*

```shell
bindkey -l | xargs -I{} zsh --onecmd -c "printf '======================\n\t{}\t\t\n======================\n' && bindkey -R -M '{}'" | bat -l zsh
```
