# .dotfiles

```shell
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles/nix-darwin

# if you alreadt install nix-darwin
darwin-rebuild switch --flake ~/.dotfiles/nix-darwin
```

### change default shell to zsh
```
home-manager switch --flake ~/.dotfiles/home-manager

grep zsh /etc/shells || command -v zsh | sudo tee -a /etc/shells
chsh -s "$(command -v zsh)"
```
