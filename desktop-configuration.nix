{ config, pkgs, ... }:

# Configuration options relating to the desktop environment.

let
  oldPkgs = pkgs;
in
let
  pkgs = import ./pkgs.nix { inherit oldPkgs; };
in
{
  # Enable X11
  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.xterm.enable = false;
    windowManager.i3 =
      { enable = true;
        package = pkgs.i3;
        configFile = pkgs.i3Config;
        extraSessionCommands = ''
          feh --bg-fill ${./assets/wallpaper.jpg} &
        '';
      };
    desktopManager.default = "none";
    windowManager.default = "i3";
    videoDrivers = [ "nvidiaLegacy391" "ati" "cirrus" "intel" "vesa" "vmware" "modesetting" ];
    xkbOptions = "caps:escape,compose:paus,altwin:prtsc_rwin";
  };

  # Compositor
  services.compton = {
    enable = true;
    shadow = true;
    shadowOpacity = "0.5";
    shadowOffsets = [ (-15) (-15) ];
    shadowExclude = [ "name='notify-osd'" "name='XOSD'" "class_g='i3-frame'" "class_i='tray'" "!(class_g || name || class_i)" "name='i3lock'" ];
    fade = true;
    fadeExclude = [ "name!='i3lock'" ];
    fadeSteps = [ "0.028" "0.07" ];
    backend = "glx";
    vSync = true;
  };

  # Lock screen
  systemd.services.lock-screen = {
    description = "Lock screen before suspending";
    serviceConfig = {
      Type = "forking";
      Environment = "DISPLAY=:0";
      ExecStart = pkgs.lockCommand;
      User = "rewi";
    };
    before = [ "sleep.target" ];
    wantedBy = [ "suspend.target" ];
  };

  # Allow users to change the screen brightness
  users.groups.backlight = {
    gid = 1100;
  };
  systemd.services.backlight-permissions = {
    description = "Allow members of the backlight group to change the screen brightness";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [ "${pkgs.coreutils}/bin/chgrp backlight /sys/class/backlight/intel_backlight/brightness" "${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/intel_backlight/brightness" ];
    };
    wantedBy = [ "default.target" ];
  };

  # Enable redshift
  services.redshift.enable = true;

  # Location
  location = {
    latitude = -36.85;
    longitude = 174.8;
  };

  # Fonts
  fonts.fonts = with pkgs; [
    # General
    corefonts
    # Bitmap fonts
    scientifica unifont unifont_upper
    # Non-Latin scripts
    akkadian noto-fonts-cjk
  ];

  # GTK+3
  environment.etc."xdg/gtk-3.0/settings.ini" = {
    text = ''
      [Settings]
      gtk-icon-theme-name=Arc
      gtk-theme-name=Arc-Darker
      gtk-cursor-theme-name=Numix-Cursor
    '';
    mode = "444";
  };
}
