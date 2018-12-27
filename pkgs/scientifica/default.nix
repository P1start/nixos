{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "2018-12-08";
  name = "scientifica-${version}";

  src = fetchFromGitHub {
    owner = "NerdyPepper";
    repo = "scientifica";
    rev = "7e8112156c6097b5c48d917b498e53dcfc6fdf15";
    sha256 = "0rv68q2myaajgzyihlzlrij3vrh2707sff7b6bg4qihbskbv95hh";
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
