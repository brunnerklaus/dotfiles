#!/usr/bin/env bash

###########################
# This script installs the dotfiles and runs all other system configuration scripts
# @author Adam Eivy
###########################

# include my library helpers for colorized echo and require_brew, etc
source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh

abort() { echo "‼️‼️ $@" >&2; exit 1; }

bot "💡 Hi! I'm going to install tooling and tweak your system settings. Here I go..."

# Do we need to ask for sudo password or is it already passwordless?
grep -q 'NOPASSWD:     ALL' /etc/sudoers.d/$LOGNAME > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "no sudoers file"
  sudo -v

  # Keep-alive: update existing sudo time stamp until the script has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

  # bot "Do you want me to setup this machine to allow you to run sudo without a password?\nPlease read here to see what I am doing:\nhttp://wiki.summercode.com/sudo_without_a_password_in_mac_os_x \n"
  #
  # read -r -p "Make sudo passwordless? [y|N] " response
  #
  # if [[ $response =~ (yes|y|Y) ]];then
  #     if ! grep -q "#includedir /private/etc/sudoers.d" /etc/sudoers; then
  #       echo '#includedir /private/etc/sudoers.d' | sudo tee -a /etc/sudoers > /dev/null
  #     fi
  #     echo -e "Defaults:$LOGNAME    !requiretty\n$LOGNAME ALL=(ALL) NOPASSWD:     ALL" | sudo tee /etc/sudoers.d/$LOGNAME
  #     echo "You can now run sudo commands without password!"
  # fi
fi

# ###########################################################
# /etc/hosts -- spyware/ad blocking
# ###########################################################
# read -r -p "Overwrite /etc/hosts with the ad-blocking hosts file from someonewhocares.org? (from ./configs/hosts file) [y|N] " response
# if [[ $response =~ (yes|y|Y) ]];then
#     action "cp /etc/hosts /etc/hosts.backup"
#     sudo cp /etc/hosts /etc/hosts.backup
#     ok
#     action "cp ./configs/hosts /etc/hosts"
#     sudo cp ./configs/hosts /etc/hosts
#     ok
#     bot "Your /etc/hosts file has been updated. Last version is saved in /etc/hosts.backup"
# else
#     ok "skipped";
# fi

# ###########################################################
# Git Config
# ###########################################################
bot "OK, now I am going to update the .gitconfig for your user info:"
grep 'user = GITHUBUSER' ./homedir/.gitconfig > /dev/null 2>&1
if [[ $? = 0 ]]; then
    read -r -p "What is your git username? " githubuser

  fullname=`osascript -e "long user name of (system info)"`

  if [[ -n "$fullname" ]];then
    lastname=$(echo $fullname | awk '{print $2}');
    firstname=$(echo $fullname | awk '{print $1}');
  fi

  if [[ -z $lastname ]]; then
    lastname=`dscl . -read /Users/$(whoami) | grep LastName | sed "s/LastName: //"`
  fi
  if [[ -z $firstname ]]; then
    firstname=`dscl . -read /Users/$(whoami) | grep FirstName | sed "s/FirstName: //"`
  fi
  email=`dscl . -read /Users/$(whoami)  | grep EMailAddress | sed "s/EMailAddress: //"`

  if [[ ! "$firstname" ]]; then
    response='n'
  else
    echo -e "I see that your full name is $COL_YELLOW$firstname $lastname$COL_RESET"
    read -r -p "Is this correct? [Y|n] " response
  fi

  if [[ $response =~ ^(no|n|N) ]]; then
    read -r -p "What is your first name? " firstname
    read -r -p "What is your last name? " lastname
  fi
  fullname="$firstname $lastname"

  bot "Great $fullname, "

  if [[ ! $email ]]; then
    response='n'
  else
    echo -e "The best I can make out, your email address is $COL_YELLOW$email$COL_RESET"
    read -r -p "Is this correct? [Y|n] " response
  fi

  if [[ $response =~ ^(no|n|N) ]]; then
    read -r -p "What is your email? " email
    if [[ ! $email ]];then
      error "you must provide an email to configure .gitconfig"
      exit 1
    fi
  fi


  running "replacing items in .gitconfig with your info ($COL_YELLOW$fullname, $email, $githubuser$COL_RESET)"

  # test if gnu-sed or MacOS sed

  sed -i "s/GITHUBFULLNAME/$firstname $lastname/" ./homedir/.gitconfig > /dev/null 2>&1 | true
  if [[ ${PIPESTATUS[0]} != 0 ]]; then
    echo
    running "looks like you are using MacOS sed rather than gnu-sed, accommodating"
    sed -i '' "s/GITHUBFULLNAME/$firstname $lastname/" ./homedir/.gitconfig
    sed -i '' 's/GITHUBEMAIL/'$email'/' ./homedir/.gitconfig
    sed -i '' 's/GITHUBUSER/'$githubuser'/' ./homedir/.gitconfig
    ok
  else
    echo
    bot "looks like you are already using gnu-sed. woot!"
    sed -i 's/GITHUBEMAIL/'$email'/' ./homedir/.gitconfig
    sed -i 's/GITHUBUSER/'$githubuser'/' ./homedir/.gitconfig
  fi
fi

