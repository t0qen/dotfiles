{ config, pkgs, ... }:

{
  imports = [
    <catppuccin/modules/home-manager>
  ];

  home.username = "dev";
  home.homeDirectory = "/home/dev";
  home.stateVersion = "26.05";

  catppuccin = {
    enable = true; 
    flavor = "mocha";
    accent = "mauve";
    gtk.icon.enable = true; 
  };  
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "mauve" ];
      };
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };
  };
  programs.cava.enable = true;  
  home.pointerCursor = {
    enable = true;
    name = "macOS-White";
    package = pkgs.apple-cursor;
    size = 40;
    x11.enable = true;
    gtk.enable = true;
  };

#  dconf.settings = {
#    "org/gnome/desktop/interface" = {
#      color-scheme = "prefer-dark";
#    };
#  };
}
