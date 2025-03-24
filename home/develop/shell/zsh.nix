{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    thefuck
    lsd
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "lsd";
      ll = "ls -l";
      v = "nvim";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "thefuck"
      ];
      theme = "robbyrussell";
    };
  };
}
