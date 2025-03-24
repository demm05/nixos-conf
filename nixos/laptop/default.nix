{ ... }:
{
  imports = [
    ./conservation_mode.nix
    ./optimization.nix
  ];

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };
  services = {
    libinput.enable = true;
    conservation-mode.enable = true;
    conservation-mode.conservationModeEnabled = true;
  };
  specialisation = {
    igpu.configuration = import ../../nixos/hardware/disable_gpu.nix;
  };
}
