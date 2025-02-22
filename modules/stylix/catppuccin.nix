{ config, inputs, lib, ... }:

with lib;

{
  config = {
    stylix.base16Scheme = 
      "${inputs.catppuccin}/catppuccin-${config.theme.catppuccin.flavor}.yaml";

    stylix.overrides = {
      # VS Code深度整合
      vscode = {
        extensions = [ "catppuccin.catppuccin-vsc" ];
        settings = {
          "workbench.colorTheme" = "Catppuccin ${config.theme.catppuccin.flavor}";
          "catppuccin.accentColor" = "mauve";
        };
      };
    };
  };
}
