{ ... }:
{
	imports = [
		./conservation_mode.nix
		./optimization.nix
	];

	services.libinput.enable = true;
	services.conservation-mode.enable = true;
	services.conservation-mode.conservationModeEnabled = true; 
	specialisation = {
		nvidia.configuration = import ../../nixos/hardware/disable_gpu.nix;
	};
}
