module.exports = {
  brew: [
    // Search tool like grep, but optimized for programmers - http://conqueringthecommandline.com/book/ack_ag
    // 'ack',
    // Code-search similar to ack - https://github.com/ggreer/the_silver_searcher
    // 'ag',
    // Application launcher and productivity software - https://www.alfredapp.com/
    'alfred',
    // 'ansible',
    // 'ansible-lint',
    // Tool for generating GNU Standards-compliant Makefiles - https://www.gnu.org/software/automake/
    'automake',
    // a faster way to navigate your filesystem - https://github.com/wting/autojump
    'autojump',
    // command line interface to Amazon Web Services
    // 'awscli',
    // 'awslogs',
    // 'aws-shell',
    // 'awsume',
    // 'aws-sam-cli',
    // alternative to `cat`: https://github.com/sharkdp/bat
    'bat',
    // Record and share terminal sessions - https: //asciinema.org
    //'asciinema',
    // Binwalk is a fast, easy to use tool for analyzing, reverse engineering-  : //github.com/ReFirmLabs/binwalk
    //'binwalk',
    // Programmable completion for Bash 3.2 - https://salsa.debian.org/debian/bash-completion
    //'bash-completion',
    // Install GNU core utilities (those that come with macOS are outdated)
    // Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
    // GNU File, Shell, and Text utilities - https://www.gnu.org/software/coreutils/coreutils.html
    // Deduplicating archiver with compression and authenticated encryption - https://borgbackup.org/
    //'borgbackup',
    'coreutils',
    // ccat is the colorizing cat. It works similar to cat but displays content with syntax highlighting.
    // 'ccat',
    // Curl - Get a file from an HTTP, HTTPS or FTP server - https://curl.haxx.se/
    'curl --with-openssl',
    // Utility for managing Mac OS X dock items - https://github.com/kcrawford/dockutil
    // 'dockutil',
    // Command-line DNS client - https://dns.lookup.dog/
    'dog',
    // Convert text between DOS, UNIX, and Mac formats - https://waterlan.home.xs4all.nl/dos2unix.html
    // 'dos2unix',
    //Modern replacement for 'ls'
    // 'exa',
    // Play, record, convert, and stream audio and video - https://ffmpeg.org/
    'ffmpeg --with-libvpx',
    // Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed - https://www.gnu.org/software/findutils/
    'findutils',
    // Command-line fuzzy finder written in Go - https://github.com/junegunn/fzf
    'fzf',
    // TCP / IP packet demultiplexer - https: //github.com/simsong/tcpflow
    // 'tcpflow',
    // Library for command-line editing - https://tiswww.case.edu/php/chet/readline/rltop.html
    // 'readline', // ensure gawk gets good readline
    // GNU awk utility - https://www.gnu.org/software/gawk/
    'gawk',
    // Interactive command-line tool for using emoji in commit messages
    'gitmoji',
    // A viewer for git and diff output
    'git-delta',
    // Open GitHub webpages from a terminal - https://github.com/jeffreyiacono/git-open
    'git-open',
    // Glances an Eye on your system. A top/htop alternative
    'glances',
    // http://www.lcdf.org/gifsicle/ (because I'm a gif junky) - https://github.com/kohler/gifsicle
    // 'gifsicle',
    // Good-lookin' diffs for git - https://github.com/so-fancy/diff-so-fancy
    'diff-so-fancy',
    // GNU Pretty Good Privacy (PGP) package - https://gnupg.org/
    'gnupg',
    // Install GNU `sed`, overwriting the built-in `sed`
    // so we can do "sed -i 's/foo/bar/' file" instead of "sed -i '' 's/foo/bar/' file"
    // GNU implementation of the famous stream editor - https://www.gnu.org/software/sed/
    'gnu-sed --with-default-names',
    // upgrade grep so we can get things like inverted match (-v)
    // 'gopass',
    // GNU grep, egrep and fgrep - https://www.gnu.org/software/grep/
    'grep',
    // Improved top (interactive process viewer) - https://hisham.hm/htop/
    'htop',
    // better, more recent grep
    // 'homebrew/dupes/grep',
    // Open source programming language - https://golang.org
    // 'go',
    // User-friendly cURL replacement (command-line HTTP client) - https://github.com/jkbrzt/httpie
    // 'httpie',
    // Utility to optimize/compress JPEG files http://www.iki.fi/tjko/projects.html
    //'jpegoptim',
    // Tools and libraries to manipulate images in many formats - https://imagemagick.org/index.php
    'imagemagick --with-webp',
    // HTTP and GraphQL Client - https://insomnia.rest/
    // 'insomnia',
    // Lightweight and flexible command-line JSON processor - https://stedolan.github.io/jq/
    'jq',
    // kubectx + kubens: Power tools for kubect - https://github.com/ahmetb/kubectx
    // 'kubectx',
    // Kubernetes command-line interface - https://kubernetes.io/
    // 'kubernetes-cli',
    // Kubernetes CLI To Manage Your Clusters In Style!
    // 'k9s',
    // kubecolor
    // 'jjuarez/homebrew-tap-1/kubecolor',
    // Mac App Store CLI - https://github.com/mas-cli/mas
    'mas',
    // lsp is like ls command but more human-friendly
    // 'lsp',
    // Install some other useful utilities like `sponge` - https://joeyh.name/code/moreutils/
    'moreutils',
    // Intercept, modify, replay, save HTTP / S traffic - https: //mitmproxy.org
    // 'mitmproxy',
    // traceroute and ping in a single tool - https: //www.bitwizard.nl/mtr/
    'mtr --with-glib',
    // Network grep - https://github.com/jpr5/ngrep
    // 'ngrep',
    // 'mysql-client',
    // Fast, highly customisable system info script - https://github.com/dylanaraps/neofetch
    'neofetch',
    // Port scanning utility for large networks - https://nmap.org/
    'nmap',
    // OpenBSD freely-licensed SSH connectivity tools - https://www.openssh.com/
    'openssh',
    // Cryptography and SSL/TLS Toolkit - https://openssl.org/
    'openssl@1.1',
    // 'openconnect',
    // Tiny date, time diff calculator with timers
    'pdd',
    //Linux tool to show progress for cp, rm, dd, and more...
    'progress',
    // Pretty, minimal and fast ZSH prompt - https://github.com/sindresorhus/pure
    // 'pure',
    // Password generator - https://pwgen.sourceforge.io/
    'pwgen',
    // Utility that provides fast incremental file transfer - https://rsync.samba.org/
    'rsync',
    // Reattach process (e.g., tmux) to background - https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
    // 'reattach-to-user-namespace',
    // Kubernetes package manager - https://helm.sh/
    // 'helm',
    // better/more recent version of screen
    // 'homebrew/dupes/screen',
    // Terminal multiplexer with VT100/ANSI terminal emulation - https://www.gnu.org/software/screen
    'screen',
    // Static analysis and lint tool, for (ba)sh scripts - https://www.shellcheck.net/
    'shellcheck',
    //'ssh-copy-id',
    // Man - in -the - middle attacks against SSL encrypted network connection - https://formulae.brew.sh/formula/sslsplit
    // 'sslsplit',
    // Command - line interface bandwidth tests - https://github.com/sivel/speedtest-cli
    'speedtest-cli',
    // starship ZSH theme
    // 'starship',
    // 'terraform', // replaced by tfswitch
    // 'terraformer',
    // 'terragrunt',
    // 'terraform-docs',
    // 'terraform_landscape',
    // 'iam-policy-json-to-terraform',
    // 'tf-lint',
    // Tool for creating identical machine images for multiple platforms - https://packer.io
    // 'packer',
    // Terminal multiplexer - https://github.com/tmux/tmux
    'tmux',
    // If you want to get it done, first write it down - http://todotxt.org/
    //'todo-txt',
    // Recursive directory listing command - http://mama.indstate.edu/users/ice/tree/
    'tree',
    // Terminal interaction recorder and player - http://0xcc.net/ttyrec/
    //'ttyrec',
    // better, more recent vim
    // 'vim --with-client-server --with-override-system-vi',
    // Ambitious Vim-fork focused on extensibility and agility - https://neovim.io/
    'neovim',
    // Command line and full screen utilities for browsing procfs - https://gitlab.com/procps-ng/procps
    'watch',
    // Install wget with IRI support (enable internationalized URI)
    'wget --enable-iri',
    // Image format providing lossless and lossy compression for web images - https://developers.google.com/speed/webp/
    // 'webp',
    // Get the password of the wifi you're on (bash) - https://github.com/rauchg/wifi-password
    //'wifi-password'
    // Download videos from YouTube (and more sites) - https://rg3.github.io/youtube-dl/
    'youtube-dl',
    // Tool for managing your YubiKey configuration - https://developers.yubico.com/yubikey-manager/
    'ykman',
    // New zlib (gzip, deflate) compatible compressor - https://github.com/google/zopfli
    // 'zopfli',
  ],
  cask: [
    //'adobe-creative-cloud',
    //'adium',
    //'amazon-cloud-drive',
    // 'atom',
    // 'aws-vault',
    // Padbury Clock
    //'padbury-clock',
    // 'box-sync',
    //'comicbooklover',
    // Server and cloud storage browser - https://cyberduck.io/
    // 'cyberduck',
    // Get a list of all active short cuts of the current application - https://mediaatelier.com/CheatSheet/
    // 'cheatsheet',
    //'coconutbattery',
    //'diffmerge',
    // docker for mac
    //'docker',
    'dropbox',
    // f.lux - https://justgetflux.com
    //'flux',
    //'filezilla',
    'firefox',
    // Tool to create GIFs from videos - https://www.gifrocket.com/
    // 'gifrocket',
    // Update multiple git repositories at once - https://github.com/earwig/git-repo-updater
    // 'gitup',
    //'gitkraken',
    'google-chrome',
    // Manage your GPG Keychain - https://gpgtools.org/
    // 'gpg-suite',
    // The modern media player for macOS - https://iina.io/
    'iina',
    //'intel-power-gadget',
    //'ireadfast',
    // Replacement for Terminal and the successor to iTerm - https://www.iterm2.com/
    'iterm2',
    // Your Personal Ergonomic Assistant - http://www.publicspace.net/MacBreakZ/
    //'macbreakz',
    // Calculator and converter application - https://numi.app/
    // 'numi',
    //'java',
    //'kitematic',
    // 'jumpcut',
    // the macOS file archiver - https://www.keka.io/en/
    // 'keka',
    // 'p7zip', //dependencies for keka
    // Host-based application firewall - https://www.obdev.at/products/littlesnitch/index.html
    'little-snitch',
    // A native OS X KeePass client https://macpassapp.org
    // Password manager app - https://keepassxc.org/
    'keepassxc',
    //'macpass',
    // 'meld',
    // App to write, plan, collaborate, and get organized - https://www.notion.so/
    'notion',
    //OS X player for The Hype Machine
    //'plug',
    //'nextcloud',
    //'phpstorm',
    // Imaging utility to install operating systems to a microSD card - https://www.raspberrypi.org/downloads/
    // 'raspberry-pi-imager',
    'rectangle',
    'signal',
    // 'spotify',
    //'macvim',
    // Powerful, keyboard-centric window management - http://www.irradiatedsoftware.com/sizeup/
    //'sizeup',
    //'sketchup',
    // 'slack',
    // macOS system monitor in your menu bar - https://github.com/exelban/stats
    // 'stats',
    // A sophisticated text editor for code, markup and prose - https://www.sublimetext.com
    //'sublime',
    // Free Unarchiving Software for macOS - https://theunarchiver.com/
    //'the-unarchiver', replaced with keka
    // Customizable email client - https://www.thunderbird.net/
    'thunderbird',
    // 'tunnelblick',
    //'torbrowser',
    //'transmission',
    'visual-studio-code',
    //'vlc',
    //'virtualbox',
    // Lossless audio decoder - https://tmkk.undo.jp/xld/index_e.html
    // 'xld',
    //'xquartz'
    // Video communication and virtual meeting platform - https://www.zoom.us/
    // 'zoom',
  ],
  gem: [],
  npm: [
    // 'alfred-amphetamine',
    //'antic',
    //'buzzphrase',
    //'eslint',
    // Instantly preview finnicky markdown files - https://github.com/suan/vim-instant-markdown
    'instant-markdown-d',
    // 'generator-dockerize',
    // 'gulp',
    'npm-check',
    'npm-check-updates',
    'prettyjson',
    //'trash',
    'vtop',
    // ,'yo'
  ],
  mas: [
    //Keynote
    // '409183694',
    //iMovie
    // '408981434',
    //Pages
    // '409201541',
    //Numbers
    // '409203825',
    //com.apple.dt.Xcode
    // '497799835',
    //Encrypto https://macpaw.com/encrypto
    // '935235287',
    //Helium https://heliumfloats.com/
    // '1054607607'
    // Black Magic Disk Speed Test
    // '425264550'
  ],
};
