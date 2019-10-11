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
  "vim-glsl" = buildVimPlugin {
    name = "vim-glsl";
    src = fetchFromGitHub {
      owner = "tikhomirov";
      repo = "vim-glsl";
      rev = "697eca9784ffac39308e1fd45e0300582c3d060b";
      sha256 = "1yvjlm90alc4zsdsppkmsja33wsgm2q6kkn9dxn6xqwnq4jw5s7h";
    };
    dependencies = [];
  };
}
