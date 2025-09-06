# /etc/nixos/configuration.nix (with NVIDIA support)
{ config, pkgs, ... }:

{
  # Enable Hyprland via the provided module
  programs.hyprland.enable = true;
  programs.hyprland.nvidiaPatches = true;  # Important for NVIDIA compatibility

  # NVIDIA graphics configuration
  services.xserver.videoDrivers = [ "nvidia" ];  # Enable NVIDIA driver
  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;  # For 32-bit applications if needed
  };

  hardware.nvidia = {
    # Use the appropriate driver version for your MX 550
    # Current stable driver (check nixos-hardware if you need older versions)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    # Enable modesetting for better Wayland compatibility
    modesetting.enable = true;
    
    # Power management (helps with battery life on laptops)
    powerManagement.enable = true;
    
    # Force full composition pipeline if you experience screen tearing
    # forceFullCompositionPipeline = true;
  };

  # Helpful packages for the default hyprland dots
  environment.systemPackages = with pkgs; [
    hyprland
    waybar
    mako          # notifications
    wl-clipboard
    grim
    slurp
    wofi
    
    # NVIDIA utilities (optional but useful)
    nvtop         # GPU monitoring
    glxinfo       # OpenGL info utility
  ];

  # XDG portals — make sure portals are available
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  # Polkit (polkit is useful for auth prompts)
  security.polkit.enable = true;

  # Boot configuration (may help with NVIDIA issues)
  boot.kernelParams = [ "nvidia_drm.modeset=1" ];
}
