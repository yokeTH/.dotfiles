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
      "playcover-community"
      "orbstack"
    ];

    masApps = {
    };
  };
}
