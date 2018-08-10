module.exports = {
  brew: [
    // Search tool like grep, but optimized for programmers - http://conqueringthecommandline.com/book/ack_ag
    'ack',
    // Code-search similar to ack - https://github.com/ggreer/the_silver_searcher
    'ag',
    // Programmable completion for Bash 3.2 - https://salsa.debian.org/debian/bash-completion
    //'bash-completion',
    // Install GNU core utilities (those that come with macOS are outdated)
    // Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
    'coreutils',
    // Utility for managing Mac OS X dock items - https://github.com/kcrawford/dockutil
    'dockutil',
    // Convert text between DOS, UNIX, and Mac formats - https://waterlan.home.xs4all.nl/dos2unix.html
    'dos2unix',
    // Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
    'findutils',
    // Library for command-line editing
    'readline', // ensure gawk gets good readline
    // GNU awk utility - https://www.gnu.org/software/gawk/
    'gawk',
    // http://www.lcdf.org/gifsicle/ (because I'm a gif junky)
    'gifsicle',
    // Good-lookin' diffs for git - https://github.com/so-fancy/diff-so-fancy
    'diff-so-fancy',
    // GNU Pretty Good Privacy (PGP) package - https://gnupg.org/
    'gnupg',
    // Install GNU `sed`, overwriting the built-in `sed`
    // so we can do "sed -i 's/foo/bar/' file" instead of "sed -i '' 's/foo/bar/' file"
    'gnu-sed --with-default-names',
    // better, more recent grep
    'homebrew/dupes/grep',
    // User-friendly cURL replacement (command-line HTTP client) - https://github.com/jkbrzt/httpie
    'httpie',
    // Utility to optimize/compress JPEG files http://www.iki.fi/tjko/projects.html
    //'jpegoptim',
    // jq is a sort of JSON grep
    'jq',
    // Mac App Store CLI: https://github.com/mas-cli/mas
    'mas',
    // Install some other useful utilities like `sponge`
    'moreutils',
    // Port scanning utility for large networks - https://nmap.org/
    'nmap',
    // 'openconnect',
    // Reattach process (e.g., tmux) to background - https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
    'reattach-to-user-namespace',
    // better/more recent version of screen
    'homebrew/dupes/screen',
    //'ssh-copy-id',
    // Terminal multiplexer - https://github.com/tmux/tmux
    'tmux',
    // If you want to get it done, first write it down - http://todotxt.org/
    'todo-txt',
    // Recursive directory listing command - http://mama.indstate.edu/users/ice/tree/
    'tree',
    // Terminal interaction recorder and player - http://0xcc.net/ttyrec/
    'ttyrec',
    // better, more recent vim
    'vim --with-override-system-vi',
    // Command line and full screen utilities for browsing procfs - https://gitlab.com/procps-ng/procps
    'watch',
    // Install wget with IRI support (enable internationalized URI)
    'wget --enable-iri',
    // Download videos from YouTube (and more sites) - https://rg3.github.io/youtube-dl/
    'youtube-dl'
  ],
  cask: [
    //'adium',
    //'amazon-cloud-drive',
    'atom',
    // 'box-sync',
    //'comicbooklover',
    // Get a list of all active short cuts of the current applicatio - https://mediaatelier.com/CheatSheet/
    //'cheatsheet',
    //'diffmerge',
    'docker',
    //'dropbox',
    //'evernote',
    // f.lux - https://justgetflux.com
    'flux',
    'firefox',
    //'gitkraken',
    'google-chrome',
    // Manage your GPG Keychain - https://gpgtools.org/
    'gpg-suite',
    //'ireadfast',
    // Replacement for Terminal and the successor to iTerm - https://www.iterm2.com/
    'iterm2',
    //'little-snitch',
    // Your Personal Ergonomic Assistant - http://www.publicspace.net/MacBreakZ/
    'macbreakz',
    //'java',
    'jumpcut',
    'meld',
    'nextcloud',
    //'micro-snitch',
    'signal',
    //'macvim',
    // Powerful, keyboard-centric window management - http://www.irradiatedsoftware.com/sizeup/
    //'sizeup',
    //'sketchup',
    'slack',
    // A sophisticated text editor for code, markup and prose - https://www.sublimetext.com
    //'sublime',
    // Free Unarchiving Software for macOS - https://theunarchiver.com/
    'the-unarchiver',
    'thunderbird',
    'tunnelblick',
    'torbrowser',
    //'transmission',
    //'visual-studio-code',
    'vlc',
    //'virtualbox'
    //'xquartz'
  ],
  gem: [],
  npm: [
    //'antic',
    //'buzzphrase',
    //'eslint',
    // Instantly preview finnicky markdown files - https://github.com/suan/vim-instant-markdown
    'instant-markdown-d',
    // 'generator-dockerize',
    //'gulp',
    //'npm-check-updates',
    //'prettyjson',
    //'trash',
    'vtop',
    // ,'yo'
  ]
};