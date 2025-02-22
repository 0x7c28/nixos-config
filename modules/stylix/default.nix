{ config, lib, inputs, ... }:

imports = [ ./enhancements.nix ];

with lib;

let
  cfg = config.theme;
in {
  options.theme = {
    active = mkOption {
      type = types.str;
      default = "gruvbox-materia";
      description = "Active theme selection";
    };

    gruvbox = {
      contrast = mkOption {
        type = types.str;
        default = "hard";
        description = "Contrast level (soft/medium/hard)";
      };
      palette = mkOption {
        type = types.str;
        default = "material";
        description = "Palette variant (material/mix/original)";
      };
    };

    catppuccin.flavor = mkOption {
      type = types.str;
      default = "mocha";
      description = "Catppuccin flavor (mocha/macchiato/frappe/latte)";
    };
  };

  config = mkMerge [
    (mkIf (cfg.active == "gruvbox-materia") {
      imports = [ ./gruvbox-materia.nix ];
    })
    
    (mkIf (cfg.active == "catppuccin") {
      imports = [ ./catppuccin.nix ];
    })
  ];
}
