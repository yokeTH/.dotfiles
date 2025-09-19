{...}: {
  xdg.configFile."ghostty/config".text = ''
    ${builtins.readFile ../dotfiles/ghostty.config}
  '';
}
