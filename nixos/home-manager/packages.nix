{pkgs, ...}: {
  home.packages = with pkgs; [
    # Apps
    # spotify
    # prismlauncher
    # discord

    # inkscape
    # logisim
    # logisim-evolution
    # mars-mips

    # jetbrains.idea
    # jetbrains.idea-oss

    # Yubikey
    # yubikey-manager
    # yubioath-flutter
    # yubikey-personalization
    # pinentry-curses

    anki
    gimp3
    kitty
    libreoffice-qt
    discord
    ungoogled-chromium

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
    # go
    gcc
    gdb
    lldb
    nodejs
    rustup

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
