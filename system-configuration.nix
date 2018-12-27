{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Clean /tmp
  boot.cleanTmpDir = true;

  # Internationalization
  i18n.defaultLocale = "en_NZ.UTF-8";

  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  # Auto-upgrade
  system.autoUpgrade = {
    enable = true;
    dates = "19:30";
  };

  # Auto-GC
  nix.gc = {
    automatic = true;
    dates = "20:30";
    options = "--delete-older-than 30d";
  };

  # Define a user account.
  users.users.rewi = {
    isNormalUser = true;
    uid = 1000;
    group = "rewi";
    description = "Rewi Haar";
    # Note that being in the no-internet group won't disallow internet access - the iptables
    # rule above only matches the primary group. Adding ourselves to no-internet is just so that
    # we can do things like 'sudo -g no-internet some-command' without having to enter a
    # password.
    extraGroups = [ "wheel" "audio" "networkmanager" "backlight" "no-internet" "wireshark" ];
  };
  users.groups.rewi = {
    gid = 1000;
  };
  users.users.guest = {
    isNormalUser = true;
    uid = 1001;
    group = "guest";
    description = "Guest User";
    extraGroups = [ "audio" "backlight" "networkmanager" ];
  };
  users.groups.guest = {
    gid = 1001;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
