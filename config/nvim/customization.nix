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
      { name = "vim-nix"; }
      { name = "vim-gitgutter"; }
      { name = "ctrlp-vim"; }
      { name = "rust-vim"; }
      { name = "idris-vim"; }
      { name = "vim-orgmode"; }
      { name = "vimtex"; }
      { name = "zig-vim"; }
      { name = "vim-fish"; }
      { name = "coc-nvim"; }
    ];
  };
}
