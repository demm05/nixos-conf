{ inputs, host, pkgs, ... }:
let
	username = host.user;
in
{
	imports = [
		../../home
		#../../home/hyprland
	];

	home.packages = with pkgs ; [
		home-manager libgcc libgcc rustc cargo zotero appimage-run gnumake keepassxc
		pciutils
		powertop
		alacritty
	]; 

	home = {
		username = username;
		homeDirectory = "/home/${username}";
		stateVersion = "24.11"; 
	};
}
