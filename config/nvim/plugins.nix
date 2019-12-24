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
  "vim-llvm" = buildVimPlugin {
    name = "vim-llvm";
    src = fetchFromGitHub {
      owner = "rhysd";
      repo = "vim-llvm";
      rev = "64f121c447154debbe0ee6670380190bb58ae4aa";
      sha256 = "14s9kz124imgdngpqpk7gm8qbn68l5g4nd22a1zk625gayw15jrs";
    };
    dependencies = [];
  };
}
