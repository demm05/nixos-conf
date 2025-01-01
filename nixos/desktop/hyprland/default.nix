{ pkgs, inputs, ... }:
{
	imports = [
		../minimal.nix
	];
	programs.hyprland = {
		enable = true;
    	xwayland.enable = true;
	};
  	environment.systemPackages = with pkgs; [ kitty pyprland];
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

	xdg.portal.enable = true;
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

	environment = {
    	sessionVariables = {
        	NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
        	WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor rendering issue on wlr nvidia.

        	XDG_CURRENT_DESKTOP = "Hyprland";
        	XDG_SESSION_TYPE = "wayland";
        	XDG_SESSION_DESKTOP = "Hyprland";

        	GBM_BACKEND = "nvidia-drm";
        	__GLX_VENDOR_LIBRARY_NAME = "nvidia";
        	LIBVA_DRIVER_NAME = "nvidia";
        	__GL_GSYNC_ALLOWED = "1";
        	__GL_VRR_ALLOWED = "0"; 
        	WLR_DRM_NO_ATOMIC = "1";

        	QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        	QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        	QT_QPA_PLATFORM = "wayland";
        	QT_QPA_PLATFORMTHEME = "qt5ct";

        	GDK_SCALE = "2";

        	ELECTRON_OZONE_PLATFORM_HINT = "auto";

        	NVD_BACKEND = "direct";
    	};
	};
}
