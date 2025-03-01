{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-24.11 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    #home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "git+ssh://git@github.com/nix-community/home-manager.git?ref=release-24.11";
    nix-gaming.url = "git+ssh://git@github.com/fufexan/nix-gaming.git";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # 请将下面的 my-nixos 替换成你的 hostname
    nixosConfigurations.x99-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # 这里导入之前我们使用的 configuration.nix，
        # 这样旧的配置文件仍然能生效
        ./configuration.nix
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            #nix-gaming
            nix-gaming.nixosModules.default

            # 这里的 ryan 也得替换成你的用户名
            # 这里的 import 函数在前面 Nix 语法中介绍过了，不再赘述
            home-manager.users.cypher = import ./home.nix;

            # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home.nix 的参数
            # 取消注释下面这一行，就可以在 home.nix 中使用 flake 的所有 inputs 参数了
            # home-manager.extraSpecialArgs = inputs;
          }
	];
    };
  };
}
