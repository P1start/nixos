{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "2018-12-08";
  name = "scientifica-${version}";

  src = fetchFromGitHub {
    owner = "P1start";
    repo = "scientifica";
    rev = "d76d473d2f073b46e458908a31d6ce7fb5ce6f7d";
    sha256 = "1q1zhv3wvm3f9n421cvz115h9a6bf29qvsvi4s1llb34zf4csg97";
  };

  installPhase = ''
    install -d $out/share/fonts
    cp -d --no-preserve='ownership' regular/scientifica-11.bdf $out/share/fonts/scientifica-11.bdf
    cp -d --no-preserve='ownership' bold/scientificaBold-11.bdf $out/share/fonts/scientificaBold-11.bdf
  '';

  meta = with stdenv.lib; {
    description = "Tall and condensed bitmap font for geeks";
    homepage = https://github.com/NerdyPepper/scientifica;
    platforms = platforms.linux;
  };
}
