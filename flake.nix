{
  description = "NixOS system for OSAI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations.osai = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        { imports = [ home-manager.nixosModules.home-manager ]; }
      ];

    };
  };
}

