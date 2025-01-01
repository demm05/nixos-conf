{ config, pkgs, ... }:
{
systemd.services.conservation-mode = {
    description = "Manage Conservation Mode";
    after = [ "acpi.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart =
        let
          mode = if config.conservationModeEnabled then "1" else "0";
          script = pkgs.writeShellScriptBin "conservation-mode" ''
            #!/bin/sh
            echo ${mode} > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
          '';
        in
        "${script}";
    };
  };

  options.conservationModeEnabled = builtins.mkOption {
    type = builtins.types.bool;
    default = true;
    description = "Enable conservation mode on startup";
  };
}
