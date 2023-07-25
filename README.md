*This is an unofficial AppImage that bundles the following KDE games from Arch Linux using JuNest!*

```
    bomber
    bovo
    granatier
    kajongg
    kapman
    katomic
    kblackbox
    kblocks
    kbounce	
    kbreakout
    kdiamond
    kfourinline
    kgoldrunner
    kigo
    killbots
    kiriki
    kjumpingcube
    klickety
    klines
    kmahjongg
    kmines
    knavalbattle
    knetwalk
    knights
    kolf
    kollision
    konquest
    kpat
    kreversi
    kshisen
    ksirk
    ksnakeduel
    kspaceduel
    ksquares
    ksudoku
    ktuberling
    kubrick
    lskat
    palapeli
    picmi
```

*Previously it was based on Debian Stable, but due to GLIBC compatibility it was replaced by JuNest in 2023, July 25th*

Compiling these so-called "ArchImages" is easier and the Arch Linux base is a guarantee of continuity being one of the most important GNU/Linux distributions, supported by a large community that offers more guarantees of continuity, while usually unofficial PPAs are mantained by one or two people and built as a third-party repository for Ubuntu, a distro that is more inclined to push Snaps as official packaging format instead of DEBs.

Learn more about ArchImage packaging at https://github.com/ivan-hc/ArchImage

-------------------------
### *How to integrate this AppImage into the system*
The easier way install at system level the AppImages is to use "AM", alternativelly you can use "AppMan" to install them locally and without root privileges. Learn more about:
- "AM" https://github.com/ivan-hc/AM-application-manager
- AppMan https://github.com/ivan-hc/AM-application-manager

or visit the site ***https://portable-linux-apps.github.io***

-------------------------
### Reduce the size of the JuNest based Appimage
You can analyze the presence of excess files inside the AppImage by extracting it:

    ./*.AppImage --appimage-extract
To start your tests, run the "AppRun" script inside the "squashfs-root" folder extracted from the AppImage:

    ./squashfs-root/AppRun

-------------------------
### *Special Credits*
- JuNest https://github.com/fsquillace/junest
- Arch Linux https://archlinux.org
