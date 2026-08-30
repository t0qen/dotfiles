{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];
  
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.fsIdentifier = "provided";

  networking.hostName = "home";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  nix.settings.experimental-features = [ "nix-command" ];

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager.defaultSession = "none+i3";

  hardware.bluetooth = {
   enable = true;
   powerOnBoot = true;
  };
  services.blueman.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
  services.printing.enable = true;
  services.flatpak.enable = true;


  environment.systemPackages = with pkgs; [
     nano
     wget
     htop
     alacritty
     vesktop
     git
     gh
     thunar
     vlc
     feh
     arandr
     stow
     tree
     (python3.withPackages (ps: [
       ps.notify2
     ]))
     gnome-keyring
     python3
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  users.users."dev" = {
    isNormalUser = true;
    description = "dev";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [
      polybar
      picom
      libreoffice-fresh
      mousepad
      maim
      ntfy
      i3lock
      rofi
      dunst
      betterlockscreen
      udiskie
      dex
      xclip
      vscode
      xss-lock
      numlockx
      nitrogen
      libnotify
      joplin-desktop
      catppuccin-gtk
      nwg-look
      github-desktop
      cava
      playerctl
      starship
      redshift
      libcanberra
      catppuccin-papirus-folders
      catppuccin-grub
      catppuccin-kvantum
    ];
  };


  users.users.gaming = {
    isNormalUser = true;
    description = "gaming";
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      prismlauncher 
      ddnet
      jellyfin-desktop
    ];
  };




  system.stateVersion = "26.05";
    
}
