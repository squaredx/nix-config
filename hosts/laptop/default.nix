{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common/gnome.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Use latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Load Xe kernel module2
  boot.initrd.kernelModules = [ "xe"  ];

  # Set Networking
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Regina";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure your system-wide user settings
  users.users = {
    jason = {
      isNormalUser = true;
      description = "Jason";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
  }; 

  # Enable podman (for distrobox)
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # For Audio??
  security.rtkit.enable = true;
  security.polkit.enable = true;

  # Hardware configuration
  hardware = {
    # Setup bluetooh
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    # Setup graphics 
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        vpl-gpu-rt
      ];
    };
    # Disable pulseaudio
    pulseaudio.enable = false;
  };

  services = {
    # Enable power-profile-daemon
    power-profiles-daemon.enable = true;
    # Enable CUPS to print documents.
    printing.enable = true;
    # Printer discovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Enable sound with pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable flatpaks
    flatpak.enable = true;
  };

  # Fonts!
  fonts.packages = with pkgs; [
    corefonts
    nerd-fonts.fira-code
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  environment = {
    sessionVariables = {
      # For electron apps
      NIXOS_OZONE_WL = "1";
      #proton
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/jason/.steam/root/compatibilitytools.d";
      # for Gnome virtual fs
      #GIO_EXTRA_MODULES = "${pkgs.gvfs}/lib/gio/modules";
    };

    systemPackages = with pkgs; [
      git
      kitty
      neovim
      vscode
      google-chrome
      librewolf
      rawtherapee
      appimage-run # AppImage Runner
      cmake # CMake
      coreutils # GNU Core Utilities
      dconf # DConf Editor
      gcc # GNU Compiler Collection
      lm_sensors # sensors
      lshw # Hardware List
      rclone # cloud storage client
      traceroute # Network Traceroute
      tree # List directories recursively
      unzip # Unzip files
      usbutils # Provides lsusb
      wget # Web Downloader
      xdg-user-dirs
      libva-utils # vainfo
      vdpauinfo # VDPAU (Video Decode and Presentation API for Unix)
      vulkan-tools # vulkaninfo
      mpv # video player
      protonup-qt # proton manager
      bottles
      powertop # power monitor
      btop # system monitor
      networkmanagerapplet #managing network
      gamescope
      nvtopPackages.intel #gpu top
      direnv
      tinygo
      go
      gnumake
      distrobox
      imagemagick
      python3
    ];
  };

  programs = {
    # Gamemode for games
    gamemode.enable = true;
    # Localsend for sending files
    localsend = {
      enable = true;
      openFirewall = true;
    };
    #enable zsh
    zsh.enable = true;

    #Misc
    nix-ld.enable = true;
  };

  #Override for steam
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };
}