{
  description = "NixOS system for OSAI";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";  # Pin a specific version

  outputs = { self, nixpkgs }: {
    nixosConfigurations.osai = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./hardware-configuration.nix ./configuration.nix ];
    };
  };
}

