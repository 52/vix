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

            # Override the upstream package to v9.1.1540 for native wayland support.
            # Todo: Remove when available in nixpkgs-unstable.
            # See: https://github.com/vim/vim/issues/5157
            package = prev.vim-full.overrideAttrs (attrs: rec {
              version = "v9.1.1540";

              src = prev.fetchFromGitHub {
                owner = "vim";
                repo = "vim";
                rev = "v${version}";
                hash = "sha256-IO0SX39g0hWtemq6r2c1OjUBBpu0fvhq1vzDBjkFrnU=";
              };

              buildInputs = attrs.buildInputs ++ [
                prev.wayland-scanner
              ];
            });
          in
          {
            vix = package.customize {
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
        # Shell used by 'nix develop', see: https://nix.dev/manual/nix/2.17/command-ref/new-cli/nix3-develop
        devShell = pkgs.mkShell {
          buildInputs = attrValues {
            inherit (pkgs)
              # nix
              nixfmt-rfc-style
              deadnix
              statix
              nixd

              # vix
              vix
              ;
          };
          shellHook = ''
            echo "Entering the 'github:52/vix' development environment"
            echo "Execute 'vim' or 'gvim' to open the build"
          '';
        };
      }
    );
}