# ###########################################################
# Wallpaper
# ###########################################################
# MD5_NEWWP=$(md5 img/wallpaper.jpg | awk '{print $4}')
# MD5_OLDWP=$(md5 /System/Library/CoreServices/DefaultBackground.jpg | awk '{print $4}')
# if [[ "$MD5_NEWWP" != "$MD5_OLDWP" ]]; then
#   read -r -p "Do you want to use the project's custom desktop wallpaper? [y|N] " response
#   if [[ $response =~ (yes|y|Y) ]]; then
#     running "Set a custom wallpaper image"
#     # rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#     bot "I will backup system wallpapers in ~/.dotfiles/img/"
#     sudo cp /System/Library/CoreServices/DefaultDesktop.jpg img/DefaultDesktop.jpg > /dev/null 2>&1
#     sudo cp /Library/Desktop\ Pictures/El\ Capitan.jpg img/El\ Capitan.jpg > /dev/null 2>&1
#     sudo cp /Library/Desktop\ Pictures/Sierra.jpg img/Sierra.jpg > /dev/null 2>&1
#     sudo cp /Library/Desktop\ Pictures/Sierra\ 2.jpg img/Sierra\ 2.jpg > /dev/null 2>&1
#     sudo rm -f /System/Library/CoreServices/DefaultDesktop.jpg > /dev/null 2>&1
#     sudo rm -f /Library/Desktop\ Pictures/El\ Capitan.jpg > /dev/null 2>&1
#     sudo rm -f /Library/Desktop\ Pictures/Sierra.jpg > /dev/null 2>&1
#     sudo rm -f /Library/Desktop\ Pictures/Sierra\ 2.jpg > /dev/null 2>&1
#     sudo cp ./img/wallpaper.jpg /System/Library/CoreServices/DefaultDesktop.jpg;
#     sudo cp ./img/wallpaper.jpg /Library/Desktop\ Pictures/Sierra.jpg;
#     sudo cp ./img/wallpaper.jpg /Library/Desktop\ Pictures/Sierra\ 2.jpg;
#     sudo cp ./img/wallpaper.jpg /Library/Desktop\ Pictures/El\ Capitan.jpg;ok
#   else
#     ok "skipped"
#   fi
# fi


# ###########################################################
# Install non-brew various tools (PRE-BREW Installs)
# ###########################################################

bot "ensuring build/install tools are available"
if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? ' XCode Command Line Tools Installed'

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi


# ###########################################################
# install homebrew (CLI Packages)
# ###########################################################
running "checking homebrew..."
brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
  action "installing homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  if [[ $? != 0 ]]; then
    error "unable to install homebrew, script $0 abort!"
    exit 2
  fi
  brew analytics off
else
  ok
  bot "Homebrew"
  read -r -p "run brew update && upgrade? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]]; then
    action "updating homebrew..."
    brew update
    ok "homebrew updated"
    action "upgrading brew packages..."
    brew upgrade
    ok "brews upgraded"
  else
    ok "skipped brew package upgrades."
  fi
fi

# Just to avoid a potential bug
mkdir -p ~/Library/Caches/Homebrew/Formula
brew doctor

# skip those GUI clients, git command-line all the way
require_brew git
# update zsh to latest
require_brew zsh
# update ruby to latest
# use versions of packages installed with homebrew
RUBY_CONFIGURE_OPTS="--with-openssl-dir=`brew --prefix openssl` --with-readline-dir=`brew --prefix readline` --with-libyaml-dir=`brew --prefix libyaml`"
require_brew ruby
# set zsh as the user login shell
CURRENTSHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
if [[ "$CURRENTSHELL" != "/usr/local/bin/zsh" ]]; then
  bot "setting newer homebrew zsh (/usr/local/bin/zsh) as your shell (password required)"
  # sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
  # chsh -s /usr/local/bin/zsh
  sudo dscl . -change /Users/$USER UserShell $SHELL /usr/local/bin/zsh > /dev/null 2>&1
  ok
fi

if [[ ! -d "./oh-my-zsh/custom/themes/powerlevel9k" ]]; then
  git clone https://github.com/bhilburn/powerlevel9k.git oh-my-zsh/custom/themes/powerlevel9k
fi


bot "Dotfiles Setup"
read -r -p "symlink ./homedir/* files in ~/ (these are the dotfiles)? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
  bot "creating symlinks for project dotfiles..."
  pushd homedir > /dev/null 2>&1
  now=$(date +"%Y.%m.%d.%H.%M.%S")

  for file in .*; do
    if [[ $file == "." || $file == ".." ]]; then
      continue
    fi
    running "~/$file"
    # if the file exists:
    if [[ -e ~/$file ]]; then
        mkdir -p ~/.dotfiles_backup/$now
        mv ~/$file ~/.dotfiles_backup/$now/$file
        echo "backup saved as ~/.dotfiles_backup/$now/$file"
    fi
    # symlink might still exist
    unlink ~/$file > /dev/null 2>&1
    # create the link
    ln -s ~/.dotfiles/homedir/$file ~/$file
    echo -en '\tlinked';ok
  done

  popd > /dev/null 2>&1
fi


bot "VIM Setup"
read -r -p "Do you want to install vim plugins now? [y|N] " response
if [[ $response =~ (y|yes|Y) ]];then
  bot "Installing vim plugins"
  # cmake is required to compile vim bundle YouCompleteMe
  # require_brew cmake
  vim +PluginInstall +qall > /dev/null 2>&1
  ok
else
  ok "Skipped. Install by running :PluginInstall within vim"
fi

read -r -p "Install fonts? [y|N] " response
if [[ $response =~ (y|yes|Y) ]];then
  bot "Installing fonts"
  # need fontconfig to install/build fonts
  require_brew fontconfig
  ./fonts/install.sh
  brew tap homebrew/cask-fonts
  require_cask font-fontawesome
  require_cask font-awesome-terminal-fonts
  require_cask font-hack
  require_cask font-inconsolata-dz-for-powerline
  require_cask font-inconsolata-g-for-powerline
  require_cask font-inconsolata-for-powerline
  require_cask font-roboto-mono
  require_cask font-roboto-mono-for-powerline
  require_cask font-source-code-pro
  ok
else
  ok "Skipped font install"
fi


# if [[ -d "/Library/Ruby/Gems/2.0.0" ]]; then
#   running "Fixing Ruby Gems Directory Permissions"
#   sudo chown -R $(whoami) /Library/Ruby/Gems/2.0.0
#   ok
# fi

# node version manager
require_brew nvm

