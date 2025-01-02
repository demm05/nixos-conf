{ inputs, pkgs, username, ... }:
{
	imports = [
		./remap.nix
		./hypr_settings.nix
	];
	home.packages = with pkgs; [
		kitty pyprland wofi xfce.thunar 
	];
	wayland.windowManager.hyprland = {
		enable = true;
	};
}
