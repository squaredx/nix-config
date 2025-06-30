{
  ...
}: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Disable greeting message
      set -g fish_greeting
    '';

    shellAliases = {
      # Override default editors with nvim
      n    = "nvim";
      vi   = "nvim";
      vim  = "nvim";
      nano = "nvim";

    };

    shellAbbrs = {
      # nix and home manager
      ncg = "nix-collect-garbage";

      hms = "home-manager switch --flake .#jason@laptop";

      nbs = "sudo nixos-rebuild switch --flake .#laptop";
      nbb = "sudo nixos-rebuild boot --flake .#laptop";
    };
  };
}