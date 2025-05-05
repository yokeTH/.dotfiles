
{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home = {
      username = "yoketh";
      stateVersion = "24.11";
  };
}
