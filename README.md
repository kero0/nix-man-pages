# nix-man-pages

Man pages from markdown, built with pandoc's man writer, for NixOS and
home-manager configs.

```nix
inputs.man-pages.url = "github:kero0/nix-man-pages";

# as an overlay: pkgs.man-pages
nixpkgs.overlays = [ inputs.man-pages.overlays.default ];

# or directly
man = inputs.man-pages.lib.mkLib pkgs;
```

Each function returns a package with `share/man/man<section>/<page>`:

- `fromDir ./man [ "app.1" ]`: pages `./man/<page>.md`
- `fromFiles { "app.1" = ./app.md; }`
- `fromMarkdown "app.1" ''...''`: a page generated in Nix

A source starts with a pandoc title block (`% APP(1) | My tools`), then
NAME, SYNOPSIS, DESCRIPTION, ... as `#` headings. The section is the last
part of the page's name.
