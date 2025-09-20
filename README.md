# .dotfiles

1. Install `nix`
```sh
$ sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

2. install nix-darwin or home-manager (standalone)
nix-darwin
```sh
sudo nix run nix-darwin/master#darwin-rebuild -- switch
```
or home-manager
```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

3. Apply dotfiles
```sh
sudo darwin-rebuild switch --flake github:yoketh/.dotfiles
```
```sh
home-manager switch --flake github:yoketh/.dotfiles
```

## Local
```sh
git clone https://github.com/yokeTH/.dotfiles ~/.dotfiles
```

# Thanks to
- [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config)
- [plohan/dotfiles](https://github.com/plohan/dotfiles)
