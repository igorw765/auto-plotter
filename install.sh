#!/bin/bash


MAIN=~/.auto-plotter
T_CONF=~/.auto-plotter/tmp.conf
P_CONF=~/.auto-plotter/plot.conf
MNE=~/.auto-plotter/mnemonic.conf
ALIAS="alias autoplotter='~./.plot.sh'"

cat logo.txt

mkdir -p ~/.auto-plotter

if [[ ! -e ~/.auto-plotter/tmp.conf || ! -e ~/.auto-plotter/plot.conf || ! -e ~/.auto-plotter/mnemonic.conf ]]; then
    touch ~/.auto-plotter/tmp.conf
    chmod 777 $T_CONF
    touch ~/.auto-plotter/plot.conf
    chmod 777 $P_CONF
    touch ~/.auto-plotter/mnemonic.conf
    chmod 777 $MNE
    echo 'Enter mnemonic:'
    read mnemonic
    echo $mnemonic >> $MNE
    echo 'Enter path to temporary chia folder (press enter to skip)'
    read var
    if [[ $var -z ]]; then
        echo 'skipping...'
        sleep 10
    else
        echo $var >> $T_CONF
        echo "Would you like to add more temporary folders? [Y/n]"
        read opt

        if [[ $opt != 'n' || $opt != 'N' ]]; then
            echo $var >> $T_CONF
            echo "Enter folder path (Type 'q' to move on)"
            read $var
            while [[ $var != 'q']]
            do
                echo $var >> $T_CONF
                echo "Enter folder path (Type 'q' to move on)"
                read $var
            done
        else
            echo 'moving on...'
        fi
    fi
    echo 'Would you like to add chia plot folder? (press enter to skip)'
    read $var

    if [[ $var -z ]]; then
        echo 'skipping...'
        sleep 10
    else
        echo $var >> $P_CONF
        echo "Would you like to add more plot folders? [Y/n]"
        read opt

        if [[ $opt != 'n' || $opt != 'N' ]]; then
            echo "Enter folder path (Type 'q' to move on)"
            read $var
            echo $var >> $P_CONF

            while [[ $var != 'q']]
            do
                echo "Enter folder path (Type 'q' to move on)"
                read $var
                echo $var >> $P_CONF
            done
        else
            echo 'moving on...'
        fi
    fi
fi

tar -xf auto-plotter.tar.gz -C ~/.auto-plotter/
cd $MAIN
mv .plot.sh ~/.plot.sh

echo 'Would you like to create alias in your shell configuration profile? [Y/n]'
read $opt
if [[ $opt != 'n' || $opt != 'N' ]]; then
    echo 'progress: [---------------] 0%'
    echo $ALIAS >> ~/.bashrc > /dev/null
    echo 'progress: [#####----------] 33%'
    echo $ALIAS >> ~/.zshrc > /dev/null
    echo 'progress: [############---] 70%'
    echo $ALIAS >> ~/.config/fish/config.fish > /dev/null
    echo 'progress: [###############] 100%'
    sleep 5
    echo 'process finished...'
    echo "Now to run script just type 'autoplotter' in your terminal"
else
    echo "To start script you will need to type './.plot.sh' in your home directory"
fi

cat logo.txt
sleep 5
clear

echo 'Would you like to start plotting now? [y/N]'
read $opt
if [[ $opt != 'n' || $opt != 'N' ]]; then
    echo 'Installation complited'
else
    cd ~
    ./.plot.sh
    echo 'Installation complited'
    echo 'Starting plotting...'
    sleep 5
fi
