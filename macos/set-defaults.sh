#!/bin/sh
# Sets macOS defaults.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# More from:
#    https://gist.github.com/brandonb927/3195465
#
# Run ./set-defaults.sh and you'll be good to go.
if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

set +e

disable_agent() {
	mv "$1" "$1_DISABLED" >/dev/null 2>&1 ||
		sudo mv "$1" "$1_DISABLED" >/dev/null 2>&1
}

unload_agent() {
	launchctl unload -w "$1" >/dev/null 2>&1
}

test -z "$TRAVIS_JOB_ID" && sudo -v

echo ""
echo "› System:"

echo "  › Use AirDrop over every interface"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

echo "  › Show the ~/Library folder"
chflags nohidden ~/Library

echo "  › Show the /Volumes folder"
sudo chflags nohidden /Volumes

echo "  › Set a really fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "  › Enable text replacement almost everywhere"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

echo "  › Increase the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "  › Disable smart quotes and smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "  › Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "  › Disable mouse acceleration"
defaults write -g com.apple.mouse.scaling -1

echo "  › Avoid the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "  › Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "  › Set dark interface style"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

echo "  › Show battery percent"
defaults write com.apple.menuextra.battery ShowPercent -bool true

if [ -n "$TRAVIS_JOB_ID" ]; then
	echo "  › Speed up wake from sleep to 24 hours from an hour"
	# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
	sudo pmset -a standbydelay 86400
fi

#############################

echo ""
echo "› Finder:"
echo "  › Always open everything in Finder's list view"
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

echo "  › Set the Finder prefs for showing a few different volumes on the Desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo "  › Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo "  › Set sidebar icon size to small"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

echo "  › Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "  › Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  › Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "  › Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "  › Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#############################

echo ""
echo "› Photos:"
echo "  › Disable it from starting everytime a device is plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

#############################

# echo ""
# echo "› Kill related apps"
# for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
# 	"Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
# 	"Terminal" "Transmission" "Photos"; do
# 	killall "$app" >/dev/null 2>&1
# done
set -e
