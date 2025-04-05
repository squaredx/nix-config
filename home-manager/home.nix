{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./hyprland.nix
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

  # dconf.settings = {
  #   "org/gnome/mutter" = {
  #     edge-tiling = true;
  #   };
  # };

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

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  # Note the different syntax for gtk3 and gtk4
    gtk3.extraConfig = {
      "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
    };
    gtk4.extraConfig = {
      Settings = ''
      gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
    };
  };


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
