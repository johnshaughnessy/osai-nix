| :exclamation: I gave up on the nixos configs in this repo. I never quite got everything working together harmoniously. |
| ---------------------------------------------------------------------------------------------------------------------- |

# OSAI-Nix

Nix configuration files for Open Source Artificial Intelligence.

## `etc/nixos/` and `bin/sync`

The configuration files in `etc/nixos/` configure a base (`NixOS`) system. The `bin/sync` script can be executed at anytime to rebuild the base system according to the latest changes in the repo. `bin/sync <branch_name>` is also supported, where `<branch_name>` defaults to `main`.

## `flakes/`

The files in the `flakes/` directory are meant to help quickly set up projects. The typical way to use these are to copy them into the target project directory, and then run `nix develop`:

```sh
mkdir ~/myproject
cp flakes/jupyter.nix ~/myproject/flake.nix
cd ~/myproject
nix develop
```
