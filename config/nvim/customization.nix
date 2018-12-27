{ pkgs }:

let
  vimrc = import ./vimrc.nix;
in
{
  customRC = vimrc;
  vam = {
    pluginDictionaries = [
      { name = "vim-nix"; }
      { name = "vim-gitgutter"; }
      { name = "ctrlp-vim"; }
      { name = "LanguageClient-neovim"; }
      { name = "rust-vim"; }
      { name = "idris-vim"; }
      { name = "vim-orgmode"; }
      { name = "vimtex"; }
      { name = "zig-vim"; }
    ];
  };
}
