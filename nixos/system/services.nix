{pkgs, ...}: {
  # services.slurm = {
  #   server.enable = true;
  #   client.enable = true;
  #   controlMachine = "oskar-nixos";
  #   nodeName = [ "oskar-nixos CPUs=4 State=UNKNOWN" ];
  #   partitionName = [ "default Nodes=oskar-nixos Default=YES MaxTime=INFINITE State=UP" ];
  #   extraConfig = ''
  #     MailProg=/run/current-system/sw/bin/true
  #   '';
  # };

  # services.munge = {
  #   enable = true;
  #   password = "/etc/munge/munge.key";
  # };

  virtualisation = {
    # Enable docker
    # docker.enable = true;

    # waydroid.enable = true;
  };
  systemd.services.waydroid-container = {
    path = with pkgs; [wl-clipboard xclip];
  };

  # Disable waiting for Network Manager at boot.
  systemd.services.NetworkManager-wait-online.enable = false;

  services = {
    # Enalbe fstrim.
    fstrim.enable = true;

    # Enable the blueman interface.
    blueman.enable = true;

    # Configure keymaps in X11 and console.
    xserver = {
      autorun = false;
      videoDrivers = ["intel"];
      xkb = {
        layout = "de";
        variant = "mac";
        options = "caps:escape";
      };
    };

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      browsing = true;
      drivers = [
        pkgs.gutenprint
        pkgs.brlaser
        pkgs.epson-escpr
        pkgs.epson-escpr2
      ];
    };

    # Enable SANE to scan documents.
    saned = {
      enable = true;
    };

    # Enable printer discovery.
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Enable sound (pulseaudio or pipewire).
    # hardware.pulseaudio.enable = false;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
    };

    # Enable power profiles daemon (conflicts with tlp).
    # Also include powerprofilesctl package.
    # power-profiles-daemon.enable = true;

    # Enable tlp power management (conflicts with power profiles daemon).
    tlp = {
      enable = true;
      settings = {
        INTEL_GPU_MIN_FREQ_ON_AC = 500;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";

        START_CHARGE_THRESH_BAT0 = 60;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };

    # Enable automatic disk mounting.
    devmon.enable = true;

    # Handles disk mounting operations.
    udisks2.enable = true;

    # Smart card daemon
    pcscd.enable = true;

    # Login options
    logind.settings.Login = {
      KillUserProcesses = true;
      LidSwitch = "suspend";
      LidSwitchDocked = "ignore";
      LidSwitchExternalPower = "suspend";
      PowerKey = "ignore";
      PowerKeyLongPress = "poweroff";
    };
  };

  # Mute volume when connecting to a wifi network
  environment.etc."NetworkManager/dispatcher.d/60-mute-on-network-connection".source = pkgs.writeScript "mute-on-network-connection" ''
    #!/bin/sh

    # Check if the event is "up"
    if [ "$2" = "up" ]; then
      # Optionally filter by SSID
      # SSID=$(/run/current-system/sw/bin/nmcli -t -f NAME con show --active | head -1)

      # Set user runtime dir for dbus connection
      export XDG_RUNTIME_DIR=$(ls -d /run/user/[0-9]* 2>/dev/null | head -1)

      /run/current-system/sw/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
    fi
  '';
}
