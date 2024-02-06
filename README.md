# NixOS configs

A (not so) Good [Flake][1]

## Convention Specification

The pattern I follow easily permits adding more hosts or users, pending a little elbow grease on the flake. Host definitions
live under `hosts/` and user configurations live under `home/`. [Home Manager][2] handles dotfiles and host's user configurations.
The file pattern allows to create additional users under `home/<host>`.

### System Configuration

The core flake is written to bootstrap my specific laptop, either:

- `endurance`: X11 + XFCE + i3
- `wayward`: Wayland + Hyprland

### Example

`endurance` is my Framework laptop running i3. It's directories contain the following configuration: a host definition,
and home-manager configuration.  Its configuration is found in the following directories:

**Host Path**: `hosts/<host>/`
**Home-Manager Path**: `home/crutonjohn/<host>/`
**Home-Manager Common**: `home/crutonjohn/common/`

Current look for X11:

<p align="center">
  <a href="https://nixos.org#gh-light-mode-only">
    <img src="https://raw.githubusercontent.com/crutonjohn/nixos/master/framework-x11.png" width="500px" alt="X11"/>
  </a>
  <a href="https://nixos.org#gh-dark-mode-only">
    <img src="https://raw.githubusercontent.com/crutonjohn/nixos/master/framework-x11.png" width="500px" alt="X11"/>
  </a>
</p>

Current look for Wayland

<p align="center">
  <a href="https://nixos.org#gh-light-mode-only">
    <img src="https://raw.githubusercontent.com/crutonjohn/nixos/master/framework-wayland.png" width="500px" alt="Wayland"/>
  </a>
  <a href="https://nixos.org#gh-dark-mode-only">
    <img src="https://raw.githubusercontent.com/crutonjohn/nixos/master/framework-wayland.png" width="500px" alt="Wayland"/>
  </a>
</p>

#### Example bootrapping

```bash
## Install X11 + XFCE + i3
sudo nixos-rebuild switch --flake github:crutonjohn/nixos#endurance

## Install Wayland + Hyprland
sudo nixos-rebuild switch --flake github:crutonjohn/nixos#wayward
```

## Actions

My configs follow the `unstable` channel.  A GitHub action updates
`flake.lock` nightly.

## Attribution
* Heavily inspired by and borrowed from [reckenrode's](https://github.com/reckenrode) very well organized [nixos-configs](https://github.com/reckenrode/nixos-configs)
* Some direction from [Ruixi-rebirth's](https://github.com/Ruixi-rebirth/flakes) [flakes](https://github.com/Ruixi-rebirth/flakes)
* The NixOS community on [Reddit](https://www.reddit.com/r/NixOS/)
* The [Unofficial Nix/NixOS Discord Server](https://discord.com/invite/RbvHtGa)

# TODO
- [x] migrate from stinky crusty X11 to shiny beautiful Wayland
- [x] create nixpkg for [kns](https://github.com/blendle/kns) PR submitted: https://github.com/NixOS/nixpkgs/pull/193995
- [x] re-create Home Manager config for non-NixOS machines
- [x] create linode nixos image
- [x] nix-ify VPS
- [x] nix-ify Headscale VPN
- [x] nix-ify blog
- [ ] nix-ify the k8s cluster
- [ ] edit $PATH for pkgs.fish to enable krew plugins (`set -gx PATH $PATH $HOME/.krew/bin`)
- [ ] create multi-user pattern in `flake.nix`

[1]: https://nixos.wiki/wiki/Flakes
[2]: https://github.com/nix-community/home-manager
