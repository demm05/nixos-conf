{ config, pkgs, ... }:
let
	hosts = import ../../config/hosts.nix;
in
{
	imports = [
		./hardware-configuration.nix
		../../nixos/desktop/gnome.nix
		../../nixos/hardware/nvidia.nix
		../../nixos/laptop 
    ];

	hardware.nvidia.prime = {
		sync.enable = true;
		nvidiaBusId = "PCI:1:0:0";
		amdgpuBusId = "PCI:100:0:0";
	};

  networking.hostName = hosts.workstation.hostname; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dmelnyk = {
    isNormalUser = true;
    description = "Dmytro Melnyk";
    extraGroups = [ "networkmanager" "wheel" "audio"];
  };

  programs.tmux.enable = true;
  programs.tmux.extraConfig = '' '';

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #hardware.enableAllFirmware = true;

  # Garbage collection
  system.stateVersion = "24.11"; 
  system.autoUpgrade.enable = true;
  environment.variables.EDITOR = "vim";
  boot.loader = {
  	systemd-boot.enable = true;
  	systemd-boot.configurationLimit = 10;
  	efi.canTouchEfiVariables = true;
  };
}
