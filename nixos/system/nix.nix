{ ... }:
{
	nix.settings.auto-optimise-store = true; # May slow down build
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];
	nix.optimise.automatic = true;
	nix.gc = {
		automatic = true;
		options = "--delete-older-than 30d";
	};
}