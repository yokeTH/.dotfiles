{ ... }:
{
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "yoketh";
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "ghostty"
      "fork"
      "notion"
      "intellij-idea-ce"
      "playcover-community"
      "keyboardcleantool"
      "macs-fan-control"
      "figma"
      # "discord"
    ];
  };
}
