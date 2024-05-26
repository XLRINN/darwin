{
  description = "DARWIN-LOKI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, nix-homebrew, ... }:
    let
      system = "x86_64-darwin";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
    in {
      # Define system-wide packages and configurations
      darwinConfigurations = {
        loki = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            {
              # System packages
              environment.systemPackages = with pkgs; [
                vim
                zoxide
                thefuck
                ranger
                neovim
                alacritty
                tmux
                home-manager
                neofetch
                python3
                bitwarden-cli
		nerdfonts
		lazygit

              ];
              services.nix-daemon.enable = true;
              system.stateVersion = 4;
            }
          ];
        };
      };

 modules = [
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # User owning the Homebrew prefix
            user = "david";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
      ];
    };
  
}

