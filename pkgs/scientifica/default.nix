{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "2019-12-08";
  name = "scientifica-${version}";

  src = fetchFromGitHub {
    owner = "P1start";
    repo = "scientifica";
    rev = "f671a7743138455c7f01247acd3ecfb2bdc0f515";
    sha256 = "1ys530lrkhwnxdlpgc7pfhd5fsnckry96sklbqb18d16dmzkb5z6";
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
