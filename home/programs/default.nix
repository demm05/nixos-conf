{ pkgs, ... }:
{
  imports = [
    ./browsers.nix
  ];
  home.packages = with pkgs; [
    obsidian
    telegram-desktop
    discord
    zapzap
  ];
}
