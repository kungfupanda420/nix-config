# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:




let
  tlauncher = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "tlauncher";
    version = "2.16";
    
    src = /home/pratheek/Downloads/TLauncher.v16/TLauncher.jar;
    
    nativeBuildInputs = [ pkgs.makeWrapper ];
    
    dontUnpack = true;
    
    installPhase = ''
      mkdir -p $out/bin $out/share/java
      cp $src $out/share/java/tlauncher.jar
      
      # Use steam-run with Java
      makeWrapper ${pkgs.steam-run}/bin/steam-run $out/bin/tlauncher \
        --add-flags "java" \
        --add-flags "-jar" \
        --add-flags "$out/share/java/tlauncher.jar"
    '';
  };
in
#hi

  


{

programs.dconf.enable=true;






  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./git-config.nix
      ./rebuild-config.nix
	
    ];


 


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.


  # Enable the GNOME Desktop Environment. not this
  #services.xserver.enable=true;
  #services.xserver.displayManager.gdm.enable=true;
  #services.xserver.desktopManager.gnome.enable=true; 
  #the i3 ones
  # Enable the X11 windowing system.
services.xserver.enable = true;

# Enable both GNOME and i3
services.xserver.displayManager.gdm.enable = true;
services.xserver.desktopManager.gnome.enable = true;
services.xserver.windowManager.i3 = {
  enable = true;
  extraPackages = with pkgs; [
    dmenu         # application launcher
    i3status      # status bar
    i3lock        # screen locker
    i3blocks      # alternative status bar
    rofi          # alternative application launcher
  ];
};




  
  
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pratheek = {
    isNormalUser = true;
    description = "pratheek";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    brave
    vscode
    git
    jdk
    gedit
    fastfetch
    discord
    tlauncher
    kitty
    phinger-cursors
    steam-run
    feh
    arandr
    picom
    nitrogen
    polybar
    xterm
    python
  ];
programs.java.enable=true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  xdg.portal.enable=true;
  xdg.portal.extraPortals=[
 pkgs.xdg-desktop-portal-hyprland
];


security.polkit.enable=true;

}
