{...}: {
  xdg.configFile."1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    vault = "Dev Stuff"
    item = "Github"
  '';
}
