{pkgs, ...}:
with pkgs; [
  (callPackage ./lib/fonts/itim.nix)
  (callPackage ./lib/fonts/kanit.nix)
  (callPackage ./lib/fonts/sarabun.nix)
]
