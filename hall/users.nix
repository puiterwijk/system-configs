{ config, pkgs, ... }:
{
  imports = [
    (fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master")
  ];
  services.vscode-server.enable = true;

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
      tmux
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3wiwWLkUK1rmZnMCN9tVujxOOv44bb6tm7sz/cgZk/ GitHub key"
    ];
  };
}
