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

InfoAutomatic() {
    echo "
    +------------------------------+
    +    Automatic Installation    +
    +------------------------------+
    +                              +
    + This will install the softw- +
    + -are in current location.    +
    + Make sure it's empty.        +
    +                              +
    +------------------------------+
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
Menu2

Main() {
    Menu1
}

Main
