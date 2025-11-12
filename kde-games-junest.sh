#!/usr/bin/env bash

APP=kde-games-meta
BIN="$APP" #CHANGE THIS IF THE NAME OF THE BINARY IS DIFFERENT FROM "$APP" (for example, the binary of "obs-studio" is "obs")
qtv="6"
kde_meta="bomber bovo granatier kajongg kapman katomic kblackbox kblocks kbounce kbreakout \
kdiamond kfourinline kgoldrunner khangman kigo killbots kiriki kjumpingcube klickety klines \
kmahjongg kmines knavalbattle knetwalk knights kolf kollision konquest kpat kreversi \
kshisen ksirk ksnakeduel kspaceduel ksquares ksudoku ktuberling kubrick lskat palapeli \
picmi skladnik"
kajongg_deps="pyside$qtv python-pyqt$qtv shiboken$qtv qt$qtv-tools python-pyqt$qtv-sip \
python-twisted python-incremental python-attrs python-typing_extensions python-zope-interface python-constantly"
khangman_deps="kirigami-addons kcmutils5 libkeduvocdocument libimobiledevice libimobiledevice-glue libplist libusbmuxd libxcb"
palapeli_deps="libtool libvorbis tdb"
DEPENDENCES=$(echo "alsa-lib libpulse pipewire $kde_meta $khangman_deps $palapeli_deps gnuchess karchive kconfigwidgets kdbusaddons kitemviews kvantum libkdegames libkmahjongg kxmlgui python python-packaging python-gobject python-qtpy qt6ct $kajongg_deps" | tr ' ' '\n' | sort -u | xargs)
#BASICSTUFF="binutils debugedit gzip"
#COMPILERS="base-devel"

# Set keywords to searchan include in names of directories and files in /usr/bin (BINSAVED), /usr/share (SHARESAVED) and /usr/lib (LIBSAVED)
BINSAVED="python"
SHARESAVED="SAVESHAREPLEASE"
LIBSAVED="alsa jack pipewire pulse libogg.so libvorbisenc.so libFLAC.so libmpg123.so libmp3lame.so libgomp.so libQt libpxbackend libnghttp libidn libssh libpsl.so qt libxcb EGL GLX python svg"

# Set the items you want to manually REMOVE. Complete the path in /etc/, /usr/bin/, /usr/lib/, /usr/lib/python*/ and /usr/share/ respectively.
# The "rm" command will take into account the listed object/path and add an asterisk at the end, completing the path to be removed.
# Some keywords and paths are already set. Remove them if you consider them necessary for the AppImage to function properly.
ETC_REMOVED="makepkg.conf pacman"
BIN_REMOVED="gcc"
LIB_REMOVED="gcc libgallium libgo.so libLLVM"
PYTHON_REMOVED="__pycache__/"
SHARE_REMOVED="gcc icons/AdwaitaLegacy icons/Adwaita/cursors/ terminfo"

# Set mountpoints, they are ment to be set into the AppRun.
# Default mounted files are /etc/resolv.conf, /etc/hosts, /etc/nsswitch.conf, /etc/passwd, /etc/group, /etc/machine-id, /etc/asound.conf and /etc/localtime
# Default mounted directories are /media, /mnt, /opt, /run/media, /usr/lib/locale, /usr/share/fonts, /usr/share/themes, /var, and Nvidia-related directories
# Do not touch this if you are not sure.
mountpoint_files=""
mountpoint_dirs="/usr/share/Kvantum"

