#!/usr/bin/env bash


if [ "$(whoami)" = "root" ]
  then
    echo -e "\nERROR: Don't run install as root! Meant to be run as normal user.\n"
    sleep 1
    exit 1
  else
    echo -e "\nUsername is $(whoami) (not root). Proceeding...\n"
    sleep 1
fi

# exit 0

arg1="$(echo $1 | sed -e 's/-//g')"

if [[ "$arg1" = "uninstall" || "$arg1" = "u" ]]
  then

    echo "Uninstalling... "
    sleep 1

    echo "Killing process... "
    sleep 1

    /usr/bin/kill -9 `/usr/bin/ps ax | /usr/bin/grep -e "bash .*/fix_ulauncher_focus" | /usr/bin/grep -v grep | sed -e 's/^[ ]*//g' | /usr/bin/cut -d ' ' -f 1` 2>&1 >/dev/null

    echo "Deleting files... "
    sleep 1

    rm -f ~/.local/bin/fix_ulauncher_focus
    rm -f ~/.local/bin/dedup_fix_ulauncher_focus
    rm -f ~/.config/autostart/Fix_Ulauncher_Focus.desktop
    rm -f ~/.local/share/applications/Fix_Ulauncher_Focus.desktop

    echo -e "Done.\n"
    sleep 1

else

    echo -e "Installing Fix Ulauncher Focus... "
    sleep 1
    # exit 0

    echo -e "Making folders... "
    sleep 1

    /usr/bin/mkdir -p ~/.local/bin
    /usr/bin/mkdir -p ~/.local/share/applications
    /usr/bin/mkdir -p ~/.config/autostart

    echo -e "Copying files... "
    sleep 1

    yes | /usr/bin/cp -rf ./files/dedup_fix_ulauncher_focus ~/.local/bin/
    /usr/bin/chmod +x ~/.local/bin/dedup_fix_ulauncher_focus

    yes | /usr/bin/cp -rf ./files/fix_ulauncher_focus ~/.local/bin/
    /usr/bin/chmod +x ~/.local/bin/fix_ulauncher_focus

    yes | /usr/bin/cp -rf ./files/Fix_Ulauncher_Focus.desktop ./files/Fix_Ulauncher_Focus.desktop.new
    /usr/bin/sed -i "s/{username}/`whoami`/g" ./files/Fix_Ulauncher_Focus.desktop.new
    yes | /usr/bin/mv -f ./files/Fix_Ulauncher_Focus.desktop.new ~/.local/share/applications/Fix_Ulauncher_Focus.desktop
    /usr/bin/chmod +x ~/.local/share/applications/Fix_Ulauncher_Focus.desktop

    echo -e "Enabling autostart... "
    sleep 1
    /usr/bin/ln -s -f ~/.local/share/applications/Fix_Ulauncher_Focus.desktop ~/.config/autostart/
    ~/.local/bin/dedup_fix_ulauncher_focus 2>&1 >/dev/null &

    echo -e "Done.\n"
    sleep 1

fi
