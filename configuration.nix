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

  boot.kernelModules = [ "tun" ];
  boot.extraModprobeConfig = "options tun numdevs=1024";  # 增加虚拟设备数量
  
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  programs.gamemode.enable = true;  # 性能模式
  #hardware.graphics.enable = true;
  hardware.opengl = {
    enable = true;
    #driSupport = true;
    driSupport32Bit = true;  # 支持 32 位游戏
  };

  networking.hostName = "x99-pc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  #networking.hosts = {
  #"140.82.113.26" = ["alive.github.com"];
  #"140.82.116.5" = ["api.github.com"];
  #"185.199.109.153" = ["assets-cdn.github.com"];
  #"185.199.110.133" = ["avatars.githubusercontent.com" "avatars0.githubusercontent.com" "avatars5.githubusercontent.com" #"camo.githubusercontent.com"];
  #"185.199.108.133" = ["avatars1.githubusercontent.com" "avatars2.githubusercontent.com" "avatars3.githubusercontent.com" #"github.map.fastly.net" "media.githubusercontent.com"];
  #"140.82.112.22" = ["central.github.com"];
  #"185.199.111.133" = ["avatars4.githubusercontent.com" "cloud.githubusercontent.com" "favicons.githubusercontent.com" #"raw.githubusercontent.com" "private-user-images.githubusercontent.com"];
  #"140.82.116.9" = ["codeload.github.com"];
  #"140.82.112.21" = ["collector.github.com"];
  #"185.199.109.133" = ["desktop.githubusercontent.com" "objects.githubusercontent.com"];
  #"140.82.116.3" = ["gist.github.com"];
  #"3.5.27.235" = ["github-cloud.s3.amazonaws.com"];
  #"52.216.56.193" = ["github-com.s3.amazonaws.com"];
  #"16.15.200.250" = ["github-production-release-asset-2e65be.s3.amazonaws.com" "github-production-repository-file-5c1aeb.s3.amazonaws.com" #"github-production-user-asset-6210df.s3.amazonaws.com"];
  #"192.0.66.2" = ["github.blog"];
  #"140.82.116.4" = ["github.com"];
  #"140.82.114.18" = ["github.community"];
  #"185.199.108.154" = ["github.githubassets.com"];
  #"151.101.1.194" = ["github.global.ssl.fastly.net"];
  #"185.199.108.153" = ["github.io" "githubstatus.com"];
  #"140.82.114.26" = ["live.github.com"];
  #"13.107.42.16" = ["pipelines.actions.githubusercontent.com"];
  #"13.107.253.69" = ["vscode.dev"];
  #"140.82.113.21" = ["education.github.com"];
  #};


  #USTC Mirror
  nix.settings.substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://nix-gaming.cachix.org" ];
  nix.settings.trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];


  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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
  users.users.cypher = {
    isNormalUser = true;
    description = "Cypher";
    extraGroups = [ "networkmanager" "wheel" "tun" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      clash-verge-rev
    ];
    #openssh.authorizedKeys.keyFiles = [ "../.ssh/id_rsa" ];
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
    git
  ];
  i18n.inputMethod = {
     type = "fcitx5";
     enable = true;
     fcitx5.addons = with pkgs; [
       fcitx5-mozc
       fcitx5-gtk
       fcitx5-chinese-addons
       fcitx5-pinyin-moegirl
       fcitx5-pinyin-zhwiki
       #fcitx5-qt
     ];
  };

  #Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?

}
