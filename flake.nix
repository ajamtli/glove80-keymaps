{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, utils, devshell }:
    utils.lib.eachDefaultSystem (system: {
      devShells = rec {
        default = let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ devshell.overlays.default ];
          };
        in pkgs.devshell.mkShell {
            devshell.packages = [
              pkgs.graphicsmagick
              pkgs.graphviz
              pkgs.poppler-utils
              pkgs.ruby
              pkgs.rubyPackages.erb-formatter
            ];
        };
      };
    });
}
