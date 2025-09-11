{...}: {
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "yoketh";
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
      upgrade = true;
      autoUpdate = true;
    };

    taps = [
      "hashicorp/tap"
    ];

    brews = [
      "hashicorp/tap/terraform"
    ];

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
      "openvpn-connect"
      "ungoogled-chromium"
      "brave-browser"
      "burp-suite"
      "vlc"
    ];

    masApps = {
      "The Unarchiver" = 425424353;
    };
  };
}
