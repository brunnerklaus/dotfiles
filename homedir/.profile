#############################################################
# Generic configuration that applies to all shells
#############################################################

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{shellvars,shellfn,shellpaths,shellaliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Generate GITCONFIG USERAME and EMAIL
# Not sourced as environment vars
test -e "$HOME/.extra" && bash $HOME/.extra

# Enable Shell integration for iTerm2
# http://iterm2.com/shell_integration.html
# source ~/.iterm2_shell_integration.`basename $SHELL`
