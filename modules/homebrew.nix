{user, ...}: {
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "${user}";
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
      autoUpdate = true;
    };

    casks = [
      "playcover-community"
      "orbstack"
      "brave-browser"
      "ghostty"
      "notion"
      "intellij-idea-ce"
      "slack"
      "zoom"
      "raycast"
      "appcleaner"
      "rectangle"
      "microsoft-teams"
      "mongodb-compass"
      "modrinth"
      "google-chrome"
      "visual-studio-code"
      "postman"
      "keka"
      "1password"
      "discord"
      "proxyman@5.22.0"
    ];

    masApps = {
    };
  };
}
