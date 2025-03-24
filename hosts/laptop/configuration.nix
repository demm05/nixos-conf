{ config, pkgs, ... }:
let
  hosts = import ../../config/hosts.nix;
in
{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/desktop/gnome.nix
    #	../../nixos/desktop/hyprland
    ../../nixos/hardware/nvidia.nix
    ../../nixos/hardware/nvidia-offload.nix
    ../../nixos/laptop
    ../../nixos/steam.nix
    ../../nixos/develop
  ];

  networking.hostName = hosts.workstation.hostname;
  networking.networkmanager.enable = true;
  programs.zsh.enable = true;

  users.users.dmelnyk = {
    isNormalUser = true;
    description = "Dmytro Melnyk";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];
  };
  #hardware.enableAllFirmware = true;

  system.autoUpgrade.enable = true;
  environment.variables.EDITOR = "vim";
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 10;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    norminette
  ];
  system.stateVersion = "24.11";
}
