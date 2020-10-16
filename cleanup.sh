#!/usr/bin/env bash
# Inspired by https://github.com/fwartner/mac-cleanup

# include my library helpers for colorized echo and require_brew, etc
source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh

# Default arguments
doUpdates=false

bytesToHuman() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        (( s++ ))
    done
    echo "$b$d ${S[$s]} of space was cleaned up"
}

deleteCaches() {
    local cacheName=$1
    shift
    local paths=("$@")
    echo "Initiating cleanup ${cacheName} cache..."
    for folderPath in "${paths[@]}"; do
        if [[ -d ${folderPath} ]]; then
            dirSize=$(du -hs "${folderPath}" | awk '{print $1}')
            echo "Deleting ${folderPath} to free up ${dirSize}..."
            rm -rfv "${folderPath}" &>/dev/null
        fi
    done
}

# Take in arguments
# Can add more arguments in the future
while getopts ":n" opt; do
  case ${opt} in
    n ) doUpdates=false
      ;;
    \? )
        printf 'A Mac Cleanup Utility\n'
        printf 'USAGE:\n cleanup [FLAGS]\n\n'
        printf 'FLAGS:\n'
        printf -- '-h,   prints help menu\n'
        printf -- '-n    no brew updates\n'
        exit
      ;;
  esac
done


bot "💡 Hi! I'm going to cleanup your Mac. Here I go..."

# Ask for the administrator password upfront
sudo -v

HOST=$( whoami )

# Keep-alive sudo until `clenaup.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

oldAvailable=$(df / | tail -1 | awk '{print $4}')

# ###########################################################
# Trashbin
# ###########################################################
bot "Empty the Trash on all mounted volumes and the main HDD..."
sudo rm -rfv /Volumes/*/.Trashes/* &>/dev/null
sudo rm -rfv ~/.Trash/* &>/dev/null

# ###########################################################
# System Log Files
# ###########################################################
bot "Clear System Log Files..."
sudo rm -rfv /private/var/log/asl/*.asl &>/dev/null
sudo rm -rfv /Library/Logs/DiagnosticReports/* &>/dev/null
sudo rm -rfv /Library/Logs/Adobe/* &>/dev/null
rm -rfv ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/* &>/dev/null
rm -rfv ~/Library/Logs/CoreSimulator/* &>/dev/null

# ###########################################################
# Adobe Cache Files
# ###########################################################
bot "Clear Adobe Cache Files..."
sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null

# ###########################################################
# iOS Applications
# ###########################################################
bot "Cleanup iOS Applications..."
rm -rfv ~/Music/iTunes/iTunes\ Media/Mobile\ Applications/* &>/dev/null

# ###########################################################
# iOS Device Backups
# ###########################################################
#bot "Remove iOS Device Backups..."
#rm -rfv ~/Library/Application\ Support/MobileSync/Backup/* &>/dev/null

# ###########################################################
# XCode
# ###########################################################
bot "Cleanup XCode Derived Data and Archives..."
rm -rfv ~/Library/Developer/Xcode/DerivedData/* &>/dev/null
rm -rfv ~/Library/Developer/Xcode/Archives/* &>/dev/null
rm -rfv ~/Library/Developer/Xcode/iOS Device Logs/* &>/dev/null

# ###########################################################
# iOS Simulators
# ###########################################################
#if type "xcrun" &>/dev/null; then
#  bot "Cleanup iOS Simulators..."
#  osascript -e 'tell application "com.apple.CoreSimulator.CoreSimulatorService" to quit'
#  osascript -e 'tell application "iOS Simulator" to quit'
#  osascript -e 'tell application "Simulator" to quit'
#  xcrun simctl shutdown all
#  xcrun simctl erase all
#fi

# ###########################################################
# CocoaPods cache
# ###########################################################
if [ -d "/Users/${HOST}/Library/Caches/CocoaPods" ]; then
    bot "Cleanup CocoaPods cache..."
    rm -rfv ~/Library/Caches/CocoaPods/* &>/dev/null
fi

# ###########################################################
# Gradle cache
# ###########################################################
# support delete gradle caches
if [ -d "/Users/${HOST}/.gradle/caches" ]; then
    bot "Cleanup Gradle cache..."
    rm -rfv ~/.gradle/caches/ &> /dev/null
fi

# ###########################################################
# Clear Dropbox Cache
# ###########################################################
# support delete Dropbox Cache
if [ -d "/Users/${HOST}/Dropbox" ]; then
    bot "Clear Dropbox Cache Files..."
    sudo rm -rfv ~/Dropbox/.dropbox.cache/* &>/dev/null
fi

# ###########################################################
# Cleanup composer
# ###########################################################
if type "composer" &> /dev/null; then
    bot "Cleanup composer..."
    composer clearcache &> /dev/null
fi

# ###########################################################
# Homebrew
# ###########################################################
if type "brew" &>/dev/null; then
    if $doUpdates; then
        bot "Update Homebrew Recipes..."
        brew update
        bot "Upgrade and remove outdated formulae"
        brew upgrade
    fi
    bot "Cleanup Homebrew Cache..."
    brew cleanup -s &>/dev/null
    #brew cask cleanup &>/dev/null
    rm -rfv $(brew --cache) &>/dev/null
    brew tap --repair &>/dev/null
fi

# ###########################################################
# Gems
# ###########################################################
if type "gem" &> /dev/null; then
    bot "Cleanup any old versions of gems"
    gem cleanup &>/dev/null
fi

# ###########################################################
# Docker
# ###########################################################
if type "docker" &> /dev/null; then
    bot "Cleanup Docker"
    docker system prune -af
fi

# ###########################################################
# Pip
# ###########################################################
bot "Cleanup pip cache..."
rm -rfv ~/Library/Caches/pip

# ###########################################################
#  Pyenv-VirtualEnv Cache
# ###########################################################
if [ "$PYENV_VIRTUALENV_CACHE_PATH" ]; then
    bot "Removing Pyenv-VirtualEnv Cache..."
    rm -rfv $PYENV_VIRTUALENV_CACHE_PATH &>/dev/null
fi

# ###########################################################
# NPM
# ###########################################################
if type "npm" &> /dev/null; then
    bot "Cleanup npm cache..."
    npm cache clean --force
fi

# ###########################################################
# Yarn
# ###########################################################
if type "yarn" &> /dev/null; then
    bot "Cleanup Yarn Cache..."
    yarn cache clean --force
fi

# ###########################################################
# Inactive memory
# ###########################################################
bot "Purge inactive memory..."
sudo purge

bot "🎉 Woot! All done."

#newAvailable=$(df / | tail -1 | awk '{print $4}')
#count=$((oldAvailable - newAvailable))
##count=$(( $count * 512))
#bytesToHuman $count