# nvm
require_nvm stable

# always pin versions (no surprises, consistent dev/build machines)
npm config set save-exact true

#####################################
# Now we can switch to node.js mode
# for better maintainability and
# easier configuration via
# JSON files and inquirer prompts
#####################################

###############################################################################
#bot "Installing npm tools needed to run this project..."
###############################################################################
#npm install
#ok

###############################################################################
bot "Installing packages from config.js..."
###############################################################################
node index.js
ok

###############################################################################
bot "📋 Configure Atom editor packages"
###############################################################################

running "Installing Atom Community Packages"
printf "\n"
apm install --production --compatible \
  Sublime-Style-Column-Selection \
  ask-stack \
  atom-beautify \
  atom-ide-ui \
  atom-yamljson \
  file-icons \
  highlight-selected \
  language-docker \
  language-liquid \
  minimap \
  minimap-pigments \
  minimap-find-and-replace \
  minimap-git-diff \
  minimap-highlight-selected \
  sort-lines \
  git-log \
  git-blame \
  git-time-machine \
  tree-view-git-status \
  merge-conflicts \
  linter-jshint \
  linter \
  unity-ui \
  trailing-spaces \
  pigments \
  zenburn-syntax \
  atom-gpg \
  atom-latex

###############################################################################
running "Cleanup homebrew"
###############################################################################
brew cleanup --force > /dev/null 2>&1
rm -f -r /Library/Caches/Homebrew/* > /dev/null 2>&1
ok

###############################################################################
bot "OS Configuration"
###############################################################################
read -r -p "Do you want to update the system configurations? [y|N] " response
if [[ -z $response || $response =~ ^(n|N) ]]; then
  open /Applications/iTerm.app
  bot "All done"
  exit
fi

###############################################################################
bot "💻 Configuring General System UI/UX..."
###############################################################################
# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
running "closing any system preferences to prevent issues with automated changes"
osascript -e 'tell application "System Preferences" to quit'
ok

#running "Enable Dark Mode in High Sierra"
#defaults write -g NSWindowDarkChocolate -bool TRUE;ok

##############################################################################
# Security                                                                   #
##############################################################################
# Based on:
# https://github.com/drduh/macOS-Security-and-Privacy-Guide
# https://benchmarks.cisecurity.org/tools2/osx/CIS_Apple_OSX_10.12_Benchmark_v1.0.0.pdf

# Enable firewall. Possible values:
#   0 = off
#   1 = on for specific sevices
#   2 = on for essential services
running "Enable firewall"
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Enable firewall stealth mode (no response to ICMP / ping requests)
# Source: https://support.apple.com/kb/PH18642
#sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1
running "Enable firewall stealth mode"
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1

# Enable firewall logging
#sudo defaults write /Library/Preferences/com.apple.alf loggingenabled -int 1

# Do not automatically allow signed software to receive incoming connections
#sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool false

# Log firewall events for 90 days
#sudo perl -p -i -e 's/rotate=seq compress file_max=5M all_max=50M/rotate=utc compress file_max=5M ttl=90/g' "/etc/asl.conf"
#sudo perl -p -i -e 's/appfirewall.log file_max=5M all_max=50M/appfirewall.log rotate=utc compress file_max=5M ttl=90/g' "/etc/asl.conf"

# Reload the firewall
# (uncomment if above is not commented out)
#launchctl unload /System/Library/LaunchAgents/com.apple.alf.useragent.plist
#sudo launchctl unload /System/Library/LaunchDaemons/com.apple.alf.agent.plist
#sudo launchctl load /System/Library/LaunchDaemons/com.apple.alf.agent.plist
#launchctl load /System/Library/LaunchAgents/com.apple.alf.useragent.plist

# Disable IR remote control
#sudo defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool false

# Turn Bluetooth off completely
#sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0
#sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist
#sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist

# Disable wifi captive portal
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

running "Disable remote apple events"
sudo systemsetup -setremoteappleevents off;ok

running "Disable remote login"
sudo systemsetup -setremotelogin off;ok

running "Disable wake-on modem"
sudo systemsetup -setwakeonmodem off;ok

running "Disable wake-on LAN"
sudo systemsetup -setwakeonnetworkaccess off;ok

# Disable file-sharing via AFP or SMB
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist

# Display login window as name and password
#sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

# Do not show password hints
#sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0

running "Disable guest account login"
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false;ok

running "Automatically lock the login keychain for inactivity after 6 hours"
security set-keychain-settings -t 21600 -l ~/Library/Keychains/login.keychain;ok

# Destroy FileVault key when going into standby mode, forcing a re-auth.
# Source: https://web.archive.org/web/20160114141929/http://training.apple.com/pdf/WP_FileVault2.pdf
#sudo pmset destroyfvkeyonstandby 1

running "Disable Bonjour multicast advertisements"
#https://www.trustwave.com/Resources/SpiderLabs-Blog/mDNS---Telling-the-world-about-you-(and-your-device)/
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true;ok

running "Disable diagnostic reports"
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.SubmitDiagInfo.plist;ok

running "Log authentication events for 90 days"
sudo perl -p -i -e 's/rotate=seq file_max=5M all_max=20M/rotate=utc file_max=5M ttl=90/g' "/etc/asl/com.apple.authd";ok

running "Log installation events for a year"
sudo perl -p -i -e 's/format=bsd/format=bsd mode=0640 rotate=utc compress file_max=5M ttl=365/g' "/etc/asl/com.apple.install";ok

# Increase the retention time for system.log and secure.log
#sudo perl -p -i -e 's/\/var\/log\/wtmp.*$/\/var\/log\/wtmp   \t\t\t640\ \ 31\    *\t\@hh24\ \J/g' "/etc/newsyslog.conf"

# Keep a log of kernel events for 30 days
#sudo perl -p -i -e 's|flags:lo,aa|flags:lo,aa,ad,fd,fm,-all,^-fa,^-fc,^-cl|g' /private/etc/security/audit_control
#sudo perl -p -i -e 's|filesz:2M|filesz:10M|g' /private/etc/security/audit_control
#sudo perl -p -i -e 's|expire-after:10M|expire-after: 30d |g' /private/etc/security/audit_control

# Disable the “Are you sure you want to open this application?” dialog
#running "Disable the “Are you sure you want to open this application?” dialog"
#defaults write com.apple.LaunchServices LSQuarantine -bool false;ok

###############################################################################
bot "💾 SSD-specific tweaks"
###############################################################################

#running "Disable local Time Machine snapshots"
#sudo tmutil disablelocal;ok

running "Disable hibernation (speeds up entering sleep mode)"
# supported sleep modes:"
#     sleep       --> hibernatemode 0"
#     safesleep   --> hibernatemode 3"
#     hibernate   --> hibernatemode 25"
#     secure      --> destroyfvkeyonstandby 1"
#     insecure    --> destroyfvkeyonstandby 0"
#
# sleep (or old-style sleep) does not back up memory to disk. this is"
# useful if you are running out of hard drive space, but will eat"
# more battery and if the system runs out of power, the current state"
# is lost."
#
# safesleep backs up memory to persistent storage, taking as much disk"
# space as the system has memory. this uses more disk space and more"
# battery, as memory is powered during sleep. If the battery is"
# exhausted, the system will hibernate."
#
# hibernate writes memory to persistent storage, and powers down the"
# machine. the sleep image takes up as much space as the system has"
# memory. While sleeps/wakes are slower, battery life is much improved"
# as memory is not powered during sleep."
#
# secure mode destroys the file vault key on standby, requiring the"
# password to be entered on wake. insecure mode retains the file "
# vault key on wake."
# See https://discussions.apple.com/thread/6090869
#
running "Get current seeting: pmset -g | grep hibernatemode | awk '{ print $2 ; }'"
sudo pmset -a hibernatemode 3

#running "Remove the sleep image file to save disk space"
#sudo rm -rf /Private/var/vm/sleepimage;ok
#running "Create a zero-byte file instead"
#sudo touch /Private/var/vm/sleepimage;ok
#running "…and make sure it can’t be rewritten"
#sudo chflags uchg /Private/var/vm/sleepimage;ok

running "Disable the sudden motion sensor as it’s not useful for SSDs"
sudo pmset -a sms 0;ok

################################################
bot "🎚️   Optional / Experimental"
################################################

# running "Set computer name (as done via System Preferences → Sharing)"
# sudo scutil --set ComputerName "antic"
# sudo scutil --set HostName "antic"
# sudo scutil --set LocalHostName "antic"
# sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "antic"

#setting up the computer label & name
read -p "What is this machine's label (Example: Klaus’s MacBook Pro) ? " mac_os_label
if [[ -z "$mac_os_label" ]]; then
  echo "ERROR: Invalid MacOS label."
  exit 1
fi

sudo scutil --get ComputerName
read -p "What is this machine's name (Example: Klauss-MacBook-Pro) ? " mac_os_name
if [[ -z "$mac_os_name" ]]; then
  echo "ERROR: Invalid MacOS name."
  exit 1
fi

echo "Setting system Label and Name..."
sudo scutil --set ComputerName "$mac_os_label"
sudo scutil --set HostName "$mac_os_name"
sudo scutil --set LocalHostName "$mac_os_name"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$mac_os_name"

# running "Disable smooth scrolling"
# (Uncomment if you’re on an older Mac that messes up the animation)
# defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false;ok

# running "Disable Resume system-wide"
# defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false;ok
# TODO: might want to enable this again and set specific apps that this works great for
# e.g. defaults write com.microsoft.word NSQuitAlwaysKeepsWindows -bool true

# running "Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)""
# # Commented out, as this is known to cause problems in various Adobe apps :(
# # See https://github.com/mathiasbynens/dotfiles/issues/237
# echo "0x08000100:0" > ~/.CFUserTextEncoding;ok

# running "Stop iTunes from responding to the keyboard media keys"
# launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null;ok

running "Show icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true;ok

# running "Enable the MacBook Air SuperDrive on any Mac"
# sudo nvram boot-args="mbasd=1";ok

# running "Remove Dropbox’s green checkmark icons in Finder"
# file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
# [ -e "${file}" ] && mv -f "${file}" "${file}.bak";ok

# running "Wipe all (default) app icons from the Dock"
# # This is only really useful when setting up a new Mac, or if you don’t use
# # the Dock to launch apps.
# defaults write com.apple.dock persistent-apps -array "";ok

#running "Enable the 2D Dock"
#defaults write com.apple.dock no-glass -bool true;ok

#running "Disable the Launchpad gesture (pinch with thumb and three fingers)"
#defaults write com.apple.dock showLaunchpadGestureEnabled -int 0;ok

#running "Add a spacer to the left side of the Dock (where the applications are)"
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}';ok
#running "Add a spacer to the right side of the Dock (where the Trash is)"
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}';ok


################################################
bot "🎛   Standard System Changes"
################################################
# running "Always boot in verbose mode (not MacOS GUI mode)"
# sudo nvram boot-args="-v";ok

running "Allow 'locate' command"
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist > /dev/null 2>&1;ok

running "Set standby delay to 24 hours (default is 1 hour)"
sudo pmset -a standbydelay 86400;ok

# running "Disable the sound effects on boot"
# sudo nvram SystemAudioVolume=" ";ok

running "Menu bar: disable transparency"
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false;ok

#running "Menu bar: hide the Time Machine, Volume, User, and Bluetooth icons"
#for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
#  defaults write "${domain}" dontAutoLoad -array \
  #    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
  #    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
  #    "/System/Library/CoreServices/Menu Extras/User.menu"
#done;
#defaults write com.apple.systemuiserver menuExtras -array \
  #  "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
  #  "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
  #  "/System/Library/CoreServices/Menu Extras/Battery.menu" \
  #  "/System/Library/CoreServices/Menu Extras/Clock.menu"
#ok

# Disable transparency in the menu bar and elsewhere on Yosemite
#defaults write com.apple.universalaccess reduceTransparency -bool true

#running "Set highlight color to green"
#defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600";ok

running "Set sidebar icon size to medium"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2;ok

running "Always show scrollbars"
# Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "Always";ok

running "Increase window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001;ok

running "Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true;ok

running "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true;ok

running "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false;ok

running "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true;ok

running "Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false;ok

# https://github.com/atomantic/dotfiles/issues/30#issuecomment-514589462
#running "Remove duplicates in the “Open With” menu (also see 'lscleanup' alias)"
#/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user;ok

##running "Display ASCII control characters using caret notation in standard text views"
### Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
##defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true;ok

running "Disable automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true;ok

running "Disable the crash reporter"
defaults write com.apple.CrashReporter DialogType -string "none";ok

running "Set Help Viewer windows to non-floating mode"
defaults write com.apple.helpviewer DevMode -bool true;ok

running "Reveal IP, hostname, OS, etc. when clicking clock in login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName;ok

running "Restart automatically if the computer freezes"
sudo systemsetup -setrestartfreeze on;ok

running "Never go into computer sleep mode"
sudo systemsetup -setcomputersleep Off > /dev/null;ok

# running "Check for software updates daily, not just once per week"
# defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1;ok

# running "Disable Notification Center and remove the menu bar icon"
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist > /dev/null 2>&1;ok

running "Disable smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false;ok

running "Disable smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false;ok

running "Enable 24 hour time"
defaults write -g AppleICUForce24HourTime -bool true;ok

running "Set monday: first day of week"
defaults write -g AppleFirstWeekday -dict gregorian 2;ok

running "Enable dark mode (Mojave only)"
defaults write "Apple Global Domain" "AppleInterfaceStyle" "Dark";ok
#revert
#defaults delete "Apple Global Domain" "AppleInterfaceStyle"

###############################################################################
bot "💻 Trackpad"
###############################################################################
running "Trackpad: enable tap to click for this user and for the login screen"
#(Don't have to press down on the trackpad -- just tap it.)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1;ok
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1

running "Trackpad: map bottom right corner to right-click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true;ok

running "Tracking Speed: from 0 to 3"
defaults write -g com.apple.trackpad.scaling -float 0;ok

###############################################################################
bot "⌨️   Keyboard, Bluetooth accessories, and input"
###############################################################################

running "Enable 'natural' (Lion-style) scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true;ok

running "Increase sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40;ok

running "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3;ok

#Deprecated
#running "Use scroll gesture with the Ctrl (^) modifier key to zoom"
#defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
#defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144;ok
#running "Follow the keyboard focus while zoomed in"
#defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true;ok

running "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false;ok

running "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 2 # normal minimum is 2 (30 ms)
defaults write NSGlobalDomain InitialKeyRepeat -int 10;ok # normal minimum is 15 (225 ms)

running "Set language and text formats (english/US)"
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en" "de"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true;ok

running "Show language menu in the top right corner of the boot screen"
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true;ok

#running "Disable auto-correct"
#defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false;ok

# Read the current state with the following. (1 for F-keys, 0 for media/brightness etc)
#defaults read "Apple Global Domain" "com.apple.keyboard.fnState"

running "Use all F1, F2 as standard keys"
defaults write "Apple Global Domain" "com.apple.keyboard.fnState" "1";ok ## F1 F2 etc
#defaults write "Apple Global Domain" "com.apple.keyboard.fnState" "0" ## Brightness/Media

###############################################################################
bot "🖱️  Configuring the Mouse"
###############################################################################

running "Disable mouse acceleration "
defaults write -g com.apple.mouse.scaling -1;ok

running "Enable secondary button on click"
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton;ok

runnign "Enable swipe with one single finger gesture to go back while browsing"
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseOneFingerDoubleTapGesture 1;ok

###############################################################################
bot "📺 Configuring the Screen"
###############################################################################

running "Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0;ok

running "Save screenshots to the sreenshots folder"
mkdir -p ${HOME}/Pictures/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots";ok

running "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png";ok

running "Hide all desktop icons because who need 'em'"
defaults write com.apple.finder CreateDesktop -bool false;ok

running "Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true;ok

running "Enable subpixel font rendering on non-Apple LCDs"
# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 2;ok

running "Enable HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true;ok

###############################################################################
bot "📂 Finder Configuration"
###############################################################################
running "Keep folders on top when sorting by name (version 10.12 and later)"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

running "Allow quitting via ⌘ + Q; doing so will also hide desktop icons"
defaults write com.apple.finder QuitMenuItem -bool true;ok

running "Disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true;ok

running "Set Desktop as the default location for new Finder windows"
# For other paths, use 'PfLo' and 'file:///full/path/here/'
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/";ok

running "Show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true;ok

running "Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true;ok

running "Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true;ok

running "Show path bar"
defaults write com.apple.finder ShowPathbar -bool true;ok

running "Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true;ok

running "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true;ok

running "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf";ok

running "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false;ok

running "Enable spring loading for directories"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true;ok

running "Remove the spring loading delay for directories"
defaults write NSGlobalDomain com.apple.springing.delay -float 0;ok

running "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true;ok

running "Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true;ok

running "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true;ok

running "Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv";ok

running "Enable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false;ok

running "Empty Trash securely by default"
defaults write com.apple.finder EmptyTrashSecurely -bool true;ok

#running "Enable AirDrop over Ethernet and on unsupported Macs running Lion"
#defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true;ok

# Issue on macOS Mojave, for more info
# check https://github.com/mathiasbynens/dotfiles/issues/865
# running "Show the ~/Library folder"
# chflags nohidden ~/Library;ok

running "Expand the following File Info panes: “General”, “Open with”, and “Sharing & Permissions”"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true;ok

###############################################################################
bot "📱 Dock & Dashboard and hot corners"
###############################################################################

running "Enable highlight hover effect for the grid view of a stack (Dock)"
defaults write com.apple.dock mouse-over-hilite-stack -bool true;ok

running "Set the icon size of Dock items to 49 pixels"
defaults write com.apple.dock tilesize -int 49;ok

running "Change minimize/maximize window effect to scale"
defaults write com.apple.dock mineffect -string "scale";ok

running "Minimize windows into their application’s icon"
defaults write com.apple.dock minimize-to-application -bool true;ok

running "Enable spring loading for all Dock items"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true;ok

running "Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true;ok

running "Animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool true;ok

running "Speed up Mission Control animations"
defaults write com.apple.dock expose-animation-duration -float 0.1;ok

running "Don’t group windows by application in Mission Control"
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false;ok

# Dashboard is disabled by default on macOS Mojave,
# Moreover as of macOS 10.15 Catalina, Dashboard is removed macOS.

# running "Disable Dashboard"
# defaults write com.apple.dashboard mcx-disabled -bool true;ok

# running "Don’t show Dashboard as a Space"
# defaults write com.apple.dock dashboard-in-overlay -bool true;ok

running "Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false;ok

running "Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0;ok

running "Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0;ok

running "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool false;ok

running "Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool true;ok

running "Make Dock more transparent"
defaults write com.apple.dock hide-mirror -bool true;ok

# defaults write com.apple.dock ResetLaunchPad -bool TRUE
running "Reset Launchpad, but keep the desktop wallpaper intact"
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete;ok

# You can change the layout of your Launchpad
# Use the following command in Terminal to change the layout of Launchpad.
# Change ‘X’ into the number of icons to be showed in a single row (e.g 9).
#defaults write com.apple.dock springboard-columns -int 9

# Change ‘X’ to the number of rows (e.g 3).
#defaults write com.apple.dock springboard-rows -int 3

# Force a restart of Launchpad with the following command to apply the changes:
#defaults write com.apple.dock ResetLaunchPad -bool TRUE;killall Dock

# Add iOS & Watch Simulator to Launchpad
#sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
#sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"

# Add a spacer to the left side of the Dock (where the applications are)
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the right side of the Dock (where the Trash is)
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

#restore default dock settings
#defaults delete com.apple.dock autohide
#defaults delete com.apple.dock autohide-delay
#defaults delete com.apple.dock autohide-time-modifier

bot "🔦 Configuring Hot Corners"
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
running "Top left screen corner → Mission Control"
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0;ok
running "Top right screen corner → Desktop"
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0;ok
running "Bottom right screen corner → Start screen saver"
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0;ok

###############################################################################
bot "🌍 Configuring Safari & WebKit"
###############################################################################

running "Privacy: don’t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true;ok

running "Press Tab to highlight each item on a web page"
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true;ok

# TODO : doesn't work on macOS Mojave,
# check for more info : https://apple.stackexchange.com/questions/338313/how-can-i-enable-backspace-to-go-back-in-safari-on-mojave
running "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true;ok

running "Show the full URL in the address bar (note: this still hides the scheme)"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true;ok

running "Set Safari’s home page to ‘about:blank’ for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank";ok

running "Prevent Safari from opening ‘safe’ files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false;ok

running "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true;ok

running "Hide Safari’s bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false;ok

running "Hide Safari’s sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false;ok

running "Disable Safari’s thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2;ok

running "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true;ok

running "Make Safari’s search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false;ok

running "Remove useless icons from Safari’s bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()";ok

running "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true;ok

running "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true;ok

#running "Enable continuous spellchecking"
#defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true;ok

#running "Disable auto-correct"
#defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false;ok

#running "Disable AutoFill"
#defaults write com.apple.Safari AutoFillFromAddressBook -bool false;ok
#defaults write com.apple.Safari AutoFillPasswords -bool false;ok
#defaults write com.apple.Safari AutoFillCreditCardData -bool false;ok
#defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false;ok

#running "Warn about fraudulent websites"
#defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true;ok

#running "Disable plug-ins"
#defaults write com.apple.Safari WebKitPluginsEnabled -bool false;ok
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false;ok

running "Disable Java"
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false;ok

running "Block pop-up windows"
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false;ok

#running "Disable auto-playing video"
#defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
#defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
#defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

running "Enable 'Do Not Track'"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true;ok

#running "Update extensions automatically"
#defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true;ok

###############################################################################
bot "✉️   Configuring Mail"
###############################################################################

running "Disable send and reply animations in Mail.app"
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true;ok

running "Copy email addresses as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false;ok

running "Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9";ok

running "Display emails in threaded mode, sorted by date (oldest at the top)"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date";ok

running "Disable inline attachments (just show the icons)"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true;ok

running "Disable automatic spell checking"
defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled";ok

###############################################################################
bot "📋 Configure Atom editor"
###############################################################################
running "Set Atom as default editor"
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.github.atom;}';ok

###############################################################################
bot "🔍 Spotlight"
###############################################################################

# running "Hide Spotlight tray-icon (and subsequent helper)"
# sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search;ok

# Issue on macOS Mojave :
# Rich Trouton covers the move of /Volumes to no longer being world writable as of Sierra (10.12)
# https://derflounder.wordpress.com/2016/09/21/macos-sierras-volumes-folder-is-no-longer-world-writable

# running "Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed"
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
# sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes";ok
running "Change indexing order and disable some file types from being indexed"
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}';ok

running "Load new settings before rebuilding the index"
killall mds > /dev/null 2>&1;ok

running "Make sure indexing is enabled for the main volume"
sudo mdutil -i on / > /dev/null;ok

running "Rebuild the index from scratch"
sudo mdutil -E / > /dev/null;ok

# Do not search inside external drives (WIP)

###############################################################################
bot "📟 Terminal & iTerm2"
###############################################################################

running "Only use UTF-8 in Terminal.app"
defaults write com.apple.terminal StringEncodings -array 4;ok

# Use a modified version of the Solarized Dark theme by default in Terminal.app
running "Set Solarized Dark theme by default in Terminal.app"
#osascript <<EOD
#
#tell application "Terminal"
#
#	local allOpenedWindows
#	local initialOpenedWindows
#	local windowID
#	set themeName to "Solarized Dark xterm-256color"
#
#	(* Store the IDs of all the open terminal windows. *)
#	set initialOpenedWindows to id of every window
#
#	(* Open the custom theme so that it gets added to the list
#	   of available terminal themes (note: this will open two
#	   additional terminal windows). *)
#	do shell script "open '$HOME/init/" & themeName & ".terminal'"
#
#	(* Wait a little bit to ensure that the custom theme is added. *)
#	delay 1
#
#	(* Set the custom theme as the default terminal theme. *)
#	set default settings to settings set themeName
#
#	(* Get the IDs of all the currently opened terminal windows. *)
#	set allOpenedWindows to id of every window
#
#	repeat with windowID in allOpenedWindows
#
#		(* Close the additional windows that were opened in order
#		   to add the custom theme to the list of terminal themes. *)
#		if initialOpenedWindows does not contain windowID then
#			close (every window whose id is windowID)
#
#		(* Change the theme for the initial opened terminal windows
#		   to remove the need to close them in order for the custom
#		   theme to be applied. *)
#		else
#			set current settings of tabs of (every window whose id is windowID) to settings set themeName
#		end if
#
#	end repeat
#
#end tell
#
#EOD;ok

# Enable "focus follows mouse" for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

running "Enable Secure Keyboard Entry in Terminal.app"
# See: https://security.stackexchange.com/a/47786/8918 and
# https://developer.apple.com/library/archive/technotes/tn2150/_index.html
defaults write com.apple.terminal SecureKeyboardEntry -bool true;ok

running "Disable the annoying line marks"
defaults write com.apple.Terminal ShowLineMarks -int 0;ok

running "Install the Solarized Dark theme for iTerm"
open "${HOME}/init/Solarized Dark.itermcolors";ok

running "Don’t display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false;ok

#running "Enable “focus follows mouse” for Terminal.app and all X11 apps"
# i.e. hover over a window and start `typing in it without clicking first
defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true;ok

running "Installing the Solarized Light theme for iTerm (opening file)"
open "./configs/Solarized Light.itermcolors";ok

running "Installing the Patched Solarized Dark theme for iTerm (opening file)"
open "./configs/Solarized Dark Patch.itermcolors";ok

running "Don’t display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false;ok

running "Hide tab title bars"
defaults write com.googlecode.iterm2 HideTab -bool true;ok

running "Set system-wide hotkey to show/hide iterm with ^\`"
defaults write com.googlecode.iterm2 Hotkey -bool true;ok

running "Hide pane titles in split panes"
defaults write com.googlecode.iterm2 ShowPaneTitles -bool false;ok

running "Animate split-terminal dimming"
defaults write com.googlecode.iterm2 AnimateDimming -bool true;ok
defaults write com.googlecode.iterm2 HotkeyChar -int 96;
defaults write com.googlecode.iterm2 HotkeyCode -int 50;
defaults write com.googlecode.iterm2 FocusFollowsMouse -int 1;
defaults write com.googlecode.iterm2 HotkeyModifiers -int 262401;

running "Make iTerm2 load new tabs in the same directory"
/usr/libexec/PlistBuddy -c "set \"New Bookmarks\":0:\"Custom Directory\" Recycle" ~/Library/Preferences/com.googlecode.iterm2.plist

running "Setting fonts"
defaults write com.googlecode.iterm2 "Normal Font" -string "Hack-Regular 12";
defaults write com.googlecode.iterm2 "Non Ascii Font" -string "RobotoMonoForPowerline-Regular 12";
ok

running "Reading iterm settings"
defaults read -app iTerm > /dev/null 2>&1;
ok

###############################################################################
bot "⌛️ Time Machine"
###############################################################################

running "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true;ok

# disablelocal is no longer used, check man tmutil for more info
# running "Disable local Time Machine snapshots"
# sudo tmutil disablelocal;ok

###############################################################################
bot "📈 Activity Monitor"
###############################################################################

running "Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true;ok

running "Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5;ok

# Show processes in Activity Monitor
# 100: All Processes
# 101: All Processes, Hierarchally
# 102: My Processes
# 103: System Processes
# 104: Other User Processes
# 105: Active Processes
# 106: Inactive Processes
# 106: Inactive Processes
# 107: Windowed Processes
running "Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 100;ok

running "Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0;ok

running "Set columns for each tab"
defaults write com.apple.ActivityMonitor "UserColumnsPerTab v5.0" -dict \
    '0' '( Command, CPUUsage, CPUTime, Threads, PID, UID, Ports )' \
    '1' '( Command, ResidentSize, Threads, Ports, PID, UID,  )' \
    '2' '( Command, PowerScore, 12HRPower, AppSleep, UID, powerAssertion )' \
    '3' '( Command, bytesWritten, bytesRead, Architecture, PID, UID, CPUUsage )' \
    '4' '( Command, txBytes, rxBytes, PID, UID, txPackets, rxPackets, CPUUsage )';ok

running "Sort columns in each tab"
defaults write com.apple.ActivityMonitor UserColumnSortPerTab -dict \
    '0' '{ direction = 0; sort = CPUUsage; }' \
    '1' '{ direction = 0; sort = ResidentSize; }' \
    '2' '{ direction = 0; sort = 12HRPower; }' \
    '3' '{ direction = 0; sort = bytesWritten; }' \
    '4' '{ direction = 0; sort = txBytes; }';ok

running "Update refresh frequency (in seconds)"
# 1: Very often (1 sec)
# 2: Often (2 sec)
# 5: Normally (5 sec)
defaults write com.apple.ActivityMonitor UpdatePeriod -int 2;ok

running "Show Data in the Disk graph (instead of IO)"
defaults write com.apple.ActivityMonitor DiskGraphType -int 1;ok

running "Show Data in the Network graph (instead of packets)"
defaults write com.apple.ActivityMonitor NetworkGraphType -int 1;ok

running "Change Dock Icon"
# 0: Application Icon
# 2: Network Usage
# 3: Disk Activity
# 5: CPU Usage
# 6: CPU History
defaults write com.apple.ActivityMonitor IconType -int 3;ok

###############################################################################
bot "📘 Address Book, Dashboard, iCal, TextEdit, and Disk Utility"
###############################################################################

running "Enable the debug menu in Address Book"
defaults write com.apple.addressbook ABShowDebugMenu -bool true;ok

running "Enable Dashboard dev mode (allows keeping widgets on the desktop)"
defaults write com.apple.dashboard devmode -bool true;ok

running "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0;ok

running "Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4;ok

###############################################################################
bot "📅 Date & Time"
###############################################################################

# Custom DateFormat
#defaults write com.apple.menuextra.clock DateFormat "EEE MMM d  H:mm"

running "Show 24 hours a day"
defaults write com.apple.ical "number of hours displayed" 24;ok

running "Set week start on Monday"
defaults write com.apple.ical "first day of the week" 1;ok

#running "Day starts at 9AM"
#defaults write com.apple.ical "first minute of work hours" 540

running "Enable the debug menu in Disk Utility"
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true;ok

running "Auto-play videos when opened with QuickTime Player"
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true;ok

###############################################################################
bot "🍎 Mac App Store"
###############################################################################

running "Enable the WebKit Developer Tools in the Mac App Store"
defaults write com.apple.appstore WebKitDeveloperExtras -bool true;ok

running "Enable Debug Menu in the Mac App Store"
defaults write com.apple.appstore ShowDebugMenu -bool true;ok

running "Enable the automatic update check"
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true;ok

running "Check for software updates per week, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 7;ok

#running "Download newly available updates in background"
#defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1;ok

#running "Install System data files & security updates"
#defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1;ok

#running "Automatically download apps purchased on other Macs"
#defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1;ok

#running "Turn on app auto-update"
#defaults write com.apple.commerce AutoUpdate -bool true;ok

#running "Allow the App Store to reboot machine on macOS updates"
#defaults write com.apple.commerce AutoUpdateRestartRequired -bool true;ok

###############################################################################
bot "📷 Configuring Photos"
###############################################################################

running "Prevent Photos from opening automatically when devices are plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true;ok

###############################################################################
bot "✉️   Messages"
###############################################################################

#running "Disable automatic emoji substitution (i.e. use plain text smileys)"
#defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false;ok

running "Disable smart quotes as it’s annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false;ok

#running "Disable continuous spell checking"
#defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false;ok

###############################################################################
bot "🌐 Configuring Google Chrome" #& Google Chrome Canary
###############################################################################

running "Disable the all too sensitive backswipe on trackpads"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false;ok
#defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

running "Disable the all too sensitive backswipe on Magic Mouse"
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false;ok
#defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

running "Use the system-native print preview dialog"
defaults write com.google.Chrome DisablePrintPreview -bool true;ok
#defaults write com.google.Chrome.canary DisablePrintPreview -bool true

running "Expand the print dialog by default"
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true;ok
#defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# GPGMail 2                                                                   #
###############################################################################

#running "Disable signing emails by default"
#defaults write ~/Library/Preferences/org.gpgtools.gpgmail SignNewEmailsByDefault -bool false;ok

###############################################################################
#bot "Opera & Opera Developer"
###############################################################################

#running "Expand the print dialog by default"
#defaults write com.operasoftware.Opera PMPrintingExpandedStateForPrint2 -boolean true;ok
#defaults write com.operasoftware.OperaDeveloper PMPrintingExpandedStateForPrint2 -boolean true;ok

###############################################################################
#bot "SizeUp.app"
###############################################################################

#running "Start SizeUp at login"
#defaults write com.irradiatedsoftware.SizeUp StartAtLogin -bool true;ok
#
#running "Don’t show the preferences window on next start"
#defaults write com.irradiatedsoftware.SizeUp ShowPrefsOnNextStart -bool false;ok
#
#killall cfprefsd

###############################################################################
# Sublime Text                                                                #
###############################################################################

#running "Install Sublime Text settings"
#cp -r init/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings 2> /dev/null

###############################################################################
bot "🔧 Set Dock items"
###############################################################################
OLDIFS=$IFS
IFS=''

apps=(
  Launchpad
  'System Preferences'
  iTerm
  Atom
  Safari
  Calendar
  Notes
  Firefox
  Thunderbird
  KeePassX
  Signal
  'Keychain Access'
)

running "Removing all dock icons"
dockutil --no-restart --remove all $HOME;ok
for app in "${apps[@]}"
do
  echo "Keeping $app in Dock"
  dockutil --no-restart --add /Applications/$app.app $HOME;ok
done

running "Restarting Dock"
killall Dock

# restore $IFS
IFS=$OLDIFS

###############################################################################
# Kill affected applications                                                  #
###############################################################################
bot "📣 OK. Note that some of these changes require a logout/restart to take effect. Killing affected applications (so they can reboot)...."
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "iCal" "Terminal"; do
  killall "${app}" > /dev/null 2>&1
done

###############################################################################
# Cleanup                                                #
###############################################################################
bot "📣 Cleanup homebrew"
brew update && brew upgrade && brew cleanup

bot "🎉 Woot! All done. Kill this terminal and launch iTerm"
