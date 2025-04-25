{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  #Enable plasma
  services.desktopManager.plasma6.enable = true;
}