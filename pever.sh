#!/bin/bash
while getopts a:p:P: flag
do
    case "${flag}" in
        a) HOST_ADDRESS=${OPTARG};;
        p) port=${OPTARG};;
        P) PASSWORD=${OPTARG};;
    esac
done

if [ $port == ""]
then
    port=22
fi

USERNAME=(${HOST_ADDRESS//@/ })
USERNAME=${USERNAME[0]}

echo -n -e '\033[0;92m' "-> Enter your name : "
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
    echo -ne '\033[0m' ""
    echo -e '\033[0;92m' "-> Pewering up with homie at ${HOST_ADDRESS} B|"
    sleep 0.5
    echo "Send '/help' as message to view available commands"
    listen&
    while [ true ]
    do
        echo -n -e '\033[0;92m' "-> Message enter cheyyu: "
        echo -e '\033[0m' " \r"
        read msg
        
        echo "$uname : $msg" >> mes.txt
        echo "$uname : $msg" | sshpass -p "${PASSWORD}" ssh -o StrictHostKeyChecking=no -p "${port}" "${HOST_ADDRESS}" -T "cat >> /home/${USERNAME}/mes.txt && exit"


    done
}


FILE=./mes
if test -f "$FILE"; then

    rmsg
else
    #touch mes
    rmsg
fi