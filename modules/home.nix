{pkgs, ...}: {
  # imports = [
  #   ./pkgs/zed.nix
  #   ./pkgs/ghostty.nix
  # ];

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";

  programs.git = {
    enable = true;
    userName = "Thanapon Johdee";
    userEmail = "66236295+yokeTH@users.noreply.github.com";
    extraConfig = {
      commit.gpgsign = true;
      user.signingkey = "77FC300623098D07";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autosuggestion.highlight = "fg=cyan";
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      c = "clear";
      g = "git";
      py3 = "python3";
      top = "htop";
      cat = "bat -p --paging=never";
      grep = "rg";
      ls = "eza";
      md = "mkdir";
    };
    shellGlobalAliases = {
      UUID = "$(uuidgen | tr -d \\n)";
      G = "| rg";
    };
  };

  home.file.".p10k.zsh".source = ../dotfiles/p10k.zsh;

  home.sessionVariables = {
    EDITOR = "zed";
  };
}
