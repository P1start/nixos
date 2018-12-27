{ stdenv }:

stdenv.mkDerivation rec {
  version = "0.0.0";
  name = "polybar-modules-${version}";

  src = ./src;

  installPhase = ''
    install -d $out
    cp -d --no-preserve='ownership' *.py $out/
  '';

  meta = with stdenv.lib; {
    description = "Some neat modules for polybar";
  };
}
