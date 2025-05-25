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
    {
      overlays = {
        default = _: prev: {
          vim = prev.vim-full.customize {
            name = "vim";
            vimrcConfig = {
              customRC = ''
                set runtimepath=${self},$VIMRUNTIME,${self}/after
                source ${self}/.vimrc
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
          buildInputs = [ pkgs.vim ];
          shellHook = ''
            # entrypoint for the development shell
            echo "Entering the 'github:52/vim' development environment"
            echo "Execute 'vim' to open the build"
          '';
        };
      }
    );
}
