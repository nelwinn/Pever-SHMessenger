#!/bin/bash
source config.sh

echo -e '\033[0;92m' "-> Enter your name : "
echo -e '\033[0m' ' \r'
read uname
listen () {
    while [ true ]
    do
        touch -d"-1sec" .tmp
        [ "mes" -nt .tmp ] && echo -e '\033[0m' " \r" && tail -5 mes && echo -e '\033[0;92m' ">> Enter your message : "
        sleep 0.9    
    done
}
rmsg () {
    echo -e '\033[0;92m' "-> PID : "
    echo -ne '\033[0m' ""
    read pid
    echo -e '\033[0;92m' "-> Pewering up with homie at ${HOST_ADDRESS}${pid} B|"
    listen&
    while [ true ]
    do
        echo -e '\033[0;92m' "-> Enter your message : "
        echo -e '\033[0m' " \r"
        read msg
        echo "$uname : $msg" >> mes
        echo "$msg" | ssh exam1@"${HOST_ADDRESS}${pid}" -T "cat > /home/exam1/mes.txt"&


    done
}


FILE=./mes
if test -f "$FILE"; then

    rmsg
else
    touch mes
    rmsg
fi
