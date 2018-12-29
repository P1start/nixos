{ pkgs, fetchFromGitHub }:

let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
in
{
  "vim-fish" = buildVimPlugin {
    name = "vim-fish";
    src = fetchFromGitHub {
      owner = "dag";
      repo = "vim-fish";
      rev = "50b95cbbcd09c046121367d49039710e9dc9c15f";
      sha256 = "1yvjlm90alc4zsdsppkmsja33wsgm2q6kkn9dxn6xqwnq4jw5s7h";
    };
    dependencies = [];
  };
}
