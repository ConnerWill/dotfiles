# zprofile

## Install
### [zgem](https://github.com/qoomon/zgem)
```zgem bundle 'https://github.com/qoomon/zprofile.git' from:'git' use:'zprofile.zsh'```
### manually
```
git clone https://github.com/qoomon/zprofile.git
source zprofile/zprofile.zsh
```

## Usage
### Prepare .zshrc
```
if [ "$ZPROFILE" = 'active' ] ; then zprofile::before; fi

# SCRIPT TO PROFILE 
# ...

if [ "$ZPROFILE" = 'active' ] ; then zprofile::after; fi
```

| command                   |
|---                        |
|`zprofile`                 |
|`zprpfile benchmark`       |
|`zprofile <FUNCTION_CALL>` |
