{ config, inputs, lib, ... }:

with lib;

{
  config = {
    stylix.base16Scheme = 
      "${inputs.gruvbox-materia}/palettes/${config.theme.gruvbox.palette}-${config.theme.gruvbox.contrast}.yaml";

    stylix.override = {
      # 护眼优化参数
      brightness = {
        base = 0.88;
        surface = 0.94;
      };
      
      # 终端兼容设置
      terminal = {
        kitty.settings = {
          background = mkForce "#${config.lib.stylix.colors.base00}";
          foreground = mkForce "#${config.lib.stylix.colors.base05}";
        };
      };
    };
  };
}
