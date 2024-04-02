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
      example = mkdocs-tmpl-nix.lib.${system}.mkDocs {
          name = "example";
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
  nix build .#example
  ```

## Formatting test

- list1
  - list1.1
  - list1.2
- list2
  - list2.1
  - list2.2

> [!note]
> 
> This is a note.

> [!tip]
> 
> This is a tip.
