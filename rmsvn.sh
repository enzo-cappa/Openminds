#!/bin/sh

borrarsvn () {
 IFS=$'\n'
    for dir in $(ls -a -1 "$1");
    do
	echo $dir
        if [ -d "$dir" ];
        then
            if [ "$dir" = ".svn" ];
            then
                echo "rm -rf $dir"
            else
                borrarsvn "$dir"
            fi      
        fi            
    done
}

borrarsvn ./
