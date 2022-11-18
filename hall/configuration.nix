{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./system.nix
      ./users.nix
    ];

  environment.systemPackages = with pkgs; [
    vim
  ];
}
