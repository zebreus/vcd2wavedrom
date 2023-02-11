{
  description = "Symbolator is a component diagramming tool for VHDL and Verilog.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      rec {
        name = "vcd2wavedrom";
        packages.vcd2wavedrom = import ./default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.default = packages.vcd2wavedrom;
      }
    );
}
