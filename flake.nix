{
  description = "mcp registory flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bun2nix = {
      url = "github:baileyluTCD/bun2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    { nixpkgs, flake-utils, bun2nix, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        # packages
        serena = inputs.serena.packages.${system}.serena;
        
        context7 = import ./context7.nix {
          inherit pkgs inputs system;
        };

        chrome-devtools = import ./chrome-devtools.nix {
          inherit pkgs inputs;
        };
      in
      {
        packages = {
          inherit serena context7 chrome-devtools;
        };
        apps = {
          gen-bun2nix = let 
            script = pkgs.writeScriptBin "gen-bun2nix" ''
              #! /bin/sh
              ${bun2nix.packages.${system}.default}/bin/bun2nix -l context7-bun.lock -o context7-bun.nix
            ''; 
          in {
            type = "app";
            program = "${script}/bin/gen-bun2nix";
          };
        };
      }
    );
  
  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
};
}
