{ config, pkgs, ... }:

{
  # Niri窗口管理器配置
  services.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri;
    
    # Stylix集成
    settings = let
      stylix = config.stylix.colors;
    in {
      background = {
        image = config.stylix.image;
        color = "#${stylix.base00}";
      };
      
      border = {
        active = "#${stylix.base0B}";
        inactive = "#${stylix.base03}";
      };
    };
  };

  # Wayland会话支持
  services.greetd.settings.default_session.command = 
    "${pkgs.niri}/bin/niri-session";
}
