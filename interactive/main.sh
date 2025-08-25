#!/bin/bash
Help() {
    echo

}

Menu1() {
    echo "
    +-----------------------------+
    +      WRF-WPS Installer      +
    +-----------------------------+
    +                             +
    +        1. Automatic         +
    +        2. Custom            +
    +                             +
    +-----------------------------+
    "
}

Menu2() {
    echo "
    +---------------------------------------+
    +           Custom Installation         +
    +---------------------------------------+
    +                                       +
    + 1. Setup spack                        +
    + 2. Installing gcc                     +
    + 3. Installing packages using spack    +
    + 4. WRF deps install                   +
    + 5. Choose WRF                         +
    + 6. Install WPS                        +
    + 7. Clear screen                       +
    + 8. Remove current installations       +
    + 9. Exit                               +
    +                                       +
    +---------------------------------------+
    "
}

InfoAutomatic() {
    echo "
    +---------------------------------------+
    +         Automatic Installation        +
    +---------------------------------------+
    +                                       +
    + This will install the software in     +
    + default location.                     +
    + Make sure it's empty.                 +
    +                                       +
    +---------------------------------------+
    Default location: /scratch/$USER
    "
}

InstallingGCC() {
    spack install -j40 gcc@13.4.0 languages=c,c++,fortran
    spack load gcc@13.4.0
    spack compiler add
}

InstallingPackagesSpack() {
    spack install -j40 python
    spack load python
    spack install -j40 openmpi@4.1.1
    spack load openmpi@4.1.1
}

InstallingWrfDeps() {
    source wrf-dep-install.sh
}

ChooseWRF() {
    echo "1. wrf@4.5.1"
    echo "2. latest"
    read -p "Choose wrf: " $opt
    version=" "
    if [ $opt == 1 ]; then
        version=4.5.1
    elif [ $opt == 2 ]; then
        version=4.6.1
    else
        echo "Invalid option!!!"
    fi
}

InstallingWPS() {
    if [ $version == 4.5.1 ]; then
        spack install -j40 wps ^wrf@4.5.1
    else
        spack install -j40 wps
    fi
}

Main() {
    Menu1
    read -p "Enter your choice [1]: " opt
    if [ -z "$opt" ] || [ $opt == 1 ]; then
        echo "Default choice: Automatic Installation!!!"
        read -p "Enter the full path where you want to install the packages: " path
        if [ -z "$(ls -A $path)" ]; then
            bash ../install.sh $path
        else
            InfoAutomatic
        fi

    else
        while [ 1 -eq 1 ]
        do
            Menu2
            read -p "Enter your option" opt
            if [ $opt == 1 ]; then
                echo "Setting up spack..."
                source setupSpack.sh
                echo "Spack setup complete!!!"
            elif [ $opt == 2 ]; then
                InstallingGCC
            elif [ $opt == 3 ]; then
                InstallingPackagesSpack
            elif [ $opt == 4 ]; then
                InstallingWrfDeps
            elif [ $opt == 5 ]; then
                ChooseWRF
            elif [ $opt == 6 ]; then
                InstallingWPS
            elif [ $opt == 7 ]; then
                Clear
            elif [ $opt == 8 ]; then
                echo "TODO Add commands for removing"
            elif [ $opt == 9 ]; then
                break
            else
                echo "Invalid Option!!!"
            fi
        done
      fi

}

Main
