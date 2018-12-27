{ stdenv }:

stdenv.mkDerivation rec {
  version = "0.1.0";
  name = "icons-${version}";

  src = ./src;

  installPhase = ''
    install -d $out/share/icons
    cp -dr --no-preserve='ownership' default $out/share/icons/
  '';

  meta = with stdenv.lib; {
    license = licenses.mit;
    platforms = platforms.linux;
    description = "My icon theme configuration for GTK+2";
  };
}
