### Export this path
# export ZSH_OPTIONS_DIR="$ZDOTDIR/options"

################################
##          OPTIONS
################################
setopt VI
setopt INTERACTIVECOMMENTS                ## COMMENTS
setopt GLOB_DOTS                ## COMMENTS
setopt NUMERIC_GLOB_SORT
setopt MENUCOMPLETE                ## COMMENTS
setopt NO_CLOBBER
setopt APPEND_CREATE
setopt LIST_TYPES
setopt MARK_DIRS
setopt RM_STAR_WAIT
setopt MONITOR
setopt NOTIFY
setopt TRANSIENT_RPROMPT
setopt PRINT_EXIT_VALUE
setopt CHECK_JOBS
setopt CHECK_RUNNING_JOBS
setopt LONG_LIST_JOBS
setopt AUTO_PUSHD
setopt CDABLE_VARS
setopt COMPLETE_IN_WORD
setopt GLOB_COMPLETE
setopt LIST_AMBIGUOUS
setopt LIST_TYPES
setopt GLOB_DOTS
setopt MARK_DIRS
setopt EXTENDED_HISTORY
setopt INTERACTIVE_COMMENTS
setopt AUTO_CONTINUE
setopt LONG_LIST_JOBS
setopt MONITOR
setopt NOTIFY
setopt C_BASES
setopt OCTAL_ZEROES
setopt DEBUG_BEFORE_CMD
setopt VI
setopt ZLE
# setopt WARN_CREATE_GLOBAL
# setopt AUTO_CD
# history.zsh - http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt append_history          # append to history file
setopt extended_history        # write the history file in the ':start:elapsed;command' format
setopt no_hist_beep            # don't beep when attempting to access a missing history entry
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups       # don't display a previously found event
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt hist_verify             # don't execute immediately upon history expansion
setopt inc_append_history      # write to the history file immediately, not when the shell exits
setopt no_share_history        # don't share history between all sessions

# $HISTFILE belongs in the data home, not with the configs
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh-history/history"
[[ ! -f "$HISTFILE" ]] \
  && mkdir -p "$HISTFILE:h" \
  && touch "$HISTFILE"

# you can set $SAVEHIST and $HISTSIZE to anything greater than the ZSH defaults
# (1000 and 2000 respectively), but if not we make them way bigger.
[[ $SAVEHIST -gt 1000 ]] || SAVEHIST=20000
[[ $HISTSIZE -gt 2000 ]] || HISTSIZE=100000

# make the history command more useful
alias history="fc -li"

### Show configured ZSH options
# [[ -f "$ZSH_OPTIONS_DIR/show-zsh-option-status.zsh" ]] \
  # && source "$ZSH_OPTIONS_DIR/show-zsh-option-status.zsh"
