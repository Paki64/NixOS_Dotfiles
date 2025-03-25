{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./network.nix
      ./stylix
      ./secrets.nix
      ../common/global
      ../common/users/paki
    ];

  networking.hostName = "Paki-Laptop"; # Define your hostname.
  
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "paki";


  # AMD Drivers

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    # Force use of the thinkpad_acpi driver for backlight control.
    # This allows the backlight save/load systemd service to work.
    "acpi_backlight=native"

    # AMD CPU scaling
    # https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html
    # https://wiki.archlinux.org/title/CPU_frequency_scaling#amd_pstate
    # On recent AMD CPUs this can be more energy efficient.
    "amd_pstate=guided"

    # Load amdgpu at stage 1
    "amdgpu"
  ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    #amdvlk
    libvdpau-va-gl
    mesa.drivers
    rocmPackages.clr
    rocmPackages.clr.icd
    vaapiVdpau
  ];
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];
  environment.variables = {
    # VAAPI and VDPAU config for accelerated video.
    # See https://wiki.archlinux.org/index.php/Hardware_video_acceleration
    "VDPAU_DRIVER" = "radeonsi";
    "LIBVA_DRIVER_NAME" = "radeonsi";
  };
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.systemPackages = with pkgs; [
    amdgpu_top
  ];

}
