{
  description = "A mix of packages that are not in nixpkgs, or that I wish to modify in some way.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {self, nixpkgs} :
    let
      forAllSystems = function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-darwin"
        ] (system: function nixpkgs.legacyPackages.${system} system);
    in
      {
        packages = forAllSystems (pkgs: system: import ./pkgs pkgs);
      };
}
