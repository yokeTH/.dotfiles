{ ... }:
{
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "yoketh";
  };

  homebrew = {
    enable = true;
    casks = [
      "ghostty"
    ];
  };
}
