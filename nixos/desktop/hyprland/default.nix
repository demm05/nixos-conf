{ pkgs, inputs, ... }:
{
	imports = [
		../minimal.nix
	];

	programs.hyprland = {
		enable = true;
    	xwayland.enable = true;
	};
	#package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
	#portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

	xdg.portal.enable = true;
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
