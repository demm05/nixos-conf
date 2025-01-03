{ inputs, pkgs, ... }:
{
	imports = [
		./remap.nix
		./hypr_settings.nix
		#./waybar
	];
	home.packages = with pkgs; [
		kitty pyprland wofi xfce.thunar 
	];
	wayland.windowManager.hyprland = {
		enable = true;
	};
}
