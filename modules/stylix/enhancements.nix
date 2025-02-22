{ config, lib, ... }:

with lib;

{
  config = {
    # 动态主题切换服务（参考搜索结果）
    systemd.user.services.stylix-sync = {
      serviceConfig.ExecStart = "${config.stylix.package}/bin/stylix-cli apply";
      wantedBy = [ "graphical-session.target" ];
    };

    # 跨平台同步配置（支持KDE Plasma和Niri）
    stylix.targets = mkMerge [
      {
        plasma6.enable = true;
        niri.enable = true;
        crossPlatform = {
          gtk = true;
          qt = true;
          vscode = true;
        };
      }
    ];

    # 颜色变量继承（支持动态调整）
    stylix.override = mkIf (config.stylix.enable) {
      base16 = config.lib.stylix.colors;
    };
  };
}
