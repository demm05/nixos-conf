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
	networking.networkmanager.enable = true;

	users.users.dmelnyk = {
		isNormalUser = true;
		description = "Dmytro Melnyk";
		extraGroups = [ "networkmanager" "wheel" "audio"];
	};
	#hardware.enableAllFirmware = true;

	system.autoUpgrade.enable = true;
	environment.variables.EDITOR = "vim";
	boot.loader = {
		systemd-boot.enable = true;
		systemd-boot.configurationLimit = 10;
		efi.canTouchEfiVariables = true;
	};

	system.stateVersion = "24.11"; 
}
