{
  description = "ulfius Web Framework";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    ulfius = {
      url = "git+https://github.com/babelouest/ulfius";
      flake = false;
    };
  };

  outputs = {self, nixpkgs, ulfius} :
    let
      forAllSystems = function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
        ] (system: function nixpkgs.legacyPackages.${system} system);
    in
      {
        packages = forAllSystems (pkgs: system: {
          ulfius = pkgs.stdenv.mkDerivation {
            name = "ulfius";
            src = ulfius;
            outputs = ["out"];
            buildInputs = with pkgs;[
              jansson
              curl
              libmicrohttpd
              gnutls
              orcania
              yder
              pkg-config
              check
            ];

            installPhase = ''
              mkdir -p $out/lib
              make DESTDIR=$out install;
            '';
            checkPhase = "make check";
          };
        });
      };
}
