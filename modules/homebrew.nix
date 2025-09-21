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
    ];

    masApps = {
    };
  };
}
