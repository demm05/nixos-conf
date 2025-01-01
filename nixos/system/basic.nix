# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    basic.nix                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dmelnyk <dmelnyk@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/01 12:12:49 by dmelnyk           #+#    #+#              #
#    Updated: 2025/01/01 12:13:49 by dmelnyk          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

{ config, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # coommon packages
  environment.systemPackages = with pkgs; [
    vim
    neovim
    coreutils
    xclip
    git
    dig
    neofetch
    htop
    iftop
    tcpdump
    inetutils
    bottom
    pstree
    tree
    pwgen
    screen
    ncdu
    parted
    file
    unzip
    lshw
    wget
    curl
  ];
}
