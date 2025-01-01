{ pkgs, ... }:
{
	imports = [
		../system/basic.nix
		../system/nix.nix
		../sound.nix
	];
	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

}

