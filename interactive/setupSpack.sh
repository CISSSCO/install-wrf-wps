#!/bin/bash
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
    git clone https://github.com/spack/spack.git
    cd spack
    git checkout releases/v0.23
    source share/spack/setup-env.sh
    spack info gcc
}

SetupSpackDevelop() {
    git clone https://github.com/spack/spack.git
    cd spack
    source share/spack/setup-env.sh
    git clone https://github.com/spack/spack-packages.git
    spack repo set --destination "$(pwd)/spack-packages" builtin
    spack info gcc
}

currentDate=$(date +%d%b%Y)
currentTime=$(date +%H:%M)

BackupSpack() {
    if [ -d spack ]; then
        mv spack spack.bak_"$currentDate"_"$currentTime"
    else
        echo "No spack found in current directory"
    fi
}

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
    exit
else
    echo "Invalid option!!!"
fi
