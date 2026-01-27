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

    taps = [
      "tw93/tap"
    ];

    brews = [
      "tw93/tap/mole"
    ];

    casks = [
      "playcover-community"
      "orbstack"
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
      "obs"
    ];

    masApps = {
    };
  };
}
