module.exports = {
  brew: [
    // Search tool like grep, but optimized for programmers - http://conqueringthecommandline.com/book/ack_ag
    'ack',
    // Code-search similar to ack - https://github.com/ggreer/the_silver_searcher
    'ag',
    // Install GNU core utilities (those that come with macOS are outdated)
    // Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
    'coreutils',
    // Utility for managing Mac OS X dock items - https://github.com/kcrawford/dockutil
    'dockutil',
    // Convert text between DOS, UNIX, and Mac formats - https://waterlan.home.xs4all.nl/dos2unix.html
    'dos2unix',
    // Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
    'findutils',
    // 'fortune',
    // Library for command-line editing
    'readline', // ensure gawk gets good readline
    // GNU awk utility - https://www.gnu.org/software/gawk/
    'gawk',
    // http://www.lcdf.org/gifsicle/ (because I'm a gif junky)
    'gifsicle',
    // GNU Pretty Good Privacy (PGP) package - https://gnupg.org/
    'gnupg',
    // Install GNU `sed`, overwriting the built-in `sed`
    // so we can do "sed -i 's/foo/bar/' file" instead of "sed -i '' 's/foo/bar/' file"
    'gnu-sed --with-default-names',
    // better, more recent grep
    'homebrew/dupes/grep',
    // User-friendly cURL replacement (command-line HTTP client) - https://github.com/jkbrzt/httpie
    'httpie',
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
    // Terminal multiplexer - https://github.com/tmux/tmux
    'tmux',
    // Recursive directory listing command - http://mama.indstate.edu/users/ice/tree/
    'tree',
    // Terminal interaction recorder and player - http://0xcc.net/ttyrec/
    'ttyrec',
    // better, more recent vim
    'vim --with-override-system-vi',
    // Command line and full screen utilities for browsing procfs - https://gitlab.com/procps-ng/procps
    'watch',
    // Install wget with IRI support (enable internationalized URI)
    'wget --enable-iri'
  ],
  cask: [
    //'adium',
    //'amazon-cloud-drive',
    'atom',
    // 'box-sync',
    //'comicbooklover',
    //'diffmerge',
    'docker',
    //'dropbox',
    //'evernote',
    'firefox',
    //'gitkraken',
    // Manage your GPG Keychain - https://gpgtools.org/
    'gpg-suite',
    //'ireadfast',
    // Replacement for Terminal and the successor to iTerm - https://www.iterm2.com/
    'iterm2',
    //'little-snitch',
    'jumpcut',
    'meld',
    'nextcloud',
    //'micro-snitch',
    //'macvim',
    // Powerful, keyboard-centric window management - http://www.irradiatedsoftware.com/sizeup/
    //'sizeup',
    //'sketchup',
    'slack',
    // A sophisticated text editor for code, markup and prose - https://www.sublimetext.com
    //'sublime',
    // Free Unarchiving Software for macOS - https://theunarchiver.com/
    'the-unarchiver',
    'tunnelblick',
    'torbrowser',
    //'transmission',
    'vlc',
    //'virtualbox'
    //'xquartz'
  ],
  gem: [
    //'git-up'
  ],
  npm: [
    //'antic',
    //'buzzphrase',
    //'eslint',
    // Instantly preview finnicky markdown files - https://github.com/suan/vim-instant-markdown
    'instant-markdown-d',
    // 'generator-dockerize',
    //'gulp',
    //'npm-check',
    //'prettyjson',
    //'trash',
    'vtop',
    // ,'yo'
  ]
};