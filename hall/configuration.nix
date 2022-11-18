{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./system.nix
      ./users.nix
    ];

  environment.defaultPackages = [];
  environment.systemPackages = with pkgs; [
    vim
  ];
}
