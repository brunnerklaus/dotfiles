module.exports = {
  brew: [
    // Search tool like grep, but optimized for programmers - http://conqueringthecommandline.com/book/ack_ag
    'ack',
    // Code-search similar to ack - https://github.com/ggreer/the_silver_searcher
    'ag',
    // https://github.com/wting/autojump
    'autojump',
    // alternative to `cat`: https://github.com/sharkdp/bat
    'bat',
    // Record and share terminal sessions - https: //asciinema.org
    //'asciinema',
    // Binwalk is a fast, easy to use tool for analyzing, reverse engineering-  https: //github.com/ReFirmLabs/binwalk
    //'binwalk',
    // Programmable completion for Bash 3.2 - https://salsa.debian.org/debian/bash-completion
    //'bash-completion',
    // Install GNU core utilities (those that come with macOS are outdated)
    // Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
    // GNU File, Shell, and Text utilities - https://www.gnu.org/software/coreutils/coreutils.html
    'coreutils',
    // ccat is the colorizing cat. It works similar to cat but displays content with syntax highlighting.
    'ccat',
    // Curl - Get a file from an HTTP, HTTPS or FTP server - https://curl.haxx.se/
    'curl --with-openssl',
    // Utility for managing Mac OS X dock items - https://github.com/kcrawford/dockutil
    'dockutil',
    // Convert text between DOS, UNIX, and Mac formats - https://waterlan.home.xs4all.nl/dos2unix.html
    'dos2unix',
    // Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed - https://www.gnu.org/software/findutils/
    'findutils',
    // fuzzy find
    'fzf',
    // TCP / IP packet demultiplexer - https: //github.com/simsong/tcpflow
    'tcpflow',
    // Library for command-line editing - https://tiswww.case.edu/php/chet/readline/rltop.html
    'readline', // ensure gawk gets good readline
    // GNU awk utility - https://www.gnu.org/software/gawk/
    'gawk',
    // Glances an Eye on your system. A top/htop alternative
    'glances',
    // http://www.lcdf.org/gifsicle/ (because I'm a gif junky)
    'gifsicle',
    // Good-lookin' diffs for git - https://github.com/so-fancy/diff-so-fancy
    'diff-so-fancy',
    // GNU Pretty Good Privacy (PGP) package - https://gnupg.org/
    'gnupg',
    // Install GNU `sed`, overwriting the built-in `sed`
    // so we can do "sed -i 's/foo/bar/' file" instead of "sed -i '' 's/foo/bar/' file"
    // GNU implementation of the famous stream editor - https://www.gnu.org/software/sed/
    'gnu-sed --with-default-names',
    // upgrade grep so we can get things like inverted match (-v)
    'grep --with-default-names',
    // Improved top (interactive process viewer) - https://hisham.hm/htop/
    'htop',
    // better, more recent grep
    'homebrew/dupes/grep',
    // Open source programming language - https://golang.org
    'go',
    // User-friendly cURL replacement (command-line HTTP client) - https://github.com/jkbrzt/httpie
    'httpie',
    // Utility to optimize/compress JPEG files http://www.iki.fi/tjko/projects.html
    //'jpegoptim',
    // Lightweight and flexible command-line JSON processor - https://stedolan.github.io/jq/
    'jq',
    // Mac App Store CLI - https://github.com/mas-cli/mas
    'mas',
    // lsp is like ls command but more human-friendly
    'lsp',
    // Install some other useful utilities like `sponge` - https://joeyh.name/code/moreutils/
    'moreutils',
    // Intercept, modify, replay, save HTTP / S traffic - https: //mitmproxy.org
    'mitmproxy',
    // traceroute and ping in a single tool - https: //www.bitwizard.nl/mtr/
    'mtr --with-glib',
    // Network grep - https://github.com/jpr5/ngrep
    'ngrep',
    // Port scanning utility for large networks - https://nmap.org/
    'nmap',
    // 'openconnect',
    // Tiny date, time diff calculator with timers
    'pdd',
    //Linux tool to show progress for cp, rm, dd, and more...
    'progress',
    // Reattach process (e.g., tmux) to background - https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
    'reattach-to-user-namespace',
    // better/more recent version of screen
    'homebrew/dupes/screen',
    //'ssh-copy-id',
    // Man - in -the - middle attacks against SSL encrypted network connection - https://formulae.brew.sh/formula/sslsplit
    'sslsplit',
    // Command - line interface bandwidth tests - https://github.com/sivel/speedtest-cli
    'speedtest-cli',
    // Terminal multiplexer - https://github.com/tmux/tmux
    'tmux',
    // If you want to get it done, first write it down - http://todotxt.org/
    'todo-txt',
    // Recursive directory listing command - http://mama.indstate.edu/users/ice/tree/
    'tree',
    // Terminal interaction recorder and player - http://0xcc.net/ttyrec/
    'ttyrec',
    // better, more recent vim
    'vim --with-client-server --with-override-system-vi',
    // Command line and full screen utilities for browsing procfs - https://gitlab.com/procps-ng/procps
    'watch',
    // Install wget with IRI support (enable internationalized URI)
    'wget --enable-iri',
    // Get the password of the wifi you're on (bash) - https://github.com/rauchg/wifi-password
    //'wifi-password'
    // Download videos from YouTube (and more sites) - https://rg3.github.io/youtube-dl/
    'youtube-dl'
  ],
  cask: [
    //'adobe-creative-cloud',
    //'adium',
    //'amazon-cloud-drive',
    'atom',
    // Padbury Clock
    //'padbury-clock',
    // 'box-sync',
    //'comicbooklover',
    // https://github.com/borgbackup/borgbackup.github.io
    'borgbackup',
    // Get a list of all active short cuts of the current application - https://mediaatelier.com/CheatSheet/
    'cheatsheet',
    //'diffmerge',
    'docker', // docker for mac
    'dropbox',
    //'evernote',
    // f.lux - https://justgetflux.com
    'flux',
    'filezilla',
    'firefox',
    //'gitkraken',
    'google-chrome',
    // Manage your GPG Keychain - https://gpgtools.org/
    'gpg-suite',
    'intel-power-gadget',
    //'ireadfast',
    // Replacement for Terminal and the successor to iTerm - https://www.iterm2.com/
    'iterm2',
    //'little-snitch',
    // Your Personal Ergonomic Assistant - http://www.publicspace.net/MacBreakZ/
    //'macbreakz',
    //'java',
    //'kitematic',
    'jumpcut',
    // A native OS X KeePass client https://macpassapp.org
    //'macpass',
    'meld',
    //OS X player for The Hype Machine
    //'plug',
    'nextcloud',
    'signal',
    //'macvim',
    // Powerful, keyboard-centric window management - http://www.irradiatedsoftware.com/sizeup/
    //'sizeup',
    //'sketchup',
    //'slack',
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
    //'virtualbox',
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
    // 'gulp',
    'npm-check-updates',
    'prettyjson',
    //'trash',
    'vtop',
    // ,'yo'
  ],
  mas: [
    //Keynote
    '409183694',
    //iMovie
    '408981434',
    //Pages
    '409201541',
    //Numbers
    '409203825',
    //com.apple.dt.Xcode
    '497799835',
    //Encrypto https://macpaw.com/encrypto
    '935235287',
    //Helium https://heliumfloats.com/
    '1054607607'
  ],
};
