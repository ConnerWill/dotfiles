function copysshkeypublic(){
    clear
    local PREVIOUSUSERHOMEDIR="$HOME"
    echo "Copying SSH public key"
	xclip -sel clip < "$PREVIOUSUSERHOMEDIR/.ssh/id_rsa.pub"
	clear
	cat "$PREVIOUSUSERHOMEDIR/.ssh/id_rsa.pub"

}

function copysshkeyprivate(){
    clear
    local PREVIOUSUSERHOMEDIR="$HOME"
    sudo --reset-timestamp --prompt "Enter password to copy SSH private key: " echo "Copying SSH private key"
	xclip -sel clip < "$PREVIOUSUSERHOMEDIR/.ssh/id_rsa"
	clear
	cat "$PREVIOUSUSERHOMEDIR/.ssh/id_rsa"

}


