{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    starship
  ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}