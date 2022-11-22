11


Hires (floating point) progress bar
Preamble
Sorry for this not so short answer. In this answer I will use integer to render floating point, UTF-8 fonts for rendering progress bar more finely, and parallelise another task (sha1sum) in order to follow his progression, all of this with minimal resource footprint using pure bash and no forks.

For impatiens: Please test code (copy/paste in a new terminal window) at Now do it! (in the middle), with

either: Last animated demo (near end of this.),
either Practical sample (at end).
All demos here use read -t <float seconds> && break instead of sleep. So all loop could be nicely stopped by hitting Return key.

Introduction
Yet Another Bash Progress Bar...

As there is already a lot of answer here, I want to add some hints about performances and precision.

1. Avoid forks!
Because a progress bar are intented to run while other process are working, this must be a nice process...

So avoid using forks when not needed. Sample: instead of

mysmiley=$(printf '%b' \\U1F60E)
Use

printf -v mysmiley '%b' \\U1F60E
Explanation: When you run var=$(command), you initiate a new process to execute command and send his output to variable $var once terminated. This is very resource expensive. Please compare:

TIMEFORMAT="%R"
time for ((i=2500;i--;)){ mysmiley=$(printf '%b' \\U1F60E);}
2.292
time for ((i=2500;i--;)){ printf -v mysmiley '%b' \\U1F60E;}
0.017
bc -l <<<'2.292/.017'
134.82352941176470588235
On my host, same work of assigning $mysmiley (just 2500 time), seem ~135x slower / more expensive by using fork than by using built-in printf -v.

Then

echo $mysmiley 
😎
So your function have to not print (or output) anything. Your function have to attribute his answer to a variable.

2. Use integer as pseudo floating point
Here is a very small and quick function to compute percents from integers, with integer and answer a pseudo floating point number:

percent(){
    local p=00$(($1*100000/$2))
    printf -v "$3" %.2f ${p::-3}.${p: -3}
}
Usage:

# percent <integer to compare> <reference integer> <variable name>
percent 33333 50000 testvar
printf '%8s%%\n' "$testvar"
   66.67%
3. Hires console graphic using UTF-8: ▏ ▎ ▍ ▌ ▋ ▊ ▉ █
To render this characters using bash, you could:

printf -v chars '\\U258%X ' {15..8}
printf "$chars\\n"
▏ ▎ ▍ ▌ ▋ ▊ ▉ █ 
Then we have to use 8x string with as graphic width.

Now do it!
This function is named percentBar because it render a bar from argument submited in percents (floating):

percentBar ()  { 
    local prct totlen=$((8*$2)) lastchar barstring blankstring;
    printf -v prct %.2f "$1"
    ((prct=10#${prct/.}*totlen/10000, prct%8)) &&
        printf -v lastchar '\\U258%X' $(( 16 - prct%8 )) ||
            lastchar=''
    printf -v barstring '%*s' $((prct/8)) ''
    printf -v barstring '%b' "${barstring// /\\U2588}$lastchar"
    printf -v blankstring '%*s' $(((totlen-prct)/8)) ''
    printf -v "$3" '%s%s' "$barstring" "$blankstring"
}
Usage:

# percentBar <float percent> <int string width> <variable name>
percentBar 42.42 $COLUMNS bar1
echo "$bar1"
█████████████████████████████████▉                                              
To show little differences:

percentBar 42.24 $COLUMNS bar2
printf "%s\n" "$bar1" "$bar2"
█████████████████████████████████▉                                              
█████████████████████████████████▊                                              
With colors
As rendered variable is a fixed widht string, using color is easy:

percentBar 72.1 24 bar
printf 'Show this: \e[44;33;1m%s\e[0m at %s%%\n' "$bar" 72.1
Bar with color

Little animation:
for i in {0..10000..33} 10000;do i=0$i
    printf -v p %0.2f ${i::-2}.${i: -2}
    percentBar $p $((COLUMNS-9)) bar
    printf '\r|%s|%6.2f%%' "$bar" $p
    read -srt .002 _ && break    # console sleep avoiding fork
done

|███████████████████████████████████████████████████████████████████████|100.00%

clear; for i in {0..10000..33} 10000;do i=0$i
     printf -v p %0.2f ${i::-2}.${i: -2}
     percentBar $p $((COLUMNS-7)) bar
     printf '\r\e[47;30m%s\e[0m%6.2f%%' "$bar" $p
     read -srt .002 _ && break
done
PercentBar animation

Last animated demo
Another demo showing different sizes and colored output:

printf '\n\n\n\n\n\n\n\n\e[8A\e7'&&for i in {0..9999..99} 10000;do 
    o=1 i=0$i;printf -v p %0.2f ${i::-2}.${i: -2}
    for l in 1 2 3 5 8 13 20 40 $((COLUMNS-7));do
        percentBar $p $l bar$((o++));done
    [ "$p" = "100.00" ] && read -rst .8 _;printf \\e8
    printf '%s\e[48;5;23;38;5;41m%s\e[0m%6.2f%%%b' 'In 1 char width: ' \
        "$bar1" $p ,\\n 'with 2 chars: ' "$bar2" $p ,\\n 'or 3 chars: ' \
        "$bar3" $p ,\\n 'in 5 characters: ' "$bar4" $p ,\\n 'in 8 chars: ' \
        "$bar5" $p .\\n 'There are 13 chars: ' "$bar6" $p ,\\n '20 chars: '\
        "$bar7" $p ,\\n 'then 40 chars' "$bar8" $p \
        ', or full width:\n' '' "$bar9" $p ''
    ((10#$i)) || read -st .5 _; read -st .1 _ && break
done
Could produce something like this:

Last animation percentBar animation

Practical GNU/Linux sample: sha1sum with progress bar
Under linux, you could find a lot of usefull infos under /proc pseudo filesystem, so using previoulsy defined functions percentBar and percent, here is sha1progress:

percent(){ local p=00$(($1*100000/$2));printf -v "$3" %.2f ${p::-3}.${p: -3};}
sha1Progress() { 
    local -i totsize crtpos cols=$(tput cols) sha1in sha1pid
    local sha1res percent prctbar
    exec {sha1in}< <(exec sha1sum -b - <"$1")
    sha1pid=$!
    read -r totsize < <(stat -Lc %s "$1")
    while ! read -ru $sha1in -t .025 sha1res _; do
        read -r _ crtpos < /proc/$sha1pid/fdinfo/0
        percent $crtpos $totsize percent
        percentBar $percent $((cols-8)) prctbar
        printf '\r\e[44;38;5;25m%s\e[0m%6.2f%%' "$prctbar" $percent;

    done
    printf "\r%s  %s\e[K\n" $sha1res "$1"
}
Of course, 25 ms timeout mean approx 40 refresh per second. This could look overkill, but work fine on my host, and anyway, this can be tunned.

sha1Progress sample

Explanation:

exec {sha1in}< create a new file descriptor for the output of
<( ... ) forked task run in background
sha1sum -b - <"$1" ensuring input came from STDIN (fd/0)
while ! read -ru $sha1in -t .025 sha1res _ While no input read from subtask, in 25 ms...
/proc/$sha1pid/fdinfo/0 kernel variable showing information about file descriptor 0 (STDIN) of task $sha1pid
Share
Improve this answer
Follow
edited Jun 15 at 6:31
