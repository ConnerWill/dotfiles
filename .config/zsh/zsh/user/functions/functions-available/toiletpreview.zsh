function toiletpreview(){
  cd /usr/share/figlet/fonts && for lll in * ; do echo "$lll" ; toilet --gay --termwidth --filter border -f $lll $lll 2>/dev/null; done && cd $OLDPWD
}
