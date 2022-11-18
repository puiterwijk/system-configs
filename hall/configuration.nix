{ config, pkgs, lib, ... }:
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

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password-cli"
  ];
}
