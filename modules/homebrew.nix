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
      upgrade = false;
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
      "visual-studio-code"
      "postman"
      "keka"
      "1password"
      "discord"
      "proxyman"
      "tradingview"
      "ungoogled-chromium"
      "fork"
      "music-presence"
      "vlc"
      "bitwarden"
    ];

    masApps = {
    };
  };
}
