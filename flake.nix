{
  description = "Man pages from markdown (pandoc), for Nix configs";

  outputs =
    { self }:
    {
      # mkLib pkgs -> { fromFiles, fromDir, fromMarkdown }
      lib.mkLib = import ./lib.nix;

      # pkgs.man-pages.{fromFiles,fromDir,fromMarkdown}
      overlays.default = final: _prev: { man-pages = self.lib.mkLib final; };
    };
}
