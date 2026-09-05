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
    flavor = "mocha"; # latte, frappe, macchiato, or mocha
  };
  
  gtk = {
    enable = true;
#    theme = {
#      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
#      package = pkgs.catppuccin-gtk.override {
#        accents = [ "mauve" ];
#        variant = "mocha";
#        size = "standard";
#      };
#    };
    iconTheme = {
      name = "Papirus-Dark";
    };  
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14; 
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
  };
  
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
