# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "elder-dragon"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  networking.interfaces.enp2s0.ipv4.addresses = [ {
    address = "192.168.1.100";
    prefixLength = 24;
  } ];

  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "1.1.1.1" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # for keeping the server live

  services.logind.lidSwitchExternalPower = "ignore";

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
    LC_ALL = "en_GB.UTF-8";
    LANG = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mdnaina = {
    isNormalUser = true;
    description = "MdNaina";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  users.users."mdnaina".openssh.authorizedKeys.keys = [
     "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsaNGDUxlUWyiRPZNU3caAPvonnvDBYe7Mo7r2+lF+EHsZkRHU/erCLpBkJfQUeAj4GvwxO+/8tKBT6577qdZDjzXIZofoTubsC2ix1OgDKOK81prVE+5Q9a9AFR1SqClWD5QsFq6I+E1Uyx4Vw8iLuN+M32TwEtbvi9gijhUDS7XzmFZRoBodNkRyXQ35Pr82KF8fizhvzfCsO0v2RExem7meQpIFzKZfQt9EBhrq6Iz4ON5HEV6j+kaTZiSbGKT2Jl36v35FIVvAONrgpcvl6crzJxAiitCv4wU+lQmH/vX/v/AN5pLT7oe8Vs0qbA1TMnxWht1NVorx0t/ZkB6syxpqPDWkTYiBKBgu3EOMAMA3TfZIv4PuSb3eFZ573eZ2SiuZzqfWJOihPvRO0ufDP4lJuHd9m1yN/58OVnKuCiWppmQzrzTPM0LZDbDS3lvIllPI1293wlChp2dysQCER98UuXMbr03encPsRpVAbvUEqXXuHipCzDODre0qHpU= naina@Mohameds-MacBook-Air.local"
 ];


  # Enable automatic login for the user.
  services.getty.autologinUser = "mdnaina";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    curl
    at
    openssl
    binutils
    docker
    docker-compose
    zsh
    tmux
    neovim
    htop
    libgccjit
    gcc
    rustup
    lua
    luajitPackages.luarocks-nix
    opentofu
    ventoy-full
    terraform
    cf-terraforming
    cockpit

    home-manager

    # deskop
    gnome.gdm

    wayland
    waybar
    dunst
    libnotify
    hyprland
    swww

    kitty

    rofi-wayland

    firefox

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # programs.hyprland.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;

  # services = {
  #   xserver.enable = true;
  #   displayManager.sddm.enable = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the at (job schedular).
  services.atd.enable = true;

  services.cockpit = {
    enable = true;
    settings = {
      WebService = {
	Listen = "0.0.0.0:9090";
        AllowUnencrypted = true;
      };
    };
  };

  # Enable Docker daemon
  virtualisation.docker.enable = true;

  # Z shell
  programs.zsh.enable = true;

  # Enable Oh-my-zsh
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "sudo" "docker" "kubectl" ];
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome

      material-icons
    ];
  };


  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 9090 6901 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
