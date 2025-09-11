# .dotfiles

```shell
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles/nix-darwin

# if you alreadt install nix-darwin
darwin-rebuild switch --flake ~/.dotfiles/nix-darwin
```

### change default shell to zsh
```
grep zsh /etc/shells || command -v zsh | sudo tee -a /etc/shells
chsh -s "$(command -v zsh)"
```
