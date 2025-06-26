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
      inherit (builtins) attrValues;
    in
    {
      overlays = {
        default =
          _: prev:
          let
            plugin = import ./plugin.nix { inherit self prev; };
          in
          {
            vim-custom = prev.vim-full.customize {
              vimrcConfig = {
                inherit (plugin) packages;
                customRC = ''
                  set runtimepath=${self},$VIMRUNTIME,${self}/after
                  ${plugin.runtimepath}

                  source ${self}/.vimrc

                  if has('gui_running')
                    source ${self}/.gvimrc
                  endif
                '';
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
              # nix
              nixfmt-rfc-style
              deadnix
              statix
              nixd

              # vim
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
