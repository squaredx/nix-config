{
  pkgs,
  ...
}: {
  programs.chromium = {
    package = pkgs.google-chrome;

    commandLineArgs = [
        # Wayland
        "--ozone-platform=wayland"
        "--ozone-platform-hint=auto"
    ];
  };
}