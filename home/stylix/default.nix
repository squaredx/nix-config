{
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = {
      base00 = "000000";
      base01 = "0f0f0f";
      base02 = "3c3835";
      base03 = "504945";
      base04 = "bdae93";
      base05 = "d5c4a1";
      base06 = "ebdbb2";
      base07 = "fbf1c7";
      base08 = "fb4934";
      base09 = "fe8019";
      base0A = "fabd2f";
      base0B = "b8bb26";
      base0C = "8ec07c";
      base0D = "83a598";
      base0E = "d3869b";
      base0F = "d65d0e";
    };
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.noto-fonts;
        name = "DejaVu Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    targets = {
      gtk = {
        enable = true;
      };
    };
  };
}