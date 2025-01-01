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
		igpu.configuration = import ../../nixos/hardware/disable_gpu.nix;
	};
}
