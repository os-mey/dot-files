{
  pkgs,
  inputs,
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
    # Tools
    bash-completion
    bc
    file
    intel-gpu-tools
    jq
    libva-utils
    patchelf
    subversion
    tree
    vdpauinfo
    vim
    tree-sitter

    graalvmPackages.graalvm-ce
    sshfs
    vscode

    # kotlin
    # kotlin-language-server
    # (pkgs.python312.withPackages (p: [
    #   p.ipywidgets
    #   p.jupyterlab
    #   p.matplotlib
    #   p.notebook
    #   p.numpy
    #   p.pandas
    #   p.requests
    #   p.scikit-learn
    #   p.seaborn
    # ]))

    # Hytale
    # blockbench
    # inputs.hytale-launcher.packages.${pkgs.system}.default
    # icu70 # required by hytale

    # Git
    git
    git-crypt
    git-filter-repo
    git-remote-gcrypt

    # Disk
    cryptsetup
    efibootmgr

    # Networking
    curl
    dig
    wget

    # System
    acpi
    brightnessctl
    glfw
    socat

    # Conflicts with tlp
    # powerprofilesctl

    # Bluetooth
    bluez
    bluez-tools

    # Scanner
    sane-airscan
    sane-backends
    simple-scan

    # Hyprland
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    hyprsunset
    wl-clipboard
  ];
}
