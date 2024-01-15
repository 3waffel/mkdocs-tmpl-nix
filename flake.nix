{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages = {
          mkdocs = with pkgs;
            runCommand "mkdocs" {
              buildInputs = with python3Packages; [
                mkdocs
                mkdocs-material
                mkdocs-redirects
                pillow
              ];
            } ''
              mkdir -p $out/bin
              cat <<MKDOCS > $out/bin/mkdocs
              #!${bash}/bin/bash
              set -euo pipefail
              export PYTHONPATH=$PYTHONPATH
              exec ${mkdocs}/bin/mkdocs "\$@"
              MKDOCS
              chmod +x $out/bin/mkdocs
            '';
          docs = self.lib.${system}.mkDocs {
            name = "docs";
            docs = builtins.path {
              path = ./.;
              filter = path: type:
                builtins.elem (/. + path) [
                  ./README.md
                ];
            };
          };
          default = self.packages.${system}.mkdocs;
        };

        lib.mkDocs = {
          name,
          docs,
          extraConfig ? {"site_name" = "MkDocs Template Nix";},
        }: let
          mkdocs-yml = pkgs.concatText "mkdocs.yml" [
            ./base.yml
            ((pkgs.formats.yaml {}).generate "extra-config"
              extraConfig)
          ];
        in
          pkgs.stdenv.mkDerivation {
            inherit name;
            nativeBuildInputs = [
              self.packages.${system}.mkdocs
            ];

            unpackPhase = ''
              cp -r --no-preserve=mode ${docs} docs
              cp ${mkdocs-yml} mkdocs.yml
            '';

            buildPhase = ''
              mkdocs build
            '';

            installPhase = ''
              mv site $out
            '';
          };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            direnv
          ];
        };
      }
    );
}
