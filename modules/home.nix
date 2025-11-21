{
  pkgs,
  lib,
  isDarwin,
  user,
  inputs,
  ...
}: let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
  deploys-app = pkgs.callPackage ../pkgs/cli/deploys-app/package.nix {};
in {
  imports =
    [
      ./1password.nix
    ]
    ++ lib.optionals isDarwin [
      ./zed.nix
      ./ghostty.nix
    ];

  nix.package = lib.mkIf (!isDarwin) pkgs.nix;
  nix.settings.experimental-features = lib.mkIf (!isDarwin) ["nix-command" "flakes"];

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
  home.username = lib.mkIf (!isDarwin) "${user}";
  home.homeDirectory = lib.mkIf (!isDarwin) "/home/${user}";

  home.packages = with pkgs; [
    alejandra
    nixd
    nil
    devenv

    neovim
    fzf
    zsh
    zsh-powerlevel10k
    zsh-fzf-history-search
    htop
    bat
    ripgrep
    eza

    fastfetch

    zulu
    ngrok

    uxplay

    git
    gh
    pre-commit
    graphviz
    gcloud
    tree

    ffmpeg
    _1password-cli
    deploys-app
    zed-discord-presence
    cloudflared
  ];

  programs.git = {
    enable = true;
    settings =
      {
        user = {
          name = "Thanapon Johdee";
          email = "66236295+yokeTH@users.noreply.github.com";
        };

        gpg = {
          format = "ssh";
        };
        "gpg \"ssh\"" = {
          program =
            if isDarwin
            then "${pkgs._1password-gui}/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
            else "${pkgs._1password-gui}/bin/op-ssh-sign";
        };

        commit = {
          gpgsign = true;
        };

        user = {
          signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlhqMGCbubg6mYk5OlB5DKIVXDqIBdDfI6fcMChRwD/";
        };

        aliases = {
          cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
          prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
          root = "rev-parse --show-toplevel";
        };
      }
      // (
        if isDarwin
        then {
          "url \"ssh://git@github.com/\"" = {
            insteadOf = "https://github.com/";
          };
        }
        else {}
      );
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
    shellAliases =
      {
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

        ga = "git add";
        gc = "git commit";
        gco = "git checkout";
        gcp = "git cherry-pick";
        gdiff = "git diff";
        gl = "git prettylog";
        gp = "git push";
        gs = "git status";
        gt = "git tag";

        jd = "jj desc";
        jf = "jj git fetch";
        jn = "jj new";
        jp = "jj git push";
        js = "jj st";
      }
      // (
        if (!isDarwin)
        then {
          pbcopy = "xclip";
          pbpaste = "xclip -o";
        }
        else {}
      );

    shellGlobalAliases = {
      UUID = "$(uuidgen | tr -d \\n)";
      G = "| rg";
    };
  };

  home.file.".p10k.zsh".source = ../dotfiles/p10k.zsh;

  home.sessionVariables = {
    EDITOR =
      if isDarwin
      then "zed --wait"
      else "vim";
    TERM = "xterm-256color";
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    SSH_AUTH_SOCK =
      if isDarwin
      then "/Users/${user}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      else "~/.1password/agent.sock";

    DEPLOYS_AUTH_USER = "op://Private/Deploys-Default/username";
    DEPLOYS_AUTH_PASS = "op://Private/Deploys-Default/credential";
  };

  xdg.enable = true;
}
