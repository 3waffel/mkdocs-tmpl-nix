# MkDocs Template Nix

- Include the module in your flake inputs
  ```nix
  {
      inputs.mkdocs-tmpl-nix.url = "github:3waffel/mkdocs-tmpl-nix";
  }
  ```

- Use the lib in your package outputs
  ```nix
  {
      # ...
      docs = mkdocs-tmpl-nix.lib.${system}.mkDocs {
          name = "docs";
          docs = "./docs";
          extraConfig = {
              "site_name" = "Some Site";
              "site_url" = "https://example.com";
          };
      };
  }
  ```

- Build the package
  ```
  nix build .#docs
  ```
