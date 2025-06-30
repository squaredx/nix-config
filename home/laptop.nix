{
  pkgs,
  ...
}: {
  imports = [
    ./chrome
    ./fish
    ./git
    ./ghostty
    ./starship
    ./stylix
    ./dconf
    ./default-applications.nix
  ];

  home = {
    username = "jason";
    homeDirectory = "/home/jason";

    sessionPath = [
      "$HOME/.local/bin"
    ];
    # packages = {

    # };
  };
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