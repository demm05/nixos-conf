{ pkgs, ... }:
let
	users = import ../../config/users.nix;
in
{
	imports = [
		../../home
		../../home/hyprland { username = users.default; }
	];

	home.packages = with pkgs ; [
		home-manager libgcc libgcc rustc cargo zotero appimage-run gnumake keepassxc
		pciutils
		powertop
		alacritty
	]; 

	home = {
		username = users.default;
		homeDirectory = "/home/${users.default}";
		stateVersion = "24.11"; 
	};
}
