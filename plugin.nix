{
  self,
  prev,
}:
let
  inherit (prev) lib vimUtils fetchFromGitHub;
  inherit (vimUtils) buildVimPlugin;

  # eagerly loaded on startup (stable)
  start-stable = with prev.vimPlugins; [
    # <todo>
    auto-pairs

    # <todo>
    (buildVimPlugin {
      name = "vim-lsp";
      src = fetchFromGitHub {
        owner = "yegappan";
        repo = "lsp";
        rev = "0110ae71fd10e798e68b1c203735ca2143833d9c";
        sha256 = "sha256-A4f9i1WZU/9Qlv1hJeS+MCRlDjy0oDavsFC2IEgNIVE";
      };
    })
  ];

  # lazily loaded by calling `:packadd $name` (stable)
  opt-stable = [ ];

  # <todo>
  plugins = start-stable ++ opt-stable;

  # <todo>
  vendor = [
    "${self}/vendor/libcolor"
    "${self}/vendor/libparser"
    "${self}/vendor/libpath"
    "${self}/vendor/libreactive"
    "${self}/vendor/librelalg"
    "${self}/vendor/libtinytest"
    "${self}/vendor/libversion"
  ];

  # <todo>
  runtimepath = lib.concatStringsSep "\n" [
    (lib.concatMapStringsSep "\n" (pkg: "set runtimepath+=${pkg}") vendor)
    (lib.concatMapStringsSep "\n" (pkg: "set runtimepath+=${pkg}") plugins)
  ];
in
{
  inherit runtimepath;

  # <todo>
  packages = {
    custom = {
      start = start-stable;
      opt = opt-stable;
    };
  };
}
