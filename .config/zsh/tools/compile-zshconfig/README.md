# Compile ZSH configuration to one file

---

First, you need to edit `.zshrc` and define the variable `_ZSH_LOAD_VERBOSE`

```bash
_ZSH_LOAD_VERBOSE=1
```

---

Now you will write the xtrace to a file

```bash
zsh -l &> zsh.log
```

---

After the command has completed, you will need to exit that session of zsh (it may not seem like you are in a new zsh session, but you are)

```bash
exit
```

---

Now we will compile the files called in zsh startup to one file

```bash
grep --extended-regexp --regexp='^\+\/.*' zsh.log \
  | cut -d':' -f1                                 \
    | cut -d'+' -f2                               \
      | sort                                      \
        | uniq                                    \
          | xargs -I{} cat {} >> combined.zsh
```

Same command as above but one line

```bash
grep --extended-regexp --regexp='^\+\/.*' zsh.log | cut -d':' -f1 | cut -d'+' -f2 | sort | uniq | xargs -I{} cat {} >> combined.zsh
```

---

Now you will edit `.zshrc` and remove definition to `_ZSH_LOAD_VERBOSE` and define the variable `_INHERIT_ENV`. This will prevent running startup files. Restart your shell

```bash
_INHERIT_ENV=1
```


```bash
exec zsh
```

Notice how you do not have a fancy prompt or any completion?

---

Now we will source the compiled file we created

```bash
source combined.zsh
```

There might be a few errors, but it should work correctly :)

---
