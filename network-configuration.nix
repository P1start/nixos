{ config, pkgs, ... }:

{
  # Firewall
  networking.firewall = {
    enable = true;
    extraCommands = ''
      iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP
    '';
  };

  # Start cloudflared for DNS over HTTPS
  systemd.services.cloudflared-proxy-dns = {
    description = "cloudflared proxy-dns";
    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared proxy-dns";
    };
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
  };
  networking.nameservers = [ "127.0.0.1" ];

  # Add a group to disallow internet access
  users.groups.no-internet = {
    gid = 1101;
  };

  # Enable NetworkManager
  networking.networkmanager.enable = true;
}
