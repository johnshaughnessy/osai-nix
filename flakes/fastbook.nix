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
          buildInputs = [
            pythonEnv
            pkgs.glibcLocales
            pkgs.gcc
            pkgs.graphviz
            pkgs.cudatoolkit
            pkgs.cudaPackages.cudnn
          ];
          shellHook = ''
            strippedPS1=$(echo -n "$PS1" | sed 's/^\\n//')

            export PS1="(fastbook) $strippedPS1"

            # Create a Python virtual environment
            python -m venv .venv

            # Activate the virtual environment
            source .venv/bin/activate

            # Install fastbook
            pip install fastbook

            export LD_LIBRARY_PATH=/nix/store/9fy9zzhf613xp0c3jsjxbjq6yp8afrsv-gcc-12.3.0-lib/lib:$LD_LIBRARY_PATH

            # Set CUDA environment variables if necessary
            export CUDA_HOME=${pkgs.cudatoolkit_11}
            export LD_LIBRARY_PATH=${pkgs.cudatoolkit.lib}/lib
            export LD_LIBRARY_PATH=${pkgs.cudaPackages.cudnn}/lib:$LD_LIBRARY_PATH
            export LD_LIBRARY_PATH=${pkgs.gcc}/lib:$LD_LIBRARY_PATH
          '';
        };
      });

}
