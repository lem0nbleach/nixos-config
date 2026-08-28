{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stash = {
      url = "github:NotAShelf/stash";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    librepods = {
      url = "github:demenik/librepods";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprshutdown = {
      url = "github:hyprwm/hyprshutdown";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpwcenter = {
      url = "github:hyprwm/hyprpwcenter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprqt6engine = {
      url = "github:hyprwm/hyprqt6engine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlauncher = {
      url = "github:hyprwm/hyprlauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    hjem,
    quickshell,
    stash,
    librepods,
    nix-index-database,
    hyprshutdown,
    hyprpwcenter,
    hyprqt6engine,
    hyprlauncher,
    ...
  }@inputs:

  let
    mkBillfish = hostname: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/billfish/configuration.nix  # Shared configuration
        ./hosts/billfish/${hostname}/hardware-configuration.nix
        hjem.nixosModules.default
        nix-index-database.nixosModules.default
        { networking.hostName = hostname; }
      ];
      specialArgs = { inherit inputs; };
    };
  in {
    nixosConfigurations = {
      croaker = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/croaker/configuration.nix
          hjem.nixosModules.default
        ];
        specialArgs = { inherit inputs; };
      };
      anchovy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/anchovy/configuration.nix
          hjem.nixosModules.default
        ];
        specialArgs = { inherit inputs; };
      };
      # The billfish (service VM) fleet
      infrastructure = mkBillfish "infrastructure";
      game = mkBillfish "game";
      authentication = mkBillfish "authentication";
      non-data = mkBillfish "non-data";
      data = mkBillfish "data";
      media = mkBillfish "media";
      monitorization = mkBillfish "monitorization";
    };
  };
}
