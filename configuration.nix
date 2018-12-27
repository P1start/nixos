{ config, pkgs, ... }:

{
  imports = [
    ./program-configuration.nix
    ./service-configuration.nix
    ./desktop-configuration.nix
    ./network-configuration.nix
    ./system-configuration.nix
    ./specific/configuration.nix
    ./specific/hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
