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
        pythonEnv = pkgs.python3.withPackages (ps:
          with ps; [
            ps.pytorch
            ps.torchvision
            ps.pip
            ps.fastai
            ps.graphviz
            ps.ipywidgets
            ps.matplotlib
            ps.nbdev
            ps.pandas
            ps.scikit-learn
            # ps.azure-cognitiveservices-search-imagesearch
            ps.sentencepiece
            ps.jupyterlab
          ]);
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ pythonEnv ];
          shellHook = ''
            strippedPS1=$(echo -n "$PS1" | sed 's/^\\n//')

            export PS1="(jupyter) $strippedPS1"
          '';
        };
      });

}
