{
  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/nixos-23.05"; # Default nixpkgs, change as needed
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
            # pkgs.cudatoolkit
            # pkgs.cudaPackages.cudnn
          ];
          shellHook = ''
            strippedPS1=$(echo -n "$PS1" | sed 's/^\\n//')

            export PS1="(fastbook) $strippedPS1"

            # Create a Python virtual environment
            python -m venv .venv

            # Activate the virtual environment
            source .venv/bin/activate

            # Install specific versions of PyTorch, torchvision, and torchaudio
            pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2

            # Install fastbook
            # pip install fastbook

            # export CUDA_HOME=${pkgs.cudatoolkit}
            # export LD_LIBRARY_PATH=${pkgs.cudatoolkit.lib}/lib:$LD_LIBRARY_PATH
            # export LD_LIBRARY_PATH=${pkgs.cudaPackages.cudnn}/lib:$LD_LIBRARY_PATH

            # Need to explicitly add the GCC library path to LD_LIBRARY_PATH, but since pkgs.gcc is a wrapper,
            # We need to find where the library is first.
            export GCC_LIB_PATH=$(find /nix/store -name libstdc++.so.6 -path "*gcc-12.2.0*" -print -quit | xargs dirname)
            export LD_LIBRARY_PATH=$GCC_LIB_PATH:$LD_LIBRARY_PATH
          '';
        };
      });

}
