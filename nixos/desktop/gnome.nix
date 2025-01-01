{ pkgs, ... }:
{
	imports = [
		./minimal.nix	
	];
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.proxy-switcher
    gnomeExtensions.tailscale-status
    gnomeExtensions.appindicator
  ];

  services.printing.enable = true;
}
