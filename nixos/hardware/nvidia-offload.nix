{ pkgs, ... }:
{
  hardware.nvidia.prime = {
    offload.enable = true;
    offload.enableOffloadCmd = true;
    nvidiaBusId = "PCI:1:0:0";  # Replace with your NVIDIA GPU ID
    intelBusId = "PCI:100:0:0"; # Replace with your Intel GPU ID
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "nvidia-offload" ''
      #!${stdenv.shell}

      # Set default provider to NVIDIA
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only

      # Allow overriding the provider with --intel
      if [[ "$1" == "--intel" ]]; then
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=PRIME
        shift
      fi

      # Check if the command exists
      if ! command -v "$1" &> /dev/null; then
        echo "Error: command '$1' not found."
        exit 1
      fi

      exec "$@"
    '')
  ];
}
