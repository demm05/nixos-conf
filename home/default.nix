{ inputs, pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./programs
    ./tmux.nix
    ./develop
  ];
  home.packages = with pkgs; [
    home-manager
    rustc
    cargo
    zotero
    appimage-run
    keepassxc
    slack
  ];
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
