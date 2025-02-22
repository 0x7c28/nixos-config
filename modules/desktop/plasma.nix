{ config, pkgs, ... }:

{
  # KDE Plasma核心配置（参考生产力技巧）
  services.xserver.desktopManager.plasma6 = {
    enable = true;

  services.xserver.desktopManager.plasma6.configFile = {
    "kdeglobals" = "${config.stylix.scheme}/kdeglobals";
  };
    
    # Stylix集成优化
    stylixIntegration = {
      enable = true;
      overrideConfig = ''
        [General]
        ColorScheme=${config.stylix.scheme.slug}
        Contrast=${toString config.stylix.contrast}
      '';
    };

    # 生产力增强组件（参考）
    extraPackages = with pkgs; [
      plasma6Packages.krunner
      plasma6Packages.kde-cli-tools
      plasma6Packages.dolphin-plugins
    ];
  };

  # Plasma优化参数（参考跳转列表特性）
  environment.variables = {
    KDE_JUMPLIST_ACTIONS = "10";
    PLASMA_USE_QT_SCALING = "1";
  };
}
