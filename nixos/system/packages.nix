{
  pkgs,
  overlay-unstable,
  ...
}: {
  nixpkgs = {
    # Allow non-free software
    config.allowUnfree = true;

    # Enable unstable packages
    # Accessible through pkgs.unstable.<package>
    overlays = [
      overlay-unstable
    ];

    # Compile glfw with wayland patches
    config.packageOverrides = pkgs: {
      glfw = pkgs.glfw.overrideAttrs (oldAttrs: {
        cmakeFlags =
          oldAttrs.cmakeFlags
          or []
          ++ [
            "-DGLFW_BUILD_WAYLAND=ON"
            "-DGLFW_BUILD_X11=OFF"
            "-DCMAKE_BUILD_TYPE=Release"
            "-DBUILD_SHARED_LIBS=ON"
            "-DCMAKE_C_FLAGS=-O3 -march=native -pipe"
            "-DCMAKE_CXX_FLAGS=-O3 -march=native -pipe"
          ];
      });
    };
  };

  environment.systemPackages = with pkgs; [
    # Apps & GUI
    anki
    chromium
    discord
    gimp3
    kitty
    libreoffice-qt
    obsidian
    # vscode
    prismlauncher
    # inkscape
    # spotify
    # ungoogled-chromium

    # Bluetooth
    bluez
    bluez-tools

    # Desktop & Wayland Environment
    hypridle
    hyprlock
    hyprpicker
    hyprshot
    mako
    playerctl
    pw-volume
    pywal
    waybar
    wl-clipboard
    wofi
    yad

    # Development & Programming
    unstable.github-copilot-cli
    cmake
    gcc
    gdb
    gnumake
    graalvmPackages.graalvm-ce
    lldb
    nodejs
    rustup
    subversion
    tree-sitter
    # go
    # jetbrains.idea
    # jetbrains.idea-oss
    # kotlin
    # kotlin-language-server
    # logisim
    # logisim-evolution
    # mars-mips
    (pkgs.python314.withPackages (p: [
      p.ipywidgets
      p.jupyterlab
      p.matplotlib
      p.notebook
      p.numpy
      p.pandas
      p.requests
      p.scikit-learn
      p.seaborn
    ]))

    # Dictionary
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US-large

    # Disk & System Configuration
    acpi
    brightnessctl
    cryptsetup
    efibootmgr
    glfw
    intel-gpu-tools
    libva-utils
    socat
    vdpauinfo
    # Conflicts with tlp
    # powerprofilesctl

    # Git
    git
    git-crypt
    git-filter-repo
    git-remote-gcrypt
    gitmux

    # Hytale
    # blockbench
    # icu70 # required by hytale
    # inputs.hytale-launcher.packages.${pkgs.system}.default

    # Man Pages
    man-pages
    man-pages-posix

    # Networking & Syncing
    curl
    dig
    rclone
    sshfs
    unison
    wget

    # PDF & TeX
    poppler-utils
    texlab
    texliveFull
    zathura

    # Scanner
    sane-airscan
    sane-backends
    simple-scan

    # Security & Yubikey
    pinentry-curses
    yubikey-manager
    yubikey-personalization
    yubioath-flutter

    # Terminal & CLI Tools
    bash-completion
    bat
    bc
    btop
    dua
    dust
    eza
    fd
    file
    fzf
    jq
    patchelf
    qmk
    ripgrep
    ripgrep-all
    tmux
    tree
    unzip
    vim
  ];
}
