#! /bin/bash

echo -e "\e[34m
 ░▒▓███████▓▒░ ░▒▓████████▓▒░  ░▒▓██████▓▒░  ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░  ░▒▓██████▓▒░  
░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓██████▓▒░  ░▒▓██████▓▒░   ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓████████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ░▒▓████████▓▒░ 
       ░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ 
       ░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓███████▓▒░  ░▒▓████████▓▒░  ░▒▓██████▓▒░  ░▒▓████████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█████████████▓▒░  ░▒▓█▓▒░░▒▓█▓▒░                                                                                                               
 \e[0m"

echo -e "\e[34mVersion 1.0.4  \n \e[0m"

echo -e "\e[34m   Welcome to the Seolhwa Desktop environment installer script! This script is configured to install the XMonad window manager
with a collection of basic software, themes, games, icons, fonts, and desktop programs. Please run this script on a fresh 
minimal installation of OpenSUSE from the home directory. \n \n \e[0m"

sleep 1

echo -e "\e[34mSetting up Seolhwa's Desktop Environment\e[0m"

sleep 1

#install additional repositories
echo -e "\e[34mInstallation step 1/6: Installing additional repos \n\e[0m"
sudo zypper ar https://download.opensuse.org/repositories/M17N:fonts/16.0/M17N:fonts.repo 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
sudo zypper ar -cf https://download.opensuse.org/repositories/devel:/tools:/ide:/vscode/openSUSE_Tumbleweed devel_tools_ide_vscode 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
sudo zypper refresh 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
sleep 1
 
#install essential packages and config tools
echo -e "\e[34mInstallation step 2/6: Installing core packages \n\e[0m"
sudo zypper --non-interactive in xorg-x11 xorg-x11-server xorg-x11-server-extra xinit xmonad ghc-xmonad* xmobar ghc-xmobar kitty picom dunst fcitx5 fcitx5-hangul fcitx5-gtk* fcitx5-qt5 fcitx5-qt6 fcitx5-configtool rofi scrot xscreensaver xbacklight nemo feh xsetroot lxappearance qt5ct xrandr arandr libnotify4 NetworkManager polkit polkit-gnome alsa-utils pulseaudio git-core 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
sleep 1

#install user programs (games, general software, etc)
#consider flatpaking discord for update and gif codec support??? we'll test it out and see
echo -e "\e[34mInstallation step 3/6: Installing applications \n\e[0m"
sudo zypper --non-interactive in code discord audacious vlc MozillaFirefox gimp steam simplescreenrecorder clamav libreoffice cheese openshot-qt fastfetch 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
sleep 1

#create custom home directory organization
echo -e "\e[34mInstallation step 4/6: Organizing home directory \n\e[0m"
mkdir Downloads Games Multimedia Programs
mkdir Multimedia/Documents Multimedia/Memes Multimedia/Pictures Multimedia/Music Multimedia/Temp Multimedia/Videos Multimedia/Wallpapers Multimedia/Pictures/Screenshots
sleep 1

#retrieve dot files, fonts, themes, wallpaper, and icons, move them to their correct directories/overwrite pre-existing files
echo -e "\e[34mInstallation step 5/6: Installing desktop environment configuration and themes \n\e[0m"
mkdir .config
mkdir .config/xmonad
mkdir .config/xmobar
mkdir .config/kitty
sudo zypper --non-interactive in kvantum-qt5 kvantum-qt6 monoid-fonts fontawesome-fonts nanum-fonts 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/xmonad.hs 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
mv xmonad.hs .config/xmonad
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/xmobarrc 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
mkdir .config/xmobar
sudo echo "exec xmonad" > .xinitrc
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/seolhwa_profile 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
cat seolhwa_profile >> .profile
rm seolhwa_profile
mv xmobarrc .config/xmobar
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/picom.conf 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
mkdir .config/picom
mv picom.conf .config/picom
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/kitty.conf 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
mv kitty.conf .config/kitty
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/Wallpapers/cyberware.png 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/Wallpapers/cyberware2.png 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
mv cyberware* Multimedia/Wallpapers
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/seolhwa_bashrc 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
cat seolhwa_bashrc >> .bashrc
rm seolhwa_bashrc
mkdir .config/rofi
echo "@theme \"/usr/share/rofi/themes/seolfi.rasi\"" > config.rasi
mv config.rasi .config/rofi
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/Themes/seolfi.rasi 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
mv seolfi.rasi /usr/share/rofi/themes
mkdir .themes
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/Themes/Equilux.tar 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
tar -xvf Equilux.tar 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
rm Equilux.tar
mv Equilux .themes
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/Themes/Posy_Cursor.tar.gz 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/Themes/Tela-grey.tar.xz 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
tar -xvf Tela-grey.tar.xz 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
tar -xvf Posy_Cursor.tar.gz 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
mv Posy_Cursor /usr/share/icons
mv Tela-grey /usr/share/icons
rm -r Tela-grey-dark Tela-grey-light
rm Posy_Cursor.tar.gz
rm Tela-grey.tar.xz
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/Themes/lain.wsz 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
mv lain.wsz /usr/share/audacious/Skins
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/dunstrc 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/settings.ini 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
mkdir .config/dunst
mv dunstrc .config/dunst
rm .config/gtk-3.0/settings.ini
mv settings.ini .config/gtk-3.0
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/fcitx5.tar.gz 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
tar -xvf fcitx5.tar.gz 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
rm fcitx5.tar.gz
rm -r .config/fcitx5
mv fcitx5 .config
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/sounds/startuptheme.wav 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/sounds/notify.wav 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/sounds/error.wav 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/sounds/insert.wav 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/sounds/remove.wav 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/sounds/99-usb-sound.rules 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/sounds/error_sound.sh 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
wget https://raw.githubusercontent.com/Snowy-Seolhwa/Seolhwa-s-Xmonad-Desktop/refs/heads/main/sounds/notify_sound.sh 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'
mkdir .sounds
mv startuptheme.wav .sounds
mv notify.wav .sounds
mv error.wav .sounds
mv insert.wav .sounds
mv remove.wav .sounds
mv 99-usb-sound.rules /etc/udev/rules.d
mv notify_sound.sh .sounds
mv error_sound.sh .sounds
udevadm control --reload-rules && udevadm trigger 2>&1 | sed $'s/^/\033[34m/; $a\033[0m'


#write some lines to automatically unmute all the volumes?
#write some scripts to do system sounds on usb insert/remove, error, and dunst notification
#figure out how to install and configure ly
#figure out grub theming
#remember what file you edited with the vsync thing to prevent screen tearing - its the 20-intel.conf in /etc/X11/xorg.conf.d
#Maybe fcitx5-configtool overrides the config intermittently?
#fix the loading bars and also see about automatically responding to the y/n/a zypper prompts
#user is going to need to do some minor manual adjustment in qt5ct and fcitx5-configtool

sleep 1

#install non-repo games and programs and make symlinks for all of them

#add debian support?
xrandr -s 1600x900
sleep 1
sudo reboot