{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, system-manager, nix-system-graphics, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.default = pkgs.buildEnv {
        name = "system-packages";
        paths = [
          pkgs.stow
          pkgs.waybar
          pkgs.nerd-fonts.symbols-only
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.ghostty
          pkgs.neovim
          pkgs.tmux
          pkgs.p7zip
          pkgs.lazygit
          pkgs.lazydocker
          pkgs.btop
          pkgs.yggdrasil
          pkgs.yazi
          pkgs.fzf
          pkgs.zoxide
          pkgs.wofi
          pkgs.tree-sitter
          pkgs.brightnessctl
          pkgs.wlogout
          pkgs.swayidle
          pkgs.swaynotificationcenter
          pkgs.bluetuith
        ];
      };

      systemConfigs.default = system-manager.lib.makeSystemConfig {
        modules = [
          nix-system-graphics.systemModules.default
          {
            nixpkgs.hostPlatform = "x86_64-linux";
            system-manager.allowAnyDistro = true;
            system-graphics.enable = true;
          }
        ];
      };
    };
}
