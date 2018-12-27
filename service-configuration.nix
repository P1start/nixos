{ config, pkgs, ... }:

# Miscellaneous service configuration.

let
  cloudflared = pkgs.cloudflared;
in
{
  # Enable CUPS
  services.printing.enable = true;

  # Enable Avahi
  services.avahi.enable = true;

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # mpd
  systemd.user.services.mpd = {
    description = "Music Player Daemon";
    serviceConfig = {
      Type = "notify";
      ExecStart = "${pkgs.mpd}/bin/mpd --no-daemon";

      LimitRTPRIO = 50;
      LimitRTTIME = "infinity";

      ProtectSystem = "yes";
      NoNewPrivileges = "yes";
      ProtectKernelTunables = "yes";
      ProtectControlGroups = "yes";
      RestrictAddressFamilies = "AF_INET AF_INET6 AF_UNIX AF_NETLINK";
      RestrictNamespaces = "yes";
    };
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
  };
}
