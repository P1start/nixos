{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "2018-12-08";
  name = "scientifica-${version}";

  src = fetchFromGitHub {
    owner = "P1start";
    repo = "scientifica";
    rev = "1a26801e16f963b3f3c7de316f5ced51dd1ac998";
    sha256 = "1mh4zxyy3jqv2bdr3pw6bjkqk4y8whxlr4cnqh8cplaw5k1p4x2x";
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
