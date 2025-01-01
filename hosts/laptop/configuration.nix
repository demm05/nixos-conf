{ config, pkgs, ... }:
let
	hosts = import ../../config/hosts.nix;
in
{
	imports = [
		./hardware-configuration.nix
		../../nixos/sound.nix
		../../nixos/system/basic.nix
		../../nixos/hardware/nvidia.nix
		../../nixos/desktop/gnome.nix
		../../nixos/laptop 
    ];

	hardware.nvidia.prime = {
		sync.enable = true;
		nvidiaBusId = "PCI:1:0:0";
		amdgpuBusId = "PCI:100:0:0";
	};

	services.conservation-mode.enable = true;
	services.conservation-mode.conservationModeEnabled = true; 

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

  specialisation = {
    disable-dGPU.configuration = import ../../nixos/hardware/disable_gpu.nix;
  };

  services.power-profiles-daemon.enable = false;
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
       USB_AUTOSUSPEND = 0;
      };
  };

  # Garbage collection
  nix.settings.auto-optimise-store = true; # May slow down build
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11"; 
  system.autoUpgrade.enable = true;
  environment.variables.EDITOR = "vim";
  boot.loader = {
  	systemd-boot.enable = true;
  	systemd-boot.configurationLimit = 10;
  	efi.canTouchEfiVariables = true;
  };
}
