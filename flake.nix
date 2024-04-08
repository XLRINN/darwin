{
description = "first flake";

inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
};

outputs =  {self,nixpkgs, ...}:
    let    
        lib = nixpkgs.lib;
in {
    nixosConfigurations = {
        nix-xlrin = lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./configuration.nix];
        };
    };

 };

}