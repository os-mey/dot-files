{pkgs, ...}: {
  home.packages = with pkgs; [
    # Apps
    anki
    gimp3
    kitty
    libreoffice-qt
    spotify
    ungoogled-chromium
    prismlauncher

    # discord
    # inkscape
    # logisim
    # logisim-evolution
    # mars-mips

    # Yubikey
    yubikey-manager
    yubioath-flutter
    yubikey-personalization
    pinentry-curses

    # Tools
    bat
    btop
    cmake
    dust
    dua
    eza
    fd
    fzf
    gitmux
    gnumake
    qmk
    ripgrep
    ripgrep-all
    tmux
    unzip
    wl-clipboard

    # Notes
    unison
    rclone
    obsidian

    # Man pages
    man-pages
    man-pages-posix

    # Pdf tools
    poppler-utils
    texlab
    texliveFull
    zathura

    # Language-specific tools
    gcc
    gdb
    lldb
    nodejs
    rustup
    (pkgs.python312.withPackages (p: [
      p.numpy
    ]))

    # Desktop tools
    mako
    playerctl
    pw-volume
    pywal
    waybar
    wofi
    yad

    # Dictionary
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US-large
  ];
}
