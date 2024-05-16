{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        BaldrNix = lib.nixosSystem {
          inherit system;
          modules = [
            #{
              #environment.fonts.package = with pkgs; [
               # noto-fonts
                #ttf-dejavu
                # Add more font packages if needed
              #];
            #}
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
