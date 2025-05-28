# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    #./features/hyprland.nix
    #./features/kde.nix
    ./features/gnome.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
  
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Use latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Load Xe kernel module2
  boot.initrd.kernelModules = [ "xe"  ];

  # Set Networking
  networking.hostName = "nixos-laptop";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Regina";

  # Enable podman (for distrobox)
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  
  # Bluetooth hardware
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Intel vulkan and opencl packages?
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };

  # Enable power-profile-daemon
  services.power-profiles-daemon.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable ZSH
  programs.zsh.enable = true;

  environment.sessionVariables = {
    # For electron apps
    NIXOS_OZONE_WL = "1";
    #proton
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/jason/.steam/root/compatibilitytools.d";
    # for Gnome virtual fs
    #GIO_EXTRA_MODULES = "${pkgs.gvfs}/lib/gio/modules";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    corefonts
    fira-code
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  # Enable flatpak
  services.flatpak.enable = true;

  # Configure your system-wide user settings
  users.users = {
    jason = {
      isNormalUser = true;
      description = "Jason";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
  }; 

  programs.steam = {
    enable = true;
  };

  # Game mode
  programs.gamemode.enable = true;

  # Localsend
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
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
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
