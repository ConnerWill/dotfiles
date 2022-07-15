#!/bin/env bash
# Autonomous system subnets


function get-subnets-of-ASN(){

local HELPMSG="\
\e[1;38;5;15m—————————————————————————————————————————————————\e[0m
  \e[1;4;38;5;27mNAME\e[0m:\n\n\
\t\e[38;5;15m$0\e[0m\n\n\
  \e[1;4;38;5;27mDESCRIPTION\e[0m:\n\n\
\t\e[38;5;15mGet all subnets for specific \e[1;38;5;15mAS\e[0m \e[2;3;38;5;8m(Autonomous system)\e[0m \n\n\
  \e[1;4;38;5;27mUSAGE\e[0m: \n\n\
\t\e[38;5;34m\$\e[0m  \e[38;5;15m$0\e[0m \e[2;3;38;5;250m[\e[2;3;38;5;247mASN\e[0m\e[2;3;38;5;250m] \n\n\
\e[1;38;5;15m—————————————————————————————————————————————————\e[0m"

    local AS="$1"
    [[ "$AS" == "-h" ]] || [[ "$AS" == "--help" ]] && echo "$HELPMSG"
    [[ -z "$AS" ]] && local AS="AS32934" # Random ASN

    whois \
           -h whois.radb.net -- \
             "-i origin ${AS}"   \
                                  | grep "^route:"\
                                                   \
                                                   | cut \
                                                      -d ":" \
                                                      -f2     \
                                                               \
                                                                | sed \
                                                                 -e 's/^[ \t]//'\
                                                                                | sort  \
                                                                                  -n     \
                                                                                   -t .   \
                                                                                    -k 1,1 \
                                                                                     -k 2,2 \
                                                                                      -k 3,3 \
                                                                                       -k 4,4 \
                                                                                               \
                                                                                               | cut    \
                                                                                                  -d ":" \
                                                                                                   -f2    \
                                                                                                          | sed \
                                                                                                             -e 's/^[ \t]/allow /' \
                                                                                                                                   | sed 's/$/;/' \
                                                                                                                                                  | sed 's/allow  */subnet -> /g'
}
