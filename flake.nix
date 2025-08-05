{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
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

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    lanzaboote,
    hjem,
    quickshell,
    watt,
    ...
  }@inputs:

  let
    mkBillfish = hostname: nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/billfish/configuration.nix  # Shared configuration
        ./hosts/billfish/${hostname}/hardware-configuration.nix  # Host-specific hardware config
        hjem.nixosModules.default
        watt.nixosModules.default
        { networking.hostName = hostname; }
      ];
      specialArgs = { inherit inputs; };
    };
  in {
    # The billfish (service VM) fleet
    marlin = mkBillfish "marlin";
    sailfish = mkBillfish "sailfish";
    swordfish = mkBillfish "swordfish";
    spearfish = mkBillfish "spearfish";
  
    nixosConfigurations = {
      croaker = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/croaker/configuration.nix
          lanzaboote.nixosModules.lanzaboote
          hjem.nixosModules.default
          watt.nixosModules.default
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
