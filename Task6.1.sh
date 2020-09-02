#!/bin/bash

manual(){
        cat << EOF
This script erase empty strings and converts text to uppercase
EOF
}

W=0 #for writing in files or not
while [[ $# > 0 ]]
do
        case $1 in
                --help)
                        manual
                        exit 0
                ;;
                -w|-write)
                        W=1
                ;;
                *)
                        if [[ -f $1|| -h $1 ]]
                        then
                                FILES+=($1)
                        else
                                WRONGS+=($1)
                        fi
                ;;
        esac
        shift
done

if [[ ${#WRONGS[@]} == 0 ]]
then
        for file in $FILES
        do
                if [ $W == 0 ]
                then
                        sed '/^$/d' $file | tr 'a-z' 'A-Z'
                else
                        sed '/^$/d' $file | tr 'a-z' 'A-Z' > file_tmp
                        cat file_tmp > $file
                        rm file_tmp
                fi
        done
else
        echo 'There is error parametrs: '${WRONGS[@]}
        exit 1
fi
exit 0
