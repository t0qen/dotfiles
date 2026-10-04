{ lib, inputs, config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz;
in
{
  imports =
    [
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
      <catppuccin/modules/nixos>
    ];
  
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.dev = import ./home.nix;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.fsIdentifier = "provided";
  #boot.loader.grub.theme = "catppuccin";

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
  services.displayManager.defaultSession = "none+i3";

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

  services.udisks2.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = false;
  services.printing.enable = true;
  services.flatpak = {
    enable = true;
  };
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.localsend.enable = true;
  programs.localsend.openFirewall = true;
#  programs.adb.enable = true;

#  security.polkit.extraConfig = ''
#    polkit.addRule(function(action, subject) {
#      if (subject.local && action.id == "org.freedesktop.udisks2.filesystem-mount-system") {
#        return polkit.Result.YES;
#      }
#    });
#  '';

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

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
     fastfetch
     nerdfetch
     pulseaudio
     flameshot
     lm_sensors
     s-tui
     stress-ng
     geekbench_6
     gpu-screen-recorder
     gpu-screen-recorder-gtk
     unzip
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  users.users."dev" = {
    isNormalUser = true;
    description = "dev";
    extraGroups = [ "adbusers" "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [
      (polybar.override {
          pulseSupport = true;
      })
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
      nwg-look
      github-desktop
      cava
      playerctl
      starship
      redshift
      libcanberra
      catppuccin-grub
      apple-cursor
      xdg-desktop-portal
      eddie
      arduino-ide
      vscodium-fhs
      anki
      bottom
      baobab
      gimp
      blender
      feh
      audacity
      tor-browser
      easyeffects
      android-tools
      heimdall
      samloader-rs 
    ];
  };


  users.users.gaming = {
    isNormalUser = true;
    description = "gaming";
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      prismlauncher 
      jellyfin-desktop
      supertuxkart
      lutris
      jdk21
      evtest
      usbutils
      taterclient-ddnet
      ddnet
      thunar
      firefox
      steam
      arnis
    ];
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "JetBrainsMono Nerd Font" ];
      serif = [ "JetBrainsMono Nerd Font" ];
    };
  };
  environment.sessionVariables = {
    XCURSOR_THEME = "macOS-White";
    XCURSOR_SIZE = "40";
    HYPRCURSOR_THEME = "macOS-White";
    HYPRCURSOR_SIZE = "40";
  };

  system.stateVersion = "26.05";
    
}
