{
  pkgs,
  ...
}: {
  imports = [
    ./chrome
    ./git
    ./stylix
    ./default-applications.nix
  ];

  home = {
    username = "jason";
    homeDirectory = "/home/jason";

    # packages = {

    # };
  };
  # dconf.settings = {
  #   "org/gnome/mutter" = {
  #     edge-tiling = true;
  #   };
  # };

  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Classic";
  #   size = 16;
  # };

  # gtk = {
  #   enable = true;
  #   cursorTheme = {
  #     name = "Bibata-Modern-Classic";
  #     package = pkgs.bibata-cursors;
  #   };
  #   iconTheme = {
  #     package = pkgs.adwaita-icon-theme;
  #     name = "Adwaita";
  #   };
  #   # Note the different syntax for gtk3 and gtk4
  #   gtk3.extraConfig = {
  #     "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
  #   };
  #   gtk4.extraConfig = {
  #     Settings = ''
  #     gtk-cursor-theme-name=Bibata-Modern-Classic
  #     '';
  #   };
  # };

  services.easyeffects = {
    enable = true;
  };

  programs.home-manager.enable = true;

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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}