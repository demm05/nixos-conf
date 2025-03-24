{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.services.conservation-mode = mkOption {
    type = types.submodule {
      options = {
        enable = mkEnableOption "conservation mode service";

        # Define 'conservationModeEnabled' here, within the submodule options
        conservationModeEnabled = mkOption {
          type = types.bool;
          default = true;
          description = "Enable conservation mode on startup";
        };
      };
    };
  };

  config.systemd.services.conservation-mode = mkIf config.services.conservation-mode.enable {
    description = "Manage Conservation Mode";
    after = [ "acpi.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart =
        let
          mode = if config.services.conservation-mode.conservationModeEnabled then "1" else "0";
        in
        # Directly use bash -c instead of writeShellScriptBin
        "${pkgs.bash}/bin/bash -c 'echo ${mode} > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'";
    };
  };
}
