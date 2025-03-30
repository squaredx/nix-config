{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  nixpkgs = {
    overlays = [
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "jason";
    homeDirectory = "/home/jason";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;

  #programs.kitty.enable = true;
  #wayland.windowManager.hyprland.enable = true; 

  dconf.settings = {
    "org/gnome/mutter" = {
      edge-tiling = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "squaredx";
    userEmail = "jason.wolfe71@gmail.com";
  };

  programs.chromium = {
    package = pkgs.google-chrome;

    commandLineArgs = [
        # Wayland
        "--ozone-platform=wayland"
        "--ozone-platform-hint=auto"
    ];
  };



  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
