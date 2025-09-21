{...}: {
  xdg.configFile."1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    vault = "Development"
    item = "SSH-Key"
  '';
}
