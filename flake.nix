{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "git+ssh://git@github.com/NixOS/nixpkgs/nixos-unstable";
    stylix.url = "git+ssh://git@github.com/danth/stylix";
    niri.url = "git+ssh://git@github.com/sodiboo/niri";
    
    # 主题仓库（SSH协议）
    gruvbox-materia = {
      url = "git+ssh://git@github.com/sainnhe/gruvbox-material";
      flake = false;
    };
    catppuccin = {
      url = "git+ssh://git@github.com/catppuccin/base16-schemes";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      my-host = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./modules/system/ssh.nix
          ./modules/system/base.nix
	  ./modules/desktop/plasma.nix
	  ./modules/desktop/niri.nix
          {
            imports = [ ./modules/stylix ];
            theme.active = "catppuccin"; # gruvbox-materia/catppuccin
          }
        ];
      };
    };
  };
}
