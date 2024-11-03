{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, disko, home-manager, stylix, nixvim, firefox-addons, ... }@inputs: {
    nixosConfigurations.elder-dragon = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/elder-dragon/configuration.nix
        home-manager.nixosModules.home-manager 
	{
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		
		# define user config
		home-manager.users.mdnaina = import ./home/mdnaina.nix;
	}
      ];
    };
    nixosConfigurations.nexus = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/nexus/configuration.nix
	disko.nixosModules.disko
        # inputs.home-manager.nixosModules.default
      ];
    };
  };
}
