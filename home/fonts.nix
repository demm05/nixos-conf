{ lib, pkgs, inputs, ... }:
{
	fonts.fontconfig.enable = true;
	home.packages = with pkgs; [
		nerd-fonts.meslo-lg nerd-fonts._0xproto
		noto-fonts-emoji noto-fonts-cjk-sans
    	font-awesome
    	material-icons

	];
}
