#!/bin/bash
source config.sh
port=22
while getopts p:P: flag
do
    case "${flag}" in
        p) port=${OPTARG};;
        P) age=${OPTARG};;
    esac
done


echo -n -e '\033[0;92m' "-> Enter your name : "
echo -e '\033[0m' ' \r'
read uname
listen () {
    while [ true ]
    do
        touch -d"-1sec" .tmp
        [ "mes.txt" -nt .tmp ] && echo -e '\033[0m' " \r" && tail -5 mes.txt && echo -e '\033[0;92m' ">> Enter your message : "
        sleep 0.9
    done
}

show_help () {
    echo "/clear : Destroys previous messages"
}
rmsg () {
    echo -n -e '\033[0;92m' "-> PID : "
    echo -ne '\033[0m' ""
    read pid
    echo -e '\033[0;92m' "-> Pewering up with homie at ${HOST_ADDRESS}${pid} B|"
    sleep 0.5
    echo "Send '/help' as message to view available commands"
    listen&
    while [ true ]
    do
        echo -n -e '\033[0;92m' "-> Message enter cheyyu: "
        echo -e '\033[0m' " \r"
        read msg
        if [msg == "/help"]
            do
                show_help
            done
        
        echo "$uname : $msg" >> mes.txt
        echo "$uname : $msg" | sshpass -p "${PASSWORD}" ssh -o StrictHostKeyChecking=no "${USERNAME}"@"${HOST_ADDRESS}${pid}" -T "cat >> /home/${USERNAME}/mes.txt && exit"


    done
}


FILE=./mes
if test -f "$FILE"; then

    rmsg
else
    #touch mes
    rmsg
fi