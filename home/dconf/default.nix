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

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "close,minimize,maximize:";
      };
    };
  };
}