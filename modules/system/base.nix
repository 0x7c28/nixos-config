{ config, pkgs, ... }:

{
  # 基础依赖
  environment.systemPackages = with pkgs; [
    stylix-cli
    nix-output-monitor
  ];

  # Stylix核心配置
  stylix.enable = true;
  stylix.autoEnable = {
    gtk = true;
    qt = true;
    vscode = true;
  };
}
