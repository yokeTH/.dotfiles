{pkgs, ...}: let
  inherit (pkgs) callPackage;
in [
  (callPackage ../../pkgs/fonts/itim.nix {})
  (callPackage ../../pkgs/fonts/kanit.nix {})
  (callPackage ../../pkgs/fonts/sarabun.nix {})
]
