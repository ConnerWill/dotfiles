#!/bin/env bash
# vim:filetype=sh:shiftwidth=2:softtabstop=2:expandtab:foldmethod=marker:foldmarker=###{{{,###}}}

typeset -il f x s
typeset -il w
typeset -al v

f=80 s=15 r=2000 t=0 c=1 n=0 l=0
w=$(tput cols) h=$(tput lines)
x=$(( w/2 )) y=$(( h/2 ))
v=( [00]="\x83" [01]="\x8f" [03]="\x93" [10]="\x9b" [11]="\x81" [12]="\x93" [21]="\x97" [22]="\x83" [23]="\x9b" [30]="\x97" [32]="\x8f" [33]="\x81" )



helpmenu(){

cat <<HELPMENU

NAME

  pipes


DESCRIPTION

  Fancy Animated pipes terminal screensaver


USAGE

  pipes [OPTIONS]..."


OPTIONS

  -f|--framerate INT    Framerate (20-100) (Default:${f})
  -p|--straight  INT    Probability of a straight fitting (5-50) (Default:15)
  -r|--reset LIMIT      Reset after n characters (Default:2000)
  -h|--help             Show help

HELPMENU

}



OPTIND=1
while getopts "f:s:r:h" arg; do
  case $arg in
    f*|-f*) (( f=( OPTARG > 19 && OPTARG < 101 ) ?OPTARG:f )) ;;
    *|-s*) (( s=( OPTARG >  4 && OPTARG < 50  ) ?OPTARG:s )) ;;
    r*|-r*) (( r=( OPTARG >  0                 ) ?OPTARG:r )) ;;
    h*) helpmenu; exit 0                             ;;
  esac
done

# tput smcup
# tput reset
# tput civis

while ! read -rt0.0$(( 1000 / f )) -n1; do

    # New position:
    ((   l % 2  )) && (( x+=(l==1) ?1:-1 ))
    (( !(l % 2) )) && (( y+=(l==2) ?1:-1 ))

    # Loop on edges (change color on loop):
    (( c=(x>w || x<0 || y>h || y<0)?(RANDOM%7-1):c ))
    (( x=(x>w)?0:(( x<0)? w:x )))
    (( y=(y>h)?0:(( y<0)? h:y )))

    # New random direction:
    (( n=RANDOM % s - 1 ))
    (( n=(n>1||n==0)?l:l+n ))
    (( n=(n<0)?3:n%4 ))

    # Print:
    tput cup $y $x
    echo -ne "\033[1;3${c}m\xe2\x94${v[$l$n]}"
    (( t>r )) \
      && tput reset && tput civis && t=0 \
      || (( t++ ))

    l=$n

done

# tput rmcup


# vim:filetype=sh:shiftwidth=2:softtabstop=2:expandtab:foldmethod=marker:foldmarker=###{{{,###}}}
