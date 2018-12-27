{ oldPkgs }:

let
  xResources = ./config/xresources.nix;
in
oldPkgs // rec {
  # i3
  i3 = oldPkgs.i3-gaps.overrideAttrs (_: {
    patches = [
      ./patches/i3-gaps-drag.patch
      ./patches/i3-gaps-padding.patch
    ];
  });
  i3Config = oldPkgs.writeText "i3-config" (import ./config/i3/config.nix {
    inherit lockCommand terminalCommand firefoxCommand i3 rofiTheme xResources polybarConfig nvim;
    pkgs = oldPkgs;
    rofi = oldPkgs.rofi; polybar = polybarPkg; ncmpcpp = oldPkgs.ncmpcpp; anki = oldPkgs.anki; brightnessctl = oldPkgs.brightnessctl; ipython3 = oldPkgs.python37Packages.ipython; ipython2 = oldPkgs.python27Packages.ipython; htop = oldPkgs.htop; mpc = oldPkgs.mpc_cli; thunderbird = oldPkgs.thunderbird; pidgin = oldPkgs.pidgin; gucharmap = oldPkgs.gucharmap; pulseaudio = oldPkgs.pulseaudio;
  });
  lockCommand = "${oldPkgs.i3lock-color}/bin/i3lock-color -B 3 --linecolor=00000000 --separatorcolor=00000000 --insidecolor=36404177 --ringcolor=5b6c6ebb --keyhlcolor=e2efebbb --bshlcolor=b1bbb888 --insidevercolor=36404177 --ringvercolor=5b6c6ebb --insidewrongcolor=36404177 --ringwrongcolor=5b6c6ebb --verifcolor=e2efeb88 --wrongcolor=e2efeb88 --veriftext='...' --wrongtext='Wrong!' --veriftext='Verifying...' --noinputtext='No input!' --verifsize=20 --wrongsize=20";
  # polybar
  polybarPkg = oldPkgs.polybar.override { i3GapsSupport = true; i3-gaps = i3; pulseSupport = true; mpdSupport = true; };
  polybarModules = oldPkgs.callPackage ./pkgs/polybar-modules/default.nix {};
  polybarConfig = oldPkgs.writeText "polybar-config" (import ./config/polybar/config.nix { inherit polybarModules; python3 = oldPkgs.python3; });
  # termite
  termiteConfig = oldPkgs.writeText "termite-config" (import ./config/termite/config.nix);
  termitePkg = oldPkgs.termite.overrideAttrs (oldAttrs: {
    patches = oldAttrs.patches ++ [ ./patches/termite-unfocused-bg.patch ];
    postInstall = ''
      ${oldAttrs.postInstall}
      wrapProgram $out/bin/termite --add-flags '--config=${termiteConfig} --name=Termite --class=Termite'
    '';
  });
  terminalCommand = "${termitePkg}/bin/termite";
  # nvim
  nvim = oldPkgs.neovim.override {
    vimAlias = true;
    configure = (import ./config/nvim/customization.nix { pkgs = oldPkgs; });
  };
  # Firefox
  firefoxPkg = oldPkgs.firefox // {
    unwrapped = oldPkgs.firefox.unwrapped.overrideAttrs (oldAttrs: {
      postPhases = [ ''
        cp -d --no-preserve='ownership' ${./config/firefox/userChrome.css} lib/firefox/browser/chrome/
      '' ];
    });
  };
  firefoxCommand = "${firefoxPkg}/bin/firefox";
  # rofi
  rofiTheme = ./config/rofi/config.rasi;
  # Theme
  arc-theme = oldPkgs.arc-theme.overrideAttrs (_: {
    patchPhase = ''
      for gtk_dir in $(realpath common/gtk-3.0/3.*/sass | uniq); do
        echo -e ".termite { padding: 25px; }" >> $gtk_dir/_applications.scss
      done
    '';
  });
  # Custom packages
  scientifica = oldPkgs.callPackage ./pkgs/scientifica/default.nix {};
}
