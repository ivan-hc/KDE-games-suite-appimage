# KDEGAMES-Suite-AppImage
Debian Stable's full suite of KDE games in one AppImage

This repository provides the script to create and install the latest version of the KDE GAMES suite from Debian Stable, and an AppImage ready to be used.

This version is only a sample.

Furter versions can be easily managed by installing [AM Application Manager](https://github.com/ivan-hc/AM-application-manager).
# How to integrate KDEGAMES AppImage into the system
### Installation
To download and install KDEGAMES Suite for x86_64 with all its launchers and icons:

    wget https://raw.githubusercontent.com/ivan-hc/KDEGAMES-Suite-AppImage/main/kdegames
    chmod a+x ./kdegames
    sudo ./kdegames
To install the version for 32-bit systems:

    wget https://raw.githubusercontent.com/ivan-hc/KDEGAMES-Suite-AppImage/main/kdegames32
    chmod a+x ./kdegames32
    sudo ./kdegames32

### Update

    /opt/kdegames/AM-updater
### Uninstall

    sudo /opt/kdegames/remove

------------------------------------
# These and more scripts will be available on my new repository, at [ivan-hc/AM-application-manager](https://github.com/ivan-hc/AM-application-manager).
