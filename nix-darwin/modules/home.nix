{
  config,
  pkgs,
  ...
}: {
  programs.home-manager.enable = true;
  home = {
    username = "yoketh";
    stateVersion = "25.11";
  };
}
