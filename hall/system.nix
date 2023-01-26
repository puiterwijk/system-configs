{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "hall";
  time.timeZone = "Europe/Amsterdam";
  environment.variables.EDITOR = "vim";
  security.sudo.wheelNeedsPassword = false;
  users.mutableUsers = false;

  services.openssh.enable = true;
  services.resolved.enable = true;
  services.resolved.dnssec = "false";

  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://cache.nixos.org/"
        "https://enarx.cachix.org"
      ];
      trusted-public-keys = [
        "enarx.cachix.org-1:Izq345bPMThAWUW830X3uoGTTBjXW7ltGlfTBErgm4w="
      ];
    };
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    rebootWindow = {
      lower = "03:00";
      upper = "05:00";
    };
    channel = https://nixos.org/channels/nixos-22.11;
    persistent = false;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
