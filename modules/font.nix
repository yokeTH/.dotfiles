{pkgs, ...}: let
  cadson = import ./font/cadsondemak.nix {inherit pkgs;};
  nerd = import ./font/nerd.nix {inherit pkgs;};
in {
  fonts.packages = pkgs.lib.unique (cadson ++ nerd);
}
