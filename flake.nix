{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    watt = {
      url = "github:NotAShelf/watt";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, stylix, lanzaboote, hjem, quickshell, watt, ... } @ inputs: {
    nixosConfigurations = {
      croaker = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hosts/croaker/configuration.nix
	        home-manager.nixosModules.default
	        stylix.nixosModules.stylix
	        lanzaboote.nixosModules.lanzaboote
	        hjem.nixosModules.default
	      ];
        specialArgs = { inherit inputs; };
      };
      docker-host = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
	      modules = [
	        ./hosts/docker-host/configuration.nix
	        home-manager.nixosModules.default
	        stylix.nixosModules.stylix
	      ];
	      specialArgs = { inherit inputs; };
      };
      anchovy = nixpkgs.lib.nixosSystem {
	      system = "x86_64-linux";
	      modules = [
	        ./hosts/anchovy/configuration.nix
	        lanzaboote.nixosModules.lanzaboote
	        hjem.nixosModules.default
          watt.nixosModules.default
	      ];
	      specialArgs = { inherit inputs; };
      };
    };
  };
}