# Post-installation processes (add whatever you want)
_post_installation_processes() {
	printf "\n◆ User's processes: \n\n"
	echo " - Include only valid locale files"
	rm -Rf AppDir/.junest/usr/share/locale/*
	mkdir -p AppDir/.junest/usr/share/locale
	rsync -av dependencies/usr/share/locale/* AppDir/.junest/usr/share/locale/
}

extra_bins="$kde_meta"

echo "[Desktop Entry]
Name=kdegames
Exec=$APP
Icon=kpat
Type=Application
Categories=Game;" > "$APP".desktop

##########################################################################################################################################################
#	SETUP THE ENVIRONMENT
##########################################################################################################################################################

# Download archimage-builder.sh
if [ ! -f ./archimage-builder.sh ]; then
	ARCHIMAGE_BUILDER="https://raw.githubusercontent.com/ivan-hc/ArchImage/refs/heads/main/core/archimage-builder.sh"
	wget --retry-connrefused --tries=30 "$ARCHIMAGE_BUILDER" -O ./archimage-builder.sh || exit 0
fi

# Create and enter the AppDir
mkdir -p AppDir archlinux && cd archlinux || exit 1

_JUNEST_CMD() {
	./.local/share/junest/bin/junest "$@"
}

# Set archlinux as a temporary $HOME directory
HOME="$(dirname "$(readlink -f "$0")")"

##########################################################################################################################################################
#	DOWNLOAD, INSTALL AND CONFIGURE JUNEST
##########################################################################################################################################################

_enable_archlinuxcn() {	ARCHLINUXCN_ON="1"; }
_enable_chaoticaur() { CHAOTICAUR_ON="1"; }
_enable_multilib() { MULTILIB_ON="1"; }

#_enable_archlinuxcn
#_enable_chaoticaur
#_enable_multilib

[ -f ../archimage-builder.sh ] && source ../archimage-builder.sh junest-setup "$@"

##########################################################################################################################################################
#	INSTALL PROGRAMS USING YAY
##########################################################################################################################################################

_JUNEST_CMD -- yay -Syy
#_JUNEST_CMD -- gpg --keyserver keyserver.ubuntu.com --recv-key C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF # UNCOMMENT IF YOU USE THE AUR

[ -f ../archimage-builder.sh ] && source ../archimage-builder.sh install "$@"

cd ..

##########################################################################################################################################################
#	APPDIR
##########################################################################################################################################################

[ -f ./archimage-builder.sh ] && source ./archimage-builder.sh appdir "$@"

##########################################################################################################################################################
#	APPRUN
##########################################################################################################################################################

rm -f AppDir/AppRun

# Set to "1" if you want to add Nvidia drivers manager in the AppRun
export NVIDIA_ON=1

[ -f ./archimage-builder.sh ] && source ./archimage-builder.sh apprun "$@"

# AppRun footer, here you can add options and change the way the AppImage interacts with its internal structure
cat <<-'HEREDOC' >> AppDir/AppRun

case $1 in
'')
echo "
 USAGE: 
    [GAME]
    [GAME] [OPTION]

 See -h to know the names of the available games.
"; exit;;
-h|--help) echo "
 AVAILABLE KDE GAMES:
 
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
    khangman
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
    skladnik
";;
bomber|bovo|granatier|kajongg|kapman|katomic|kblackbox|kblocks|kbounce|kbreakout|kdiamond|kfourinline|kgoldrunner|khangman|kigo|killbots|kiriki|kjumpingcube|klickety|klines|kmahjongg|kmines|knavalbattle|knetwalk|knights|kolf|kollision|konquest|kpat|kreversi|kshisen|ksirk|ksnakeduel|kspaceduel|ksquares|ksudoku|ktuberling|kubrick|lskat|palapeli|picmi|skladnik) 
_JUNEST_CMD -- /usr/bin/"$@"
;;
*)
echo " $1 does not exists, see -h";;
esac

HEREDOC
chmod a+x AppDir/AppRun

##########################################################################################################################################################
#	COMPILE
##########################################################################################################################################################

[ -f ./archimage-builder.sh ] && source ./archimage-builder.sh compile "$@"

##########################################################################################################################################################
#	CREATE THE APPIMAGE
##########################################################################################################################################################

if test -f ./*.AppImage; then rm -Rf ./*archimage*.AppImage; fi

APPNAME="KDE-games-suite"
REPO="$APPNAME-appimage"
TAG="latest"
UPINFO="gh-releases-zsync|$GITHUB_REPOSITORY_OWNER|$REPO|$TAG|*x86_64.AppImage.zsync"

echo "$VERSION" > ./version

_appimagetool() {
	if ! command -v appimagetool 1>/dev/null; then
		if [ ! -f ./appimagetool ]; then
			echo " Downloading appimagetool..." && curl -#Lo appimagetool https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-"$ARCH".AppImage && chmod a+x ./appimagetool || exit 1
		fi
		./appimagetool "$@"
	else
		appimagetool "$@"
	fi
}

ARCH=x86_64 _appimagetool -u "$UPINFO" \
	AppDir "$APPNAME"_"$VERSION"-archimage5.0-x86_64.AppImage
