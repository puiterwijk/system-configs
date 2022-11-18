{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      (fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master")
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hall";
  time.timeZone = "Europe/Amsterdam";

  environment.variables.EDITOR = "vim";

  users.mutableUsers = false;
  users.users.puiterwijk = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      kubectl
      kubelogin
      git
      wget
      azure-cli
      gh
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3wiwWLkUK1rmZnMCN9tVujxOOv44bb6tm7sz/cgZk/ GitHub key"
    ];
  };

  services.vscode-server.enable = true;

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    vim
  ];

  services.openssh.enable = true;
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
    channel = https://nixos.org/channels/nixos-22.05;
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
