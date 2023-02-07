{ config, pkgs, ... }:
let
	unstable = import <nixos-unstable> {};
in {
  imports = [
    (fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master")
  ];
  services.vscode-server.enable = true;

  #environment.sessionVariables.RUST_SRC_PATH = "${pkgs.rust.packages.rustPlatform.rustcSrc}";
  users.users.puiterwijk = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      kubectl
      kubeseal
      fluxcd
      kubelogin
      git
      wget
      azure-cli
      gh
      tmux
      _1password

      unstable.cargo
      unstable.rustc
      gcc
      binutils
      unstable.rustPlatform.rustcSrc
      unstable.rustPlatform.rustLibSrc

      go
      python3
      virtualenv

      terraform

      softhsm
      openssl
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3wiwWLkUK1rmZnMCN9tVujxOOv44bb6tm7sz/cgZk/ GitHub key"
    ];
  };
}
