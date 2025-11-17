{
  description = "mcp registory flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    serena = {
      url = "github:oraios/serena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    context7 = {
      url = "github:upstash/context7";
      flake = false;
    };
    chrome-devtools = {
      url = "github:ChromeDevTools/chrome-devtools-mcp";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        # packages
        serena = inputs.serena.packages.${system}.serena;
        
        context7 = import ./context7.nix {
          mkDerivation = pkgs.stdenvNoCC.mkDerivation;
          inherit pkgs;
          src = inputs.context7;
          getExe = nixpkgs.lib.getExe;
          nodejs = pkgs.nodejs-slim;
        };

        chrome-devtools = import ./chrome-devtools.nix {
          inherit pkgs inputs;
        };
      in
      {
        packages = {
          inherit serena context7 chrome-devtools;
        };
      }
    );
}
