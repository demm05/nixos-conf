{ lib, pkgs, inputs, ... }:
{
	fonts.fontconfig.enable = true;
	home.packages = with pkgs; [
		nerd-fonts.meslo-lg nerd-fonts._0xproto
	];
}
