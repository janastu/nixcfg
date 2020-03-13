# NixOS module

To enable Janastu tweaks to your [NixOS](https://nixos.org/nixos/) system, add
the `nixos` directory of this repository to the `imports` of
`/etc/nixos/configuration.nix`.

Example:

```nix
{ config, lib, pkgs, ... }:

let
  janastuGit =
    builtins.fetchGit { url = "https://github.com/janastu/nixcfg.git"; };

in {

  imports = [ "${janastuGit}/nixos" ];

}
```

See https://nixos.org/nixos/manual/#sec-importing-modules for more information.

# Nixpkgs overlay

The packages overlay is enabled by default when NixOS module is imported, but it
can also be enabled for [non-NixOS distros](https://nixos.org/nix/).

```sh
mkdir -p ~/.config/nixpkgs/overlays/
cat << EOF > ~/.config/nixpkgs/overlays/janastu.nix

let
  janastuGit =
    builtins.fetchGit { url = "https://github.com/janastu/nixcfg.git"; };
in import "\${janastuGit}/nixpkgs-overlay"

EOF
```

See https://nixos.org/nixpkgs/manual/#sec-overlays-install for more information.
