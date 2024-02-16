{
  config,
  lib,
  pkgs,
  ...
}: {
  config =
    lib.mkIf (config.my.hardware.gpu == "amd") {
      services.xserver.videoDrivers = lib.mkDefault ["modesetting" "amdgpu"];
      boot = {
        initrd.kernelModules = ["amdgpu"];
        kernelModules = ["amdgpu"];
      };
      hardware.opengl = {
        extraPackages = with pkgs; [
          amdvlk
          mesa
          vulkan-tools
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer
          rocmPackages.clr
        ];
        extraPackages32 = with pkgs; [
          driversi686Linux.amdvlk
        ];
      };
    }
    // lib.mkIf (config.my.hardware.cpu == "amd") {
      hardware.cpu.amd.updateMicrocode = true;
      boot = {
        kernelModules = [
          "kvm-amd"
          "amd-pstate"
          "zenpower"
          "msr"
        ];
      };
    };
}
