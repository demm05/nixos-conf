{
  inputs,
  lib,
  ...
}:
let
  nixvim' = inputs.nixvim.packages."x86_64-linux".default;
  nvim = nixvim'.extend {
    config.theme = lib.mkForce "jellybeans";
  };
in
{
  home.packages = [
    nvim
  ];
}
