{
  description = "NixOS system for OSAI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      nixosConfigurations = {
        osai = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration.nix
            ./configuration.nix
            ./john-home-manager.nix
            { imports = [ home-manager.nixosModules.home-manager ]; }
          ];
        };
      };
    });
}
