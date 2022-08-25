{
  description = "The Apache Milagro (Incubating) Decentralized Trust Authority (D-TA) is a collaborative key management server.";

  inputs = {
    # Nixpkgs / NixOS version to use.
    nixpkgs.url = "nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
    
    # Upstream source tree(s).
    milagro-crypto-js = {
      url = "github:apache/incubator-milagro-crypto-js";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    let
      # Generate a user-friendly version numer.
      versions =
        let
          generateVersion = builtins.substring 0 8;
        in
          nixpkgs.lib.genAttrs
            [ "milagro-crypto-js" ]
            (n: generateVersion inputs."${n}".lastModifiedDate);

      # local_overlay = import ./pkgs inputs versions;
      local_overlay = import ./node-packages;
      
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        # if you have additional overlays, you may add them here
        overlays = [
          local_overlay
        ];
      };

    in flake-utils.lib.eachDefaultSystem  (system: rec {
      legacyPackages = pkgsForSystem system;

      packages = {
        milagro-crypto-js = legacyPackages.nodePackages.milagro-crypto-js;
        default = legacyPackages.nodePackages.milagro-crypto-js;
      };

      # Default shell
      devShells.default = legacyPackages.mkShell {
        packages = [
          # legacyPackages.nodejs
          # legacyPackages.nodePackages.milagro-crypto-js
          packages.default
        ];
      };
      })  // {
      overlays = {
        default = final: prev: local_overlay;
        all = final: prev: local_overlay;
      };
    };
}
