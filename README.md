This is an unofficial AppImage that bundles all the games fo KDE from Arch Linux using JuNest!

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