###################################################################
###################################################################
###################################################################
#                Resolve symbolic links to their true values when changing directory.  This also has  the
#              effect of CHASE_DOTS, i.e. a `..' path segment will be treated as referring to the phys‐
#              ical parent, even if the preceding path segment is a symbolic link.
#
#CHASE_LINKS
#
#
#AUTO_LIST
#Automatically list choices on an ambiguous completion.
#
#
#
#
#AUTO_MENU
#              Automatically use menu completion after the second consecutive request  for  completion,
#              for  example  by pressing the tab key repeatedly. This option is overridden by MENU_COM‐
#              PLETE.
#
#
#       COMPLETE_IN_WORD
#              If  unset,  the cursor is set to the end of the word if completion is started. Otherwise
#              it stays there and completion is done from both ends.
#
#
#
#
#       GLOB_COMPLETE
#              When the current word has a glob pattern, do not insert all the words resulting from the
#              expansion  but  generate matches as for completion and cycle through them like MENU_COM‐
#              PLETE. The matches are generated as if a `*' was added to the end of the  word,  or  in‐
#              serted at the cursor when COMPLETE_IN_WORD is set.  This actually uses pattern matching,
#              not globbing, so it works not only for files but for any completion,  such  as  options,
#              user names, etc.
#
#              Note that when the pattern matcher is used, matching control (for example, case-insensi‐
#              tive or anchored matching) cannot be used.  This limitation only applies when  the  cur‐
#              rent  word  contains a pattern; simply turning on the GLOB_COMPLETE option does not have
#              this effect.
#LIST_PACKED
#              Try  to  make the completion list smaller (occupying less lines) by printing the matches
#              in columns with different widths.              
#       LIST_TYPES (-X) <D>
#              When  listing  files  that  are  possible completions, show the type of each file with a
#              trailing identifying mark.
#       MENU_COMPLETE (-Y)
#              On an ambiguous completion, instead of listing  possibilities  or  beeping,  insert  the
#              first  match  immediately.   Then  when  completion is requested again, remove the first
#              match and insert the second match, etc.  When there are no more matches, go back to  the
#              first  one  again.   reverse-menu-complete  may  be used to loop through the list in the
#              other direction. This option overrides AUTO_MENU.
#       GLOB_ASSIGN <C>
#              If this option is set, filename generation (globbing) is performed  on  the  right  hand
#              side  of  scalar parameter assignments of the form `name=pattern (e.g. `foo=*').  If the
#              result has more than one word the parameter will become an array with those words as ar‐
#              guments.  This  option  is provided for backwards compatibility only: globbing is always
#              performed on the right hand side of array assignments of the form  `name=(value)'  (e.g.
#              `foo=(*)')  and  this  form  is recommended for clarity; with this option set, it is not
#              possible to predict whether the result will be an array or a scalar.
#
#       GLOB_DOTS (-4)
#              Do not require a leading `.' in a filename to be matched explicitly.
#       GLOB_SUBST <C> <K> <S>
#              Treat any characters resulting from parameter expansion as being eligible  for  filename
#              expansion  and  filename generation, and any characters resulting from command substitu‐
#              tion as being eligible for filename generation.  Braces (and commas in between)  do  not
#              become eligible for expansion.
#              Substitutions  using the :s and :& history modifiers are performed with pattern matching
#              instead of string matching.  This occurs wherever history modifiers are valid, including
#              glob qualifiers and parameters.  See the section Modifiers in zshexpn(1).
#       MARK_DIRS (-8, ksh: -X)
#              Append a trailing `/' to all directory names resulting from filename  generation  (glob‐
#              bing).
#       NOMATCH (+3) <C> <Z>
#              If  a pattern for filename generation has no matches, print an error, instead of leaving
#              it unchanged in the argument list.  This also applies to file expansion  of  an  initial
#              `~' or `='.
#       NUMERIC_GLOB_SORT
#              If numeric filenames are matched by a filename generation pattern,  sort  the  filenames
#              numerically rather than lexicographically.
#       WARN_CREATE_GLOBAL
#              Print  a  warning message when a global parameter is created in a function by an assign‐
#              ment or in math context.  This often indicates that a parameter has  not  been  declared
#              local  when  it  should  have been.  Parameters explicitly declared global from within a
#              function using typeset -g do not cause a warning.  Note that there is no warning when  a
#              local parameter is assigned to in a nested function, which may also indicate an error.
#       WARN_NESTED_VAR
#              Print  a warning message when an existing parameter from an enclosing function scope, or
#              global, is set in a function by an assignment or in math context.  Assignment  to  shell
#              special  parameters  does  not  cause  a  warning.   This  is the companion to WARN_CRE‐
#              ATE_GLOBAL as in this case the warning is only printed when a parameter is not  created.
#              Where  possible,  use  of typeset -g to set the parameter suppresses the error, but note
#              that this needs to be used every time the parameter is set.  To restrict the  effect  of
#              this option to a single function scope, use `functions -W'.
#
#              For  example,  the following code produces a warning for the assignment inside the func‐
#              tion nested as that overrides the value within toplevel
#
#                     toplevel() {
#                       local foo="in fn"
#                       nested
#                     }
#                     nested() {
#                          foo="in nested"
#                     }
#                     setopt warn_nested_var
#                     toplevel
#   History
#       APPEND_HISTORY <D>
#              If this is set, zsh sessions will append their history list to the history file,  rather
#              than replace it. Thus, multiple parallel zsh sessions will all have the new entries from
#              their history lists added to the history file, in the order that they  exit.   The  file
#              will  still be periodically re-written to trim it when the number of lines grows 20% be‐
#              yond the value specified by $SAVEHIST (see also the HIST_SAVE_BY_COPY option).
#       HIST_EXPIRE_DUPS_FIRST
#              If the internal history needs to be trimmed to add the  current  command  line,  setting
#              this  option  will cause the oldest history event that has a duplicate to be lost before
#              losing a unique event from the list.  You should be sure to set the value of HISTSIZE to
#              a  larger number than SAVEHIST in order to give you some room for the duplicated events,
#              otherwise this option will behave just like HIST_IGNORE_ALL_DUPS once the history  fills
#              up with unique events.
#      HIST_FIND_NO_DUPS
#              When  searching  for  history entries in the line editor, do not display duplicates of a
#              line previously found, even if the duplicates are not contiguous.
#       HIST_IGNORE_ALL_DUPS
#              If a new command line being added to the history list duplicates an older one, the older
#              command is removed from the list (even if it is not the previous event).
#
#       HIST_IGNORE_DUPS (-h)
#              Do  not enter command lines into the history list if they are duplicates of the previous
#              event.
#       HIST_IGNORE_SPACE (-g)
#              Remove command lines from the history list when the first character on  the  line  is  a
#              space,  or  when  one  of  the  expanded  aliases contains a leading space.  Only normal
#              aliases (not global or suffix aliases) have  this  behaviour.   Note  that  the  command
#              lingers  in  the  internal history until the next command is entered before it vanishes,
#              allowing you to briefly reuse or edit the line.  If you want to  make  it  vanish  right
#              away without entering another command, type a space and press return.
#       HIST_REDUCE_BLANKS
#              Remove superfluous blanks from each command line being added to the history list.
#       HIST_SAVE_BY_COPY <D>
#              When  the  history  file  is  re-written, we normally write out a copy of the file named
#              $HISTFILE.new and then rename it over the old one.  However, if this option is unset, we
#              instead truncate the old history file and write out the new version in-place.  If one of
#              the history-appending options is enabled, this option only has an effect  when  the  en‐
#              larged  history  file needs to be re-written to trim it down to size.  Disable this only
#              if you have special needs, as doing so makes it possible to lose history entries if  zsh
#              gets interrupted during the save.
#
#              When  writing  out  a copy of the history file, zsh preserves the old file's permissions
#              and group information, but will refuse to write out a new file if it  would  change  the
#              history file's owner.
#       HIST_SAVE_NO_DUPS
#              When writing out the history file, older commands that duplicate newer ones are omitted.
#
#
#       HIST_VERIFY
#              Whenever the user enters a line with history expansion, don't execute the line directly;
#              instead, perform history expansion and reload the line into the editing buffer.
#
#
#       INC_APPEND_HISTORY
#              This option works like APPEND_HISTORY except that new history lines  are  added  to  the
#              $HISTFILE  incrementally  (as  soon  as they are entered), rather than waiting until the
#              shell exits.  The file will still be periodically re-written to trim it when the  number
#              of   lines   grows   20%   beyond  the  value  specified  by  $SAVEHIST  (see  also  the
#              HIST_SAVE_BY_COPY option).
#       INC_APPEND_HISTORY_TIME
#              This option is a variant of INC_APPEND_HISTORY in which, where possible, the history en‐
#              try  is written out to the file after the command is finished, so that the time taken by
#              the command is recorded correctly in the history file in EXTENDED_HISTORY format.   This
#              means  that  the history entry will not be available immediately from other instances of
#              the shell that are using the same history file.
#
#              This option is only useful if INC_APPEND_HISTORY and SHARE_HISTORY are turned off.   The
#              three options should be considered mutually exclusive.
#       SHARE_HISTORY <K>
#
#              This  option both imports new commands from the history file, and also causes your typed
#              commands to be appended to the history file  (the  latter  is  like  specifying  INC_AP‐
#              PEND_HISTORY,  which  should  be  turned  off if this option is in effect).  The history
#              lines are also output with timestamps ala EXTENDED_HISTORY (which  makes  it  easier  to
#              find the spot where we left off reading the file after it gets re-written).
#
#              By  default,  history  movement  commands  visit the imported lines as well as the local
#              lines, but you can toggle this on and off with the set-local-history zle binding.  It is
#              also  possible  to create a zle widget that will make some commands ignore imported com‐
#              mands, and some include them.
#
#              If you find that you want more control over when commands get imported, you may wish  to
#              turn  SHARE_HISTORY  off,  INC_APPEND_HISTORY or INC_APPEND_HISTORY_TIME (see above) on,
#              and then manually import commands whenever you need them using `fc -RI'.
#
#
#
#
#       GLOBAL_RCS (-d) <D>
#              If  this  option  is unset, the startup files /etc/zprofile, /etc/zshrc, /etc/zlogin and
#              /etc/zlogout will not be run.  It can be disabled and re-enabled at any time,  including
#              inside local startup files (.zshrc, etc.).
#      RCS (+f) <D>
#              After  /etc/zshenv  is sourced on startup, source the .zshenv, /etc/zprofile, .zprofile,
#              /etc/zshrc, .zshrc, /etc/zlogin, .zlogin, and .zlogout files, as described in  the  sec‐
#              tion  `Files'.   If this option is unset, the /etc/zshenv file is still sourced, but any
#              of the others will not be; it can be set at any time to prevent  the  remaining  startup
#              files after the currently executing one from being sourced.
#
#
#
#              
#       CLOBBER (+C, ksh: +C) <D>
#              Allows  `>' redirection to truncate existing files.  Otherwise `>!' or `>|' must be used
#              to truncate a file.
#
#              If the option is not set, and the option APPEND_CREATE is also not set, `>>!'  or  `>>|'
#              must be used to create a file.  If either option is set, `>>' may be used.
#
#       APPEND_CREATE <K> <S>
#              This option only applies when NO_CLOBBER (-C) is in effect.
#
#              If this option is not set, the shell will report an error when a append redirection (>>)
#              is  used  on  a  file  that  does  not  already exists (the traditional zsh behaviour of
#              NO_CLOBBER).  If the option is set, no error is reported (POSIX behaviour).
#
#       BASH_REMATCH
#              When set, matches performed with the =~ operator will set the BASH_REMATCH  array  vari‐
#              able,  instead  of  the  default  MATCH  and  match variables.  The first element of the
#              BASH_REMATCH array will contain the entire matched text  and  subsequent  elements  will
#              contain extracted substrings.  This option makes more sense when KSH_ARRAYS is also set,
#              so that the entire matched portion is stored at index 0 and the first  substring  is  at
#              index  1.   Without this option, the MATCH variable contains the entire matched text and
#              the match array variable contains substrings.
#
#       BSD_ECHO <S>
#              Make the echo builtin compatible with the BSD  echo(1)  command.   This  disables  back‐
#              slashed escape sequences in echo strings unless the -e option is specified.
#  
#       INTERACTIVE_COMMENTS (-k) <K> <S>
#              Allow comments even in interactive shells.
#
#
#
#
#
#       HASH_CMDS <D>
#              Note the location of each command the first time it is executed.  Subsequent invocations
#              of the same command will use the saved location, avoiding a path search.  If this option
#              is unset, no path hashing is done at all.  However, when CORRECT is set, commands  whose
#              names do not appear in the functions or aliases hash tables are hashed in order to avoid
#              reporting them as spelling errors.
#
#       HASH_DIRS <D>
#              Whenever a command name is hashed, hash the directory containing it, as well as all  di‐
#              rectories  that  occur earlier in the path.  Has no effect if neither HASH_CMDS nor COR‐
#              RECT is set.
#
#       HASH_EXECUTABLES_ONLY
#              When hashing commands because of HASH_CMDS, check that the file to be hashed is actually
#              an  executable.   This option is unset by default as if the path contains a large number
#              of commands, or consists of many remote files, the additional  tests  can  take  a  long
#              time.  Trial and error is needed to show if this option is beneficial.
#
#
#      MAIL_WARNING (-U)
#              Print a warning message if a mail file has been accessed since the shell last checked.
#
#
#
#
#
#       PATH_DIRS (-Q)
#              Perform  a  path  search  even on command names with slashes in them.  Thus if `/usr/lo‐
#              cal/bin' is in the user's path, and he or she types `X11/xinit', the  command  `/usr/lo‐
#              cal/bin/X11/xinit' will be executed (assuming it exists).  Commands explicitly beginning
#              with `/', `./' or `../' are not subject to the path search.  This also  applies  to  the
#              `.' and source builtins.
#
#              Note  that  subdirectories  of the current directory are always searched for executables
#              specified in this form.  This takes place before any search indicated  by  this  option,
#              and  regardless  of  whether  `.'  or the current directory appear in the command search
#              path.
#       PATH_SCRIPT <K> <S>
#              If this option is not set, a script passed as the first non-option argument to the shell
#              must  contain  the name of the file to open.  If this option is set, and the script does
#              not specify a directory path, the script is looked for first in the  current  directory,
#              then in the command path.  See the section INVOCATION in zsh(1).
#
#       PRINT_EIGHT_BIT
#              Print  eight bit characters literally in completion lists, etc.  This option is not nec‐
#              essary if your system correctly returns the printability of eight  bit  characters  (see
#              ctype(3)).
#
#
#       RC_QUOTES
#              Allow the character sequence `'''  to  signify  a  single  quote  within  singly  quoted
#              strings.   Note  this  does not apply in quoted strings using the format $'...', where a
#              backslashed single quote can be used.
#
#       RM_STAR_SILENT (-H) <K> <S>
#              Do not query the user before executing `rm *' or `rm path/*'.
#
#       RM_STAR_WAIT
#              If querying the user before executing `rm *' or `rm path/*', first wait ten seconds  and
#              ignore  anything  typed  in that time.  This avoids the problem of reflexively answering
#              `yes' to the query when one didn't really mean it.  The wait and  query  can  always  be
#              avoided by expanding the `*' in ZLE (with tab).
#
#
#       SHORT_LOOPS <C> <Z>
#              Allow the short forms of for, repeat, select, if, and function constructs.
#       AUTO_CONTINUE
#              With this option set, stopped jobs that are removed from the job table with  the  disown
#              builtin command are automatically sent a CONT signal to make them running.
#
#       AUTO_RESUME (-W)
#              Treat single word simple commands without redirection as candidates for resumption of an
#              existing job.
#
#
#       BG_NICE (-6) <C> <Z>
#              Run all background jobs at a lower priority.  This option is set by default.
#
#       CHECK_JOBS <Z>
#              Report the status of background and suspended jobs before exiting a shell with job  con‐
#              trol;  a second attempt to exit the shell will succeed.  NO_CHECK_JOBS is best used only
#              in combination with NO_HUP, else such jobs will be killed automatically.
#
#              The check is omitted if the commands run from  the  previous  command  line  included  a
#              `jobs'  command, since it is assumed the user is aware that there are background or sus‐
#              pended jobs.  A `jobs' command run from one of the hook functions defined in the section
#              SPECIAL FUNCTIONS in zshmisc(1) is not counted for this purpose.
#
#       CHECK_RUNNING_JOBS <Z>
#              Check  for both running and suspended jobs when CHECK_JOBS is enabled.  When this option
#              is disabled, zsh checks only for suspended jobs, which matches the default  behavior  of
#              bash.
#
#              This option has no effect unless CHECK_JOBS is set.
#       HUP <Z>
#              Send the HUP signal to running jobs when the shell exits.
#
#       LONG_LIST_JOBS (-R)
#              Print job notifications in the long format by default.
#
#       MONITOR (-m, ksh: -m)
#              Allow job control.  Set by default in interactive shells.
#
#       NOTIFY (-5, ksh: -b) <Z>
#              Report  the status of background jobs immediately, rather than waiting until just before
#              printing a prompt.
#  Prompting
#       PROMPT_BANG <K>
#              If set, `!' is treated specially in prompt expansion.  See EXPANSION OF PROMPT SEQUENCES
#              in zshmisc(1).
#
#       PROMPT_CR (+V) <D>
#              Print a carriage return just before printing a prompt in the line editor.  This is on by
#              default as multi-line editing is only possible if the editor knows where  the  start  of
#              the line appears.
#
#       PROMPT_SP <D>
#              Attempt  to  preserve  a partial line (i.e. a line that did not end with a newline) that
#              would otherwise be covered up by the command prompt due to the PROMPT_CR  option.   This
#              works  by  outputting some cursor-control characters, including a series of spaces, that
#              should make the terminal wrap to the next line when a partial line is present (note that
#              this is only successful if your terminal has automatic margins, which is typical).
#
#              When  a  partial line is preserved, by default you will see an inverse+bold character at
#              the end of the partial line:  a `%' for a normal user or a `#' for root.   If  set,  the
#              shell  parameter  PROMPT_EOL_MARK  can be used to customize how the end of partial lines
#              are shown.
#       PROMPT_PERCENT <C> <Z>
#              If set, `%' is treated specially in prompt expansion.  See EXPANSION OF PROMPT SEQUENCES
#              in zshmisc(1).
#
#       PROMPT_SUBST <K> <S>
#              If set, parameter expansion, command substitution and arithmetic expansion are performed
#              in prompts.  Substitutions within prompts do not affect the command status.
#
#       TRANSIENT_RPROMPT
#              Remove  any right prompt from display when accepting a command line.  This may be useful
#              with terminals with other cut/paste methods.
#
#
#
#       ALIAS_FUNC_DEF <S>
#              By default, zsh does not allow the definition of functions using the `name ()' syntax if
#              name was expanded as an alias: this causes an error.  This is usually the desired behav‐
#              iour, as otherwise the combination of an alias and a function based on the same  defini‐
#              tion can easily cause problems.
#
#              When this option is set, aliases can be used for defining functions.
#
#              For example, consider the following definitions as they might occur in a startup file.
#
#                     alias foo=bar
#                     foo() {
#                       print This probably does not do what you expect.
#                     }
#
#              Here,  foo  is expanded as an alias to bar before the () is encountered, so the function
#              defined would be named bar.  By default this is instead an error in native  mode.   Note
#              that  quoting  any  part of the function name, or using the keyword function, avoids the
#              problem, so is recommended when the function name can also be an alias.
#
#
#
#       DEBUG_BEFORE_CMD <D>
#              Run the DEBUG trap before each command; otherwise it is run after each command.  Setting
#              this  option mimics the behaviour of ksh 93; with the option unset the behaviour is that
#              of ksh 88.
#
#       ERR_EXIT (-e, ksh: -e)
#              If a command has a non-zero exit status, execute the ZERR trap, if set, and exit.   This
#              is disabled while running initialization scripts.
#
#              The  behaviour  is also disabled inside DEBUG traps.  In this case the option is handled
#              specially: it is unset on entry to the trap.  If the option DEBUG_BEFORE_CMD is set,  as
#              it  is  by  default, and the option ERR_EXIT is found to have been set on exit, then the
#              command for which the DEBUG trap is being executed is skipped.  The option  is  restored
#              after the trap exits.
#
#              Non-zero status in a command list containing && or || is ignored for commands not at the
#              end of the list.  Hence
#
#                     false && true
#
#              does not trigger exit.
#
#              Exiting due to ERR_EXIT has certain interactions with asynchronous  jobs  noted  in  the
#              section JOBS in zshmisc(1).
#
#
#       ERR_RETURN
#              If a command has a non-zero exit status, return immediately from the enclosing function.
#              The logic is similar to that for ERR_EXIT, except that an implicit return  statement  is
#              executed  instead  of  an  exit.   This will trigger an exit at the outermost level of a
#              non-interactive script.
#
#              Normally this option inherits the behaviour of ERR_EXIT that code followed by `&&'  `||'
#              does not trigger a return.  Hence in the following:
#
#                     summit || true
#
#              no return is forced as the combined effect always has a zero return status.
#
#              Note.  however, that if summit in the above example is itself a function, code inside it
#              is considered separately: it may force a return from summit (assuming the option remains
#              set  within  summit),  but  not from the enclosing context.  This behaviour is different
#              from ERR_EXIT which is unaffected by function scope.
#
#       CONTINUE_ON_ERROR
#              If  a fatal error is encountered (see the section ERRORS in zshmisc(1)), and the code is
#              running in a script, the shell will resume execution at the next statement in the script
#              at the top level, in other words outside all functions or shell constructs such as loops
#              and conditions.  This mimics the behaviour of interactive shells, where  the  shell  re‐
#              turns  to the line editor to read a new command; it was the normal behaviour in versions
#              of zsh before 5.0.1.
#
#
#
#       EVAL_LINENO <Z>
#              If set, line numbers of expressions evaluated using the builtin eval are  tracked  sepa‐
#              rately  of the enclosing environment.  This applies both to the parameter LINENO and the
#              line number output by the prompt escape %i.  If the option is set, the prompt escape  %N
#              will output the string `(eval)' instead of the script or function name as an indication.
#              (The two prompt escapes are typically used in the parameter PS4 to be  output  when  the
#              option  XTRACE  is  set.)   If  EVAL_LINENO is unset, the line number of the surrounding
#              script or function is retained during the evaluation.
#
#       EXEC (+n, ksh: +n) <D>
#              Do execute commands.  Without this option, commands are read and checked for syntax  er‐
#              rors,  but  not executed.  This option cannot be turned off in an interactive shell, ex‐
#              cept when `-n' is supplied to the shell at startup.
#
#
#
#
#
#
#
#
#       LOCAL_LOOPS
#              When  this  option  is  not set, the effect of break and continue commands may propagate
#              outside function scope, affecting loops in calling functions.  When the option is set in
#              a  calling  function,  a break or a continue that is not caught within a called function
#              (regardless of the setting of the option within that function) produces  a  warning  and
#              the effect is cancelled.
#
#       LOCAL_OPTIONS <K>
#              If  this  option  is set at the point of return from a shell function, most options (in‐
#              cluding this one) which were in force upon entry to the function are  restored;  options
#              that  are  not restored are PRIVILEGED and RESTRICTED.  Otherwise, only this option, and
#              the LOCAL_LOOPS, XTRACE and PRINT_EXIT_VALUE options are restored.  Hence if this is ex‐
#              plicitly  unset  by  a  shell function the other options in force at the point of return
#              will remain so.  A shell function can also guarantee itself a known shell  configuration
#              with a formulation like `emulate -L zsh'; the -L activates LOCAL_OPTIONS.
#
#       LOCAL_PATTERNS
#              If this option is set at the point of return from a shell function, the state of pattern
#              disables, as set with the builtin command `disable -p', is restored to what it was  when
#              the  function was entered.  The behaviour of this option is similar to the effect of LO‐
#              CAL_OPTIONS on options; hence `emulate -L sh' (or indeed any other emulation with the -L
#              option) activates LOCAL_PATTERNS.
#
#       LOCAL_TRAPS <K>
#              If  this  option  is  set when a signal trap is set inside a function, then the previous
#              status of the trap for that signal will be restored when the function exits.  Note  that
#              this  option  must be set prior to altering the trap behaviour in a function; unlike LO‐
#              CAL_OPTIONS, the value on exit from the function is irrelevant.  However,  it  does  not
#              need  to  be set before any global trap for that to be correctly restored by a function.
#              For example,
#
#                     unsetopt localtraps
#                     trap - INT
#                     fn() { setopt localtraps; trap '' INT; sleep 3; }
#
#              will restore normal handling of SIGINT after the function exits.
#
#
#
#
#
#
#              
#     MULTIOS <Z>
#              Perform  implicit tees or cats when multiple redirections are attempted (see the section
#              `Redirection').
#
#
#
#
#
#      PIPE_FAIL
#              By  default, when a pipeline exits the exit status recorded by the shell and returned by
#              the shell variable $? reflects that of the rightmost element of a pipeline.  If this op‐
#              tion is set, the exit status instead reflects the status of the rightmost element of the
#              pipeline that was non-zero, or zero if all elements exited with zero status.
#
#       SOURCE_TRACE
#              If set, zsh will print an informational message announcing the  name  of  each  file  it
#              loads.  The format of the output is similar to that for the XTRACE option, with the mes‐
#              sage <sourcetrace>.  A file may be loaded by the shell itself  when  it  starts  up  and
#              shuts down (Startup/Shutdown Files) or by the use of the `source' and `dot' builtin com‐
#              mands.
#
#       TYPESET_SILENT
#              If this is unset, executing any of the `typeset' family of commands with no options  and
#              a  list  of parameters that have no values to be assigned but already exist will display
#              the value of the parameter.  If the option is set, they will only be shown when  parame‐
#              ters are selected with the `-m' option.  The option `-p' is available whether or not the
#              option is set.
#
#       VERBOSE (-v, ksh: -v)
#              Print shell input lines as they are read.
#
#
#              
#       EMACS  If ZLE is loaded, turning on this option has the equivalent effect of `bindkey -e'.   In
#              addition,  the VI option is unset.  Turning it off has no effect.  The option setting is
#              not guaranteed to reflect the current keymap.  This option is provided  for  compatibil‐
#              ity; bindkey is the recommended interface.
#
#       OVERSTRIKE
#              Start up the line editor in overstrike mode.
#
#       SINGLE_LINE_ZLE (-M) <K>
#              Use single-line command line editing instead of multi-line.
#
#              Note  that  although this is on by default in ksh emulation it only provides superficial
#              compatibility with the ksh line editor and reduces the effectiveness of the zsh line ed‐
#              itor.   As  it has no effect on shell syntax, many users may wish to disable this option
#              when using ksh emulation interactively.
#
#       VI     If ZLE is loaded, turning on this option has the equivalent effect of `bindkey -v'.   In
#              addition,  the EMACS option is unset.  Turning it off has no effect.  The option setting
#              is not guaranteed to reflect the current keymap.  This option is provided  for  compati‐
#              bility; bindkey is the recommended interface.
#
#       ZLE (-Z)
#              Use the zsh line editor.  Set by default in interactive shells connected to a terminal.
#
#
#
#
#
#
#
#
#
#
#OPTION ALIASES
#       Some  options have alternative names.  These aliases are never used for output, but can be used
#       just like normal option names when specifying options to the shell.
#
#       BRACE_EXPAND
#              NO_IGNORE_BRACES (ksh and bash compatibility)
#
#       DOT_GLOB
#              GLOB_DOTS (bash compatibility)
#
#       HASH_ALL
#              HASH_CMDS (bash compatibility)
#
#       HIST_APPEND
#              APPEND_HISTORY (bash compatibility)
#
#       HIST_EXPAND
#              BANG_HIST (bash compatibility)
#
#       LOG    NO_HIST_NO_FUNCTIONS (ksh compatibility)
#
#       MAIL_WARN
#              MAIL_WARNING (bash compatibility)
#
#       ONE_CMD
#              SINGLE_COMMAND (bash compatibility)
#
#       PHYSICAL
#              CHASE_LINKS (ksh and bash compatibility)
#
#       PROMPT_VARS
#              PROMPT_SUBST (bash compatibility)
#
#       STDIN  SHIN_STDIN (ksh compatibility)
#
#       TRACK_ALL
#              HASH_CMDS (ksh compatibility)
#
#
#
#
#
#
#
#
#
#SINGLE LETTER OPTIONS
#   Default set
#       -0     CORRECT
#       -1     PRINT_EXIT_VALUE
#       -2     NO_BAD_PATTERN
#       -3     NO_NOMATCH
#       -4     GLOB_DOTS
#       -5     NOTIFY
#       -6     BG_NICE
#       -7     IGNORE_EOF
#       -8     MARK_DIRS
#       -9     AUTO_LIST
#       -B     NO_BEEP
#       -C     NO_CLOBBER
#       -D     PUSHD_TO_HOME
#       -E     PUSHD_SILENT
#       -F     NO_GLOB
#       -G     NULL_GLOB
#       -H     RM_STAR_SILENT
#       -I     IGNORE_BRACES
#       -J     AUTO_CD
#       -K     NO_BANG_HIST
#       -L     SUN_KEYBOARD_HACK
#       -M     SINGLE_LINE_ZLE
#       -N     AUTO_PUSHD
#       -O     CORRECT_ALL
#       -P     RC_EXPAND_PARAM
#       -Q     PATH_DIRS
#       -R     LONG_LIST_JOBS
#       -S     REC_EXACT
#       -T     CDABLE_VARS
#       -U     MAIL_WARNING
#       -V     NO_PROMPT_CR
#       -W     AUTO_RESUME
#       -X     LIST_TYPES
#       -Y     MENU_COMPLETE
#       -Z     ZLE
#       -a     ALL_EXPORT
#       -e     ERR_EXIT
#       -f     NO_RCS
#       -g     HIST_IGNORE_SPACE
#       -h     HIST_IGNORE_DUPS
#       -i     INTERACTIVE
#       -k     INTERACTIVE_COMMENTS
#       -l     LOGIN
#       -m     MONITOR
#       -n     NO_EXEC
#       -p     PRIVILEGED
#       -r     RESTRICTED
#       -s     SHIN_STDIN
#       -t     SINGLE_COMMAND
#       -u     NO_UNSET
#       -v     VERBOSE
#       -w     CHASE_LINKS
#       -x     XTRACE
#       -y     SH_WORD_SPLIT
#
#   sh/ksh emulation set
#       -C     NO_CLOBBER
#       -T     TRAPS_ASYNC
#       -X     MARK_DIRS
#       -a     ALL_EXPORT
#       -b     NOTIFY
#       -e     ERR_EXIT
#       -f     NO_GLOB
#       -i     INTERACTIVE
#       -l     LOGIN
#       -m     MONITOR
#       -n     NO_EXEC
#       -p     PRIVILEGED
#       -r     RESTRICTED
#       -s     SHIN_STDIN
#       -t     SINGLE_COMMAND
#       -u     NO_UNSET
#       -v     VERBOSE
#       -x     XTRACE
#
#   Also note
#       -A     Used by set for setting arrays
#       -b     Used on the command line to specify end of option processing
#       -c     Used on the command line to specify a single command
#       -m     Used by setopt for pattern-matching option setting
#       -o     Used in all places to allow use of long option names
#       -s     Used by set to sort positional parameters

