{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "catppuccin"
      "docker-compose"
      "golangci-lint"
      "macos-classic"
      "prisma"
      "svelte"
      "xml"
      "catppuccin-icons"
      "dockerfile"
      "html"
      "make"
      "proto"
      "toml"
      "csv"
      "env"
      "java"
      "ruby"
      "verilog"
      "cucumber"
      "git-firefly"
      "ktrz-monokai"
      "php"
      "sql"
      "vue"
      "nix"
    ];
    extraPackages = [ pkgs.nixd ];
    userSettings = {
      tabs = {
        close_position = "left";
        file_icons = true;
        git_status = true;
        activate_on_close = "history";
        show_close_button = "hover";
        show_diagnostics = "errors";
      };
      preferred_line_length = 120;
      soft_wrap = "bounded";
      theme = "Catppuccin Frappé";
      icon_theme = "Catppuccin Frappé";
      edit_predictions.disabled_globs = ["*"];
      features.edit_prediction_provider = "zed";
      ui_font_size = 16;
      buffer_font_size = 14;
      terminal = {
        dock = "bottom";
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
      };
      languages = {
        TOML = {
          language_servers = ["!air.toml"];
        };
      };
      lsp = {
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative";
              };
            };
          };
        };
      };
    };
    userKeymaps = [
      {
        context =  "Workspace";
        bindings = {
          "shift shift" = "file_finder::Toggle";
        };
      }
      {
        context = "Editor";
        bindings = {
          "cmd-alt-shift-up"= "editor::AddSelectionAbove";
          "cmd-alt-shift-down"= "editor::AddSelectionBelow";
        };
      }
    ];
  };
}
