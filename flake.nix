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
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # custom overlay, see: https://anthonyoleinik.com/blog_directory/nix-overlays/
        overlay = _: prev: {
          vim = prev.vim-full.customize {
            name = "vim";
            vimrcConfig = {
              customRC = ''
                set runtimepath+=${self}
                source ${self}/.vimrc
              '';
            };
          };
        };

        # shell used by 'nix develop', see: https://nix.dev/manual/nix/2.17/command-ref/new-cli/nix3-develop
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.vim ];
          shellHook = ''
            alias vim='vim --cmd "set runtimepath+=${self}" -u ${self}/.vimrc'
          '';
        };
      }
    );
}
