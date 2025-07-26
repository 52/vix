{
  self,
  prev,
}:
let
  inherit (prev) lib vimUtils fetchFromGitHub;
  inherit (vimUtils) buildVimPlugin;

  # Eagerly loaded on startup (stable).
  start-stable = with prev.vimPlugins; [
    # Link: https://github.com/jiangmiao/auto-pairs/
    auto-pairs

    # Link: https://github.com/yegappan/lsp/
    (buildVimPlugin rec {
      name = "lsp";
      src = fetchFromGitHub {
        owner = "yegappan";
        repo = "${name}";
        rev = "0110ae71fd10e798e68b1c203735ca2143833d9c";
        sha256 = "sha256-A4f9i1WZU/9Qlv1hJeS+MCRlDjy0oDavsFC2IEgNIVE";
      };
    })
  ];

  # Lazily loaded by calling `:packadd $name` (stable).
  opt-stable = [ ];

  # List of all plugins added (start + opt).
  plugins = start-stable ++ opt-stable;

  # List of local vendor libraries.
  vendor = [
    "${self}/vendor/libcolor"
    "${self}/vendor/libparser"
    "${self}/vendor/libpath"
    "${self}/vendor/libreactive"
    "${self}/vendor/librelalg"
    "${self}/vendor/libtinytest"
    "${self}/vendor/libversion"
  ];

  # Generate the 'runtimepath' entries.
  # Vendor libraries will be loaded first to ensure availability.
  # Followed by the plugins added in 'start-stable' and 'opt-stable'.
  runtimepath = lib.concatStringsSep "\n" [
    (lib.concatMapStringsSep "\n" (pkg: "set runtimepath+=${pkg}") vendor)
    (lib.concatMapStringsSep "\n" (pkg: "set runtimepath+=${pkg}") plugins)
  ];
in
{
  inherit runtimepath;

  packages = {
    custom = {
      start = start-stable;
      opt = opt-stable;
    };
  };
}
