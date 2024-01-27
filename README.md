# MkDocs Template Nix

This repository provides a nix lib for building mkdocs sites with default config. 

## Usage

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
          docs = ./docs;
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

## Formatting test

- list1
  - list1.1
  - list1.2
- list2
  - list2.1
  - list2.2
