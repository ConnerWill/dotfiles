## Arduino plugin -  Very WIP - you've been warned

Build, upload and monitor arduino sketches from zsh. Reuses `.vscode/arduino.json` if available else you can set env vars.

## Usage

1. In a sketch folder, run `ar_build`
- If you have `.vscode/arduino.json`, then all flags - esp `fqbn` is pulled in from there.
2. Setting compile time vars
-  `ar_build stm32-nrf24tx02.ino --build-properties='compiler.cpp.extra_flags=-DDEBUG`
3. You can just run `ar_upload` directly - if a binary (`AR_BIN`) isn't set, then it will build & upload
- to force build, use `ar_build; ar_upload`



### Needs
1. [arduino-cli](https://github.com/arduino/arduino-cli)
2. `jq` - sudo apt install jq

### Setup

#### zplug

* `zplug "raghur/zsh-arduino"`

#### Manual - Git
1. clone this somewhere in your $FPATH
2. Source `plugin.zsh` from your startup scripts
2. In your sketch folder, following are available
    - `ar_build`, `ar_upload`, `ar_env`, `ar_serial`

