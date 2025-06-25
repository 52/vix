{
  description = "A modern, minimal(ish) Vim distribution.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      inherit (builtins) attrValues;
      inherit (lib) concatLists;
    in
    {
      overlays = {
        default = _: prev: {
          vim-custom = prev.vim-full.customize {
            name = "vim";
            vimrcConfig = {
              # set the runtimepath to the flake directory.
              # this serves as the entrypoint for the distribution.
              customRC = ''
                set runtimepath=${self},$VIMRUNTIME,${self}/after

                " recursively add 'vendor' to the runtimepath
                for dir in glob('${self}/vendor/*', 1, 1)
                  if isdirectory(dir)
                    let &runtimepath = dir . ',' . &runtimepath
                  endif
                endfor
                                  
                source ${self}/.vimrc

                if has('gui_running') && filereadable('${self}/.gvimrc')
                  source ${self}/.gvimrc
                endif
              '';
              packages = {
                custom = {
                  # eagerly loaded on startup
                  start = concatLists [
                    # stable channel
                    (with prev.vimPlugins; [ ])

                    # custom channel
                    (with prev.vimUtils; [ ])
                  ];

                  # lazily loaded by calling `:packadd $name`
                  opt = concatLists [ ];
                };
              };
            };
          };
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in
      {
        # shell used by 'nix develop', see: https://nix.dev/manual/nix/2.17/command-ref/new-cli/nix3-develop
        devShell = pkgs.mkShell {
          buildInputs = attrValues {
            inherit (pkgs)
              vim-custom
              ;
          };
          shellHook = ''
            echo "Entering the 'github:52/vim' development environment"
            echo "Execute 'vim' or 'gvim' to open the build"
          '';
        };
      }
    );
}
