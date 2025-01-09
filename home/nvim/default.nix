{ inputs, pkgs, ... }:
{
	home.packages = [ inputs.nixvim.packages.${pkgs.system}.default ];
	programs.nixvim = {
		globals.mapleader = " "; # Sets the leader key to comma
	};
}
