{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    dde-nixos = {
      url = "github:linuxdeepin/dde-nixos";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        
      };
    };
  };

  outputs = { self, nixpkgs, home-manager, dde-nixos, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        BaldrNix = lib.nixosSystem {
          inherit system;
          modules = [
            (import dde-nixos).nixosModules.${system}
            {
              services.xserver.desktopManager.deepin-unstable.enable = true;
              environment.fonts.package = with pkgs; [
                noto-fonts
                ttf-dejavu
                # Add more font packages if needed
              ];
            }
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        david = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}

