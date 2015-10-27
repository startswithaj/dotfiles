# brew install git-flow-avh
# brew install node
# brew install caskroom/cask/brew-cask
# brew cask install google-chrome
# brew cask install spectacle
# brew cask install sublime
# brew cask install mplayer
# hazel


curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

defaults write com.apple.finder AppleShowAllFiles -bool YES # show .dotfiles in finder

# Keyboard repeat (requires logout/login)
defaults write -g InitialKeyRepeat -int 10            # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1                    # normal minimum is 2 (30 ms)

# Dock - Hide/Show instantly, show only open apps
defaults write com.apple.dock static-only -bool TRUE
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
killall Dock



