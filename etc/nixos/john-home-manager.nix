{ pkgs, ... }:

{
  home-manager.users.john = {
    home.packages = with pkgs; [ xorg.xauth dunst i3 jq nvtop ];

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
