{...}: {
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "yoketh";
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
      autoUpdate = true;
    };

    casks = [
      "ghostty"
      "fork"
      "notion"
      "intellij-idea-ce"
      "playcover-community"
      "keyboardcleantool"
      "macs-fan-control"
      "figma"
      "microsoft-teams"
      "zoom"
      "discord"
      "slack"
      "raycast"
      "zed"
      "appcleaner"
      "rectangle"
      "mongodb-compass"
      "drawio"
      "tableplus"
      "modrinth"
      "orbstack"
      "proxyman"
      "gifox"
      "google-chrome"
      "imageoptim"
      "obs"
      "visual-studio-code"
      "postman"
    ];

    masApps = {
      RYTD = 6463305263;
      "Adguard for Safari" = 1440147259;
      "JSON Peep for Safari" = 1458969831;
      "Accelerate for Safari" = 1459809092;
      Line = 539883307;
    };
  };
}
