{...}: {
  xdg.configFile."1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    vault = "Private"
    item = "SSH-Key"
  '';
}
