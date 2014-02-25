#!/bin/bash

date_bak='date +%Y%m%d.%H%M.bak';
if [ -f ~/.bashrc -a diff .bashrc ~/.bashrc ]; then
    if ls ~/.bashrc.orig &> /dev/null; then
        echo ~/.bashrc.orig already exists;

        backup=~/.bashrc.`$date_bak`;
        echo -en "\tBacking up" ~/.bashrc to "${backup}... " ; 
        mv ~/.bashrc ${backup}; 
        if [ $? -eq 0 ]; then 
            echo "Success!"; 
            replace_file=yes;
        fi
    else
        echo -n Backing up ~/.bashrc to ~/.bashrc.orig... ;
        mv ~/.bashrc ~/.bashrc.orig &>/dev/null; 
        if [ $? -eq 0 ]; then 
            echo 'Success!';
            replace_file=yes;
        fi
    fi
    if [ -n "$replace_file" ]; then
        echo -n Replacing ~/.bashrc with" ./.bashrc... ";
        cp .bashrc ~/.bashrc &> /dev/null;
        if [ $? -eq 0 ]; then echo "Success!"; else echo "Fail :("; fi
    else 
        echo "Fail, skipping replacement";
    fi
fi
