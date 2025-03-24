# Heavily relied on this repo: https://github.com/kaleocheng/nix-dots
{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim.url = "github:demm05/nixvim";
  };

  outputs =
    { self, ... }@inputs:
    let
      hosts = import ./config/hosts.nix;

      mkConfigurePkgs =
        { host, nixpkgs }:
        import nixpkgs {
          system = host.arch;
          config = {
            allowUnfree = true;
          };
        };
      mkHomeConfiguration =
        {
          host,
          nixpkgs,
          home-manager,
          modules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkConfigurePkgs { inherit host nixpkgs; };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/${host.dir}/home.nix
            ./overlays
          ] ++ modules;

        };
      mkNixOsConfiguration =
        {
          host,
          nixpkgs,
          home-manager,
          modules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          system = host.arch;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${host.dir}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit host inputs;
                pkgs = mkConfigurePkgs { inherit host nixpkgs; };
              };
              home-manager.useGlobalPkgs = true;
              home-manager.users."${host.user}" = import ./hosts/${host.dir}/home.nix;
            }
          ] ++ modules;
        };
    in
    {
      nixosConfigurations."${hosts.workstation.hostname}" = mkNixOsConfiguration {
        host = hosts.workstation;
        nixpkgs = inputs.nixpkgs;
        home-manager = inputs.home-manager;
        modules = [ ];
      };
    };
}
