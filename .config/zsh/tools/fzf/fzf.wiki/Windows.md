Pre-built binaries for Windows can be downloaded [here][bin]. However, other
components of the project do not work on Windows. You might want to consider
installing fzf on [Windows Subsystem for Linux][wsl] where everything runs
flawlessly.

[bin]: https://github.com/junegunn/fzf/releases
[wsl]: https://blogs.msdn.microsoft.com/wsl/

### No `--height` support before 0.21.0

Windows binary does not support `--height` option which is used to start fzf in non-fullscreen mode.

### fzf outputs `character set not supported` when `TERM` environment variable is set

`TERM` must be unset to run on the terminal. cmd.exe, powershell, and the default Windows terminal do not set it. Windows-specific terminal emulators like ConEmu do not set TERM. fzf unsets `TERM` only when running on bash with `TERM=cygwin` so fzf fails on mintty since it uses `TERM=xterm` or `TERM=xterm-256color`.

- https://github.com/junegunn/fzf/issues/963
- https://github.com/junegunn/fzf/issues/1093
- https://github.com/junegunn/fzf.vim/issues/677

### fzf uses `cmd.exe` to start `FZF_DEFAULT_COMMAND`

Even if you're on Cygwin, fzf will use `cmd.exe` (instead of `sh`) to start `FZF_DEFAULT_COMMAND`.

### Absolute Filepaths

Set `FZF_DEFAULT_COMMAND` to `dir /s/b`. This is fzf's default command before https://github.com/junegunn/fzf/pull/1200.

### Relative Filepaths

If not using cmd.exe builtins, take note of https://github.com/golang/go/issues/17608. fzf does not cleanup child processes on Windows.

Set `FZF_DEFAULT_COMMAND` to any of the following:

- powershell https://github.com/junegunn/fzf/issues/960
  ```dosbatch
  powershell.exe -NoLogo -NoProfile -Noninteractive -Command "Get-ChildItem -File -Recurse -Name"
  ```
- [sift](https://sift-tool.org/)
  ```dosbatch
  sift --targets . 2> nul
  ```
- [rg](https://github.com/BurntSushi/ripgrep) (supports UTF-16 as of [0.5.0](https://github.com/BurntSushi/ripgrep/blob/master/CHANGELOG.md#050-2017-03-12))
  ```dosbatch
  rg --files . 2> nul
  ```

### PowerShell support
https://github.com/kelleyma49/PSFzf


### Windows Prompt(cmd) and MSYS2
https://github.com/jesse23/with


### Windows wrapper for fzf
https://github.com/genotrance/ff

### Integration with Clink
https://github.com/chrisant996/clink-fzf