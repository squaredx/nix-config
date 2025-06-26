{
  pkgs,
  ...
}: {
  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    pop-shell
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell/extensions/pop-shell" = {
        active-hint = true;
      };
    };
  };
}