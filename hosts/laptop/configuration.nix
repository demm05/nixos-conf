{ config, pkgs, ... }:
let
	hosts = import ../../config/hosts.nix;
in
{
	imports = [
		../../nixos/sound.nix
		./hardware-configuration.nix
		../../nixos/system/basic.nix
		../../nixos/hardware/nvidia.nix
		../../nixos/desktop/gnome.nix
    ];

	hardware.nvidia.prime = {
		sync.enable = true;
		nvidiaBusId = "PCI:1:0:0";
		amdgpuBusId = "PCI:100:0:0";
	};

  systemd.services.enable-conservation = {
    description = "Enable Conservation Mode";
    after = [ "acpi.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      # Use 'bash' to interpret the script
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'"; 
    };
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
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  environment.variables.EDITOR = "vim";
  boot.loader = {
  	systemd-boot.enable = true;
  	systemd-boot.configurationLimit = 10;
  	efi.canTouchEfiVariables = true;
  };
}
