# NixOS configs

A (not so) Good [Flake][1]

## Convention Specification

The pattern I follow easily permits adding more hosts or users, pending a little elbow grease on the flake. Host definitions
live under `hosts/` and user configurations live under `home/`. [Home Manager][2] handles dotfiles and host's user configurations.
The file pattern allows to create additional users under `home/<host>`.

### System Configuration

The core flake is written to bootstrap my specific system(s):

- `wayward`: Laptop with Wayland + Hyprland
- `nord`: VPS

### Example

`wayward` is my Framework laptop running hyprland. Its configuration is found in the following directories:

**Host Path**: `hosts/<host>/`
**Home-Manager Path**: `home/crutonjohn/<host>/`
**Home-Manager Common**: `home/crutonjohn/common/`

Current look for Wayland on my laptop:

<p align="center">
  <a href="https://raw.githubusercontent.com/crutonjohn/nixos/master/framework-wayland.png">
    <img src="https://raw.githubusercontent.com/crutonjohn/nixos/master/framework-wayland.png" width="500px" alt="Wayland"/>
  </a>
  <a href="https://raw.githubusercontent.com/crutonjohn/nixos/master/framework-wayland.png">
    <img src="https://raw.githubusercontent.com/crutonjohn/nixos/master/framework-wayland.png" width="500px" alt="Wayland"/>
  </a>
</p>

#### Example NixOS bootrapping

```bash
## Install Wayland + Hyprland
sudo nixos-rebuild switch --flake github:crutonjohn/nixos#wayward
```

#### Example home-manager bootstrapping

```bash
## Install Wayland + Hyprland
home-manager switch --flake github:crutonjohn/nixos#bjohn@work
```

## Actions

My configs follow the `stable` channel.  A GitHub action updates `flake.lock` nightly.

## Attribution
* Heavily inspired by and borrowed from:
  * [reckenrode's](https://github.com/reckenrode) very well organized [nixos-configs](https://github.com/reckenrode/nixos-configs)
  * [Ruixi-rebirth's](https://github.com/Ruixi-rebirth) [flakes](https://github.com/Ruixi-rebirth/flakes)
  * [jahanson's](https://github.com/jahanson) nix repo ["mochi"](https://github.com/jahanson/mochi) 
* The NixOS community on [Reddit](https://www.reddit.com/r/NixOS/)
* The [Unofficial Nix/NixOS Discord Server](https://discord.com/invite/RbvHtGa)
* The wonderful folks in the [Home Operations Discord Server](https://discord.gg/home-operations)

# TODO
- [x] migrate from stinky crusty X11 to shiny beautiful Wayland
- [x] create nixpkg for [kns](https://github.com/blendle/kns) PR submitted: https://github.com/NixOS/nixpkgs/pull/193995
- [x] re-create Home Manager config for non-NixOS machines
- [x] create linode nixos image
- [x] nix-ify VPS
- [x] nix-ify Headscale VPN
- [x] nix-ify blog
- [ ] ~~nix-ify the k8s cluster~~
- [ ] edit $PATH for pkgs.fish to enable krew plugins (`set -gx PATH $PATH $HOME/.krew/bin`)
- [ ] create multi-user pattern in `flake.nix`

[1]: https://nixos.wiki/wiki/Flakes
[2]: https://github.com/nix-community/home-manager
