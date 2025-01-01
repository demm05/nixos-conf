{ pkgs, ... }:
let
	users = import ../../config/users.nix;
in
{
	imports = [
		../../home
	];

	home.packages = with pkgs ; [
		home-manager libgcc libgcc rustc cargo zotero google-chrome appimage-run gnumake firefox keepassxc
		pciutils
		powertop
	]; 

	home = {
		username = users.default;
		homeDirectory = "/home/${users.default}";
		stateVersion = "24.11"; 
	};
}
