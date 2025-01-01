{ inputs, pkgs, ... }:
{
	imports = [
		./fonts.nix
		./programs
		./hyprland
	];
	home.packages = with pkgs ; [
		home-manager libgcc libgcc rustc cargo zotero  appimage-run gnumake keepassxc
	]; 
}
