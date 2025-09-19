{pkgs, ...}: let
  inherit (pkgs) callPackage;
in [
  (callPackage ../../lib/fonts/itim.nix {})
  (callPackage ../../lib/fonts/kanit.nix {})
  (callPackage ../../lib/fonts/sarabun.nix {})
]
