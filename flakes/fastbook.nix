{
  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/nixos-unstable"; # Default nixpkgs, change as needed
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [ ps.pip ]);
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ pythonEnv pkgs.glibcLocales pkgs.gcc ];
          shellHook = ''
            strippedPS1=$(echo -n "$PS1" | sed 's/^\\n//')

            export PS1="(jupyter) $strippedPS1"

            # Create a Python virtual environment
            python -m venv .venv

            # Activate the virtual environment
            source .venv/bin/activate

            # Install fastbook
            pip install fastbook
          '';
        };
      });

}
