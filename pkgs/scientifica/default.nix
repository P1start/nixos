{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "2019-12-08";
  name = "scientifica-${version}";

  src = fetchFromGitHub {
    owner = "P1start";
    repo = "scientifica";
    rev = "90656bbf408ab5b52c61f8b2cbee74aac75d50a1";
    sha256 = "1lggf6bg35fqsbmlclb74b9y60q9rlqmwmps5b37pl5zd1jhg668";
  };

  installPhase = ''
    install -d $out/share/fonts
    cp -d --no-preserve='ownership' regular/scientifica.otb $out/share/fonts/scientifica.otb
    cp -d --no-preserve='ownership' bold/scientificaBold.otb $out/share/fonts/scientificaBold.otb
  '';

  meta = with stdenv.lib; {
    description = "Tall and condensed bitmap font for geeks (modified from nerdypepper/scientifica)";
    homepage = https://github.com/P1start/scientifica;
    platforms = platforms.linux;
  };
}
