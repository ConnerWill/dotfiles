<div align="center">
  
# AwesomeWM
  
</div>

  
`AwesomeWM` is a highly-configurable "framework" window manager.

`Awesome`'s configuration files are written in `Lua` and come with multiple libraries for things like notifications, theming, and creating widgets/bars.

Although it is true that you can create just about any look or feel you want with `Awesome`, it comes with a steep learning curve.



# Installation

> Install on `ArchLinux`
```shell
sudo pacman -S --needed awesome
```

> Install on `Debian` based distros
```shell
sudo apt install awesome
```

> See (https://awesomewm.org/download) for more information on installing AwesomeWM.


# Configuration

Configuration is traditionally done via a configuration file called `rc.lua`.

This file should be saved in your `~/.config` directory
: `$XDG_CONFIG_HOME/awesome/rc.lua`

With complex setups, it's easier to maintain separate files and folders with more specific jobs compared to once large configuration file.


In my setup, I will have:

<!--
*[`lain/`](/.config/awesome/): very useful external library
-->
* [`themes/`](/.config/awesome/themes): Themes directory containing theme files
* [`autostart.sh`](/.config/awesome/autostart.sh): Programs to startup with awesome
* [`buttons.lua`](/.config/awesome/buttons.lua): Mouse button configuration
* [`hotkeys.lua`](/.config/awesome/hotkeys.lua): Keyboard shortcuts
* [`helpers.lua`](/.config/awesome/helpers.lua): Useful functions
* [`rc.lua`](/.config/awesome/rc.lua): All other files are sourced from inside this root configuration file

# Documentation

* [AwesomeWM Homepage](https://awesomewm.org)
* [AwesomeWM API documentation](https://awesomewm.org/doc/api)
