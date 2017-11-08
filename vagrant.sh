#!/bin/bash

# A script to Vagrantfile from Git folder to /home/suomisim/
# Script copies any file name to proper folder and renames it Vagrantfile

cd vagrant
prompt="Please select a file:"
options=( $(find -maxdepth 1 -print0 | xargs -0) )

PS3="$prompt "
select opt in "${options[@]}" "Quit" ; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        cp $opt /home/suomisim/Vagrantfile
        echo  "$opt copied as a Vagrantfile"
        break

    else
        echo "Invalid option. Try another one."
    fi
done    


