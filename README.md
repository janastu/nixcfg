To enable Janastu tweaks to your NixOS system, add the `nixos` directory of this
repository to the `imports` of `/etc/nixos/configuration.nix`.

Example:

```nix
{ config, lib, pkgs, ... }:

let
  janastu =
    builtins.fetchGit { url = "https://github.com/janastu/nixcfg.git"; }
    + "/nixos";
in
{
  …

  imports = [ … janastu … ];

  …
}
```
