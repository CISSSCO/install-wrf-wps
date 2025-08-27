#!/bin/bash

submitDir=" "
if [ $# == 0 ]; then
    echo "Current folder location selected for spack installation..."
    submitDir="$(pwd)"
else
    submitDir=$1
fi

ChooseSpackVersion() {
    echo "
    +---------------------------------------+
    +          Choose spack version         +
    +---------------------------------------+
    +                                       +
    + 1. releases/v0.23                     +
    + 2. develop(latest)                    +
    + 3. Backup current installations       +
    + 4. Clear                              +
    + 5. Exit                               +
    +                                       +
    +---------------------------------------+
    "
}

SetupSpack0_23() {
    cd $submitDir
    echo "Changed to folder $(pwd)"
    if [ -e spack ]; then
        echo "Spack already found in current folder (Use backup)..."
    else
        git clone https://github.com/spack/spack.git
        cd spack
        echo "Changed to folder $(pwd)"
        git checkout releases/v0.23
        source share/spack/setup-env.sh
        echo "source $(pwd)/share/spack/setup-env.sh" >> loadEnv.sh
        cd $submitDir
        echo "Changed to folder $(pwd)"
        spack info gcc
    fi
}

SetupSpackDevelop() {
    cd $submitDir
    echo "Changed to folder $(pwd)"
    if [ -e spack ]; then
        echo "Spack already found in current folder (Use backup)..."
    else
        git clone https://github.com/spack/spack.git
        cd spack
        echo "Changed to folder $(pwd)"
        source share/spack/setup-env.sh
        echo "source $(pwd)/share/spack/setup-env.sh" >> loadEnv.sh
        git clone https://github.com/spack/spack-packages.git
        spack repo set --destination "$(pwd)/spack-packages" builtin
        cd $submitDir
        echo "Changed to folder $(pwd)"
        spack info gcc
    fi
}

currentDate=$(date +%d%b%Y)
currentTime=$(date +%H:%M)

BackupSpack() {
    echo "This will rename your spack present in current folder and also your spack configuration folder ~/.spack "
    if [ -e spack ]; then
        echo "spack folder found in your current directory..."
        read -p "Do you want to continue? [n] " option
        if [ "$option" == "y" ]; then
            mv spack spack.bak_"$currentDate"_"$currentTime"
            echo "Backup of spack completed!!!"
            if [ -e ~/.spack ]; then
                echo "Spack configuration folder found in ~/.spack "
                read -p "Do you want to backup? [n] " option
                if [ "$option" == "y" ]; then
                    mv ~/.spack ~/.spack.bak_"$currentDate"_"$currentTime"
                    echo "Backup of configuration completed!!!"
                else
                    echo "Chose not to backup spack configuration..."
                fi
            else
                echo "No configuration found in ~/.spack..."
            fi
        else
            echo "Chose not to backup spack..."
        fi
    else
        echo "No spack found in current directory..."
        if [ -e ~/.spack ]; then
            echo "Spack configuration folder found in ~/.spack "
            read -p "Do you want to backup? [n] " option
            if [ "$option" == "y" ]; then
                mv ~/.spack ~/.spack.bak_"$currentDate"_"$currentTime"
                echo "Backup of configuration completed!!!"
            else
                echo "Chose not to backup spack configuration..."
            fi
        else
            echo "No configuration found in ~/.spack..."
        fi

    fi
}

while [ 1 -eq 1 ]
do
    ChooseSpackVersion
    read -p "Enter your choice : " opt
    if [ $opt == 1 ]; then
        SetupSpack0_23
    elif [ $opt == 2 ]; then
        SetupSpackDevelop
    elif [ $opt == 3 ]; then
        BackupSpack
    elif [ $opt == 4 ]; then
        clear
    elif [ $opt == 5 ]; then
        break
    else
        echo "Invalid option!!!"
    fi
done
