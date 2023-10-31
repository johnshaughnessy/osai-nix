{ pkgs, ... }:

{
  home-manager.users.john = {
    home.packages = with pkgs; [
      dunst
      github-cli
      i3
      jq
      nvtop
      python3
      python3Packages.jupyter
      python3Packages.jupyter_client
      python3Packages.jupyterhub
      python3Packages.jupyterlab
      python3Packages.notebook
      python3Packages.pip
      python3Packages.pytorch
      python3Packages.tensorflow
      wget
      xorg.xauth
    ];

    services.dunst = {
      enable = true;
      settings = { };
    };

    xsession = {
      enable = true;
      windowManager.i3.enable = true;
      initExtra = ''
        ${pkgs.xorg.xauth}/bin/xauth add $DISPLAY . $XAUTHORITY
      '';
    };

    programs.bash.enable = true;
    home.stateVersion = "23.05";
  };
}
