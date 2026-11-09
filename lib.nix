pkgs:
let
  inherit (pkgs) lib;
  section = page: lib.last (lib.splitString "." page);
  build =
    name: sources:
    pkgs.runCommand "${name}-man" { nativeBuildInputs = [ pkgs.pandoc ]; } (
      lib.concatStrings (
        lib.mapAttrsToList (page: src: ''
          mkdir -p "$out/share/man/man${section page}"
          pandoc --standalone --from markdown-smart-raw_html --to man ${src} \
            -o "$out/share/man/man${section page}/${page}"
        '') sources
      )
    );
in
{
  fromFiles = sources: build (lib.concatStringsSep "-" (lib.attrNames sources)) sources;
  fromDir =
    dir: pages: build (lib.concatStringsSep "-" pages) (lib.genAttrs pages (p: dir + "/${p}.md"));
  fromMarkdown = page: text: build page { ${page} = pkgs.writeText "${page}.md" text; };
}
