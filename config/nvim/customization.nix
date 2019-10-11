{ pkgs }:

let
  vimrc = import ./vimrc.nix;
  plugins = pkgs.callPackage ./plugins.nix {};
in
{
  customRC = vimrc;
  vam = {
    knownPlugins = pkgs.vimPlugins // plugins;

    pluginDictionaries = [
      { name = "vim-gitgutter"; }
      { name = "ctrlp-vim"; }
      { name = "coc-nvim"; }
      { name = "vim-orgmode"; }
      # Languages
      { name = "vim-nix"; }
      { name = "vimtex"; }
      { name = "zig-vim"; }
      { name = "idris-vim"; }
      { name = "rust-vim"; }
      { name = "julia-vim"; }
      # Custom plugins
      { name = "vim-fish"; }
      { name = "vim-glsl"; }
    ];
  };
}
