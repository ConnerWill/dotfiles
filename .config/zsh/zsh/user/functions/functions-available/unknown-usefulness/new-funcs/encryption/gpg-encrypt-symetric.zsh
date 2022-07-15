
ERRORMSG_ALERT='\e[1m\e[37m\e[41m ERROR \e[0m'
WARNINGMSG_ALERT='\e[1m\e[33m\e[44m WARNING \e[0m'
VERBOSEMSG_ALERT='\e[1m\e[32m\e[30m VERBOSE \e[0m'
VARIABLECOLOR='\e[1m\e[36m'
SUCCESS_ALERT='\e[1;40;42m COMPLETE \e[0m'
RESETNORMAL='\e[0m'
STANDARD_ALERT='\e[33m'

# to encrypt
function gpg_encrypt_symmetric(){

  INPUTFILE="$1"

  [[ -z "$INPUTFILE" ]] \
    && _gpg_encrypt_errormsg "Did not receive input file to encrypt :(" "$0" && return

  ENCRYPTED_FILENAME="$INPUTFILE.gpg"

  gpg \
    --symmetric \
      --cipher-algo aes256 \
      --digest-algo sha512 \
      --cert-digest-algo sha512 \
      --s2k-digest-algo sha512 \
        --s2k-mode 3 \
        --s2k-count 65011712 \
          --compress-algo none -z 0 \
            --force-mdc \
              --pinentry-mode loopback \
                --armor \
                  --no-symkey-cache \
                    --verbose \
    --output "$ENCRYPTED_FILENAME" \
}

# to decrypt
function gpg_decrypt_symmetric(){

  INPUTFILE="$1"
  OUTFILE="$2"

  [[ -z "$INPUTFILE" ]] \
    && _gpg_decrypt_errormsg "Did not receive input file to decrypt :(" "$0" && return  

  [[ -z "$OUTFILE" ]] \
    && _gpg_decrypt_errormsg "Did not receive output file name to save decrypted contents :,(" && return 

  gpg \
    --decrypt \
      --pinentry-mode loopback \
        --armor \
         --verbose \
          --output  \
          "$OUTFILE"
}

function _gpg_encrypt_errormsg(){
    local _RECEIVED_ERROR_MSG="$1"
    local _SENDING_FUNCTION="$2"
    echo -e "\e[1;38;5;15m——————————————————————————————————————————————————————————\e[0m"
    echo -e "${ERRORMSG_ALERT}\t\e[1;38;5;124m$_RECEIVED_ERROR_MSG\e[0m" 
    echo -e "\e[1;38;5;15m——————————————————————————————————————————————————————————\e[0m"
    echo -e "\e[1;4;34mUSAGE\e[0m:\n\t\e[32m\e[0m  \e[33m$_SENDING_FUNCTION\e[0m\e[38;5;247m $NoInputHelpmsg <INPUTFILE>\e[0m\n"
	echo -e "\e[1;4;34mEXAMPLES\e[0m:\n"
    echo -e "\t\e[32m\$\e[0m  \e[33m$_SENDING_FUNCTION\e[0m\e[38;5;247m ~/Top-Secret.txt\e[0m\n\n\t\t\e[38;5;8m\e[3mTop-Secret.txt.gpg\e[0m\n"
	echo -e "\t\e[32m\$\e[0m  \e[33m$_SENDING_FUNCTION\e[0m\e[38;5;247m Granny-Porn-RelativePath.png\e[0m\n\n\t\t\e[38;5;8m\e[3mGranny-Porn-RelativePath.png.gpg\e[0m\n"
	echo -e "\t\e[32m\$\e[0m  \e[33m$_SENDING_FUNCTION\e[0m\e[38;5;247m $HOME/LiNkiNgPark-nUmB69.mp3.exe\e[0m\n\n\t\t\e[38;5;8m\e[3m$HOME/LiNkiNgPark-nUmB69.mp3.exe.gpg\e[0m"
    echo -e "\e[1;38;5;15m——————————————————————————————————————————————————————————\e[0m\n"

}


function _gpg_decrypt_errormsg(){
    local _RECEIVED_ERROR_MSG="$1"
    local _SENDING_FUNCTION="$2"
    echo -e "\e[1;38;5;15m——————————————————————————————————————————————————————————\e[0m"
    echo -e "${ERRORMSG_ALERT}\t\e[1;38;5;124m$_RECEIVED_ERROR_MSG\e[0m"
    echo -e "\e[1;38;5;15m——————————————————————————————————————————————————————————\e[0m"
	echo -e "\e[1;4;34mUSAGE\e[0m:\n\t\e[32m\e[0m  \e[33m$_SENDING_FUNCTION\e[0m\e[38;5;247m <INPUTFILE> <OUTPUTFILE>\e[0m\n"
	echo -e "\e[1;4;34mEXAMPLES\e[0m:\n"
    echo -e "\t\e[32m\$\e[0m  \e[33m$_SENDING_FUNCTION\e[0m\e[38;5;247m ~/Top-Secret.txt.gpg ~/Boring-Stuff.txt\e[0m\n\n\t\t\e[38;5;8m\e[3m$HOME/Boring-Stuff.txt\e[0m\n"
	echo -e "\t\e[32m\$\e[0m  \e[33m$_SENDING_FUNCTION\e[0m\e[38;5;247m Granny-Porn-RelativePath.png.gpg MySecrets.txt\e[0m\n\n\t\t\e[38;5;8m\e[3mMySecrets.txt\e[0m\n"
	echo -e "\t\e[32m\$\e[0m  \e[33m$_SENDING_FUNCTION\e[0m\e[38;5;247m $HOME/LiNkiNgPark-nUmB69.mp3.exe.gpg $HOME/LiNkiNgPark-nUmB69.mp3.exe\e[0m\n\n\t\t\e[38;5;8m\e[3m$HOME/LiNkiNgPark-nUmB69.mp3.exe\e[0m"
    echo -e "\e[1;38;5;15m——————————————————————————————————————————————————————————\e[0m\n"
}



alias gpg-encrypt-symmetric="gpg_encrypt_symmetric"
alias gpg-decrypt-symmetric="gpg_decrypt_symmetric"

