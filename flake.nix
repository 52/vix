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

            # Override the upstream package to v9.1.1591 for native wayland support,
            # and the insert mode & command-line autocomplete upgrades.
            # TODO: Remove when available in nixpkgs-unstable.
            # See: https://github.com/vim/vim/issues/5157/
            # See: https://github.com/vim/vim/pull/17812/
            package = prev.vim-full.overrideAttrs (attrs: rec {
              version = "9.1.1591";

              src = prev.fetchFromGitHub {
                owner = "vim";
                repo = "vim";
                rev = "v${version}";
                hash = "sha256-aiHvj01EuV0zivj2WJdWZu8+QOQiGssEK4DDRRJ5Gvc=";
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

              # vim
              vim-language-server
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
