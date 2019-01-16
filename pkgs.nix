{ oldPkgs }:

let pkgs = oldPkgs // rec {
  # i3
  i3 = oldPkgs.i3-gaps.overrideAttrs (_: {
    patches = [
      ./patches/i3-gaps-drag.patch
      ./patches/i3-gaps-padding.patch
    ];
  });
  i3Config = pkgs.writeText "i3-config" (import ./config/i3/config.nix { inherit pkgs; });
  lockCommand = "${oldPkgs.i3lock-color}/bin/i3lock-color -B 3 --linecolor=00000000 --separatorcolor=00000000 --insidecolor=36404177 --ringcolor=5b6c6ebb --keyhlcolor=e2efebbb --bshlcolor=b1bbb888 --insidevercolor=36404177 --ringvercolor=5b6c6ebb --insidewrongcolor=36404177 --ringwrongcolor=5b6c6ebb --verifcolor=e2efeb88 --wrongcolor=e2efeb88 --veriftext='...' --wrongtext='Wrong!' --veriftext='Verifying...' --noinputtext='No input!' --verifsize=20 --wrongsize=20";
  # polybar
  polybar = oldPkgs.polybar.override { i3GapsSupport = true; i3-gaps = i3; pulseSupport = true; mpdSupport = true; };
  polybarModules = pkgs.callPackage ./pkgs/polybar-modules/default.nix {};
  polybarConfig = pkgs.writeText "polybar-config" (import ./config/polybar/config.nix { inherit pkgs; });
  # termite
  termiteConfig = pkgs.writeText "termite-config" (import ./config/termite/config.nix);
  termite = oldPkgs.termite.overrideAttrs (oldAttrs: {
    patches = oldAttrs.patches ++ [ ./patches/termite-unfocused-bg.patch ];
    postInstall = ''
      ${oldAttrs.postInstall}
      wrapProgram $out/bin/termite --add-flags '--config=${termiteConfig} --name=Termite --class=Termite'
    '';
  });
  terminalCommand = "${termite}/bin/termite";
  # nvim
  nvim = oldPkgs.neovim.override {
    vimAlias = true;
    configure = (import ./config/nvim/customization.nix { inherit pkgs; });
  };
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
  # bsdgames (includes a binary called 'fish' which conflicts with fish shell)
  bsdgames = oldPkgs.bsdgames.overrideAttrs (oldAttrs: { meta = oldAttrs.meta // { priority = 10; }; });
  # Custom packages
  my-icons = pkgs.callPackage ./pkgs/icons/default.nix {};
  scientifica = pkgs.callPackage ./pkgs/scientifica/default.nix {};
  keyboard-layouts = pkgs.callPackage ./pkgs/keyboard-layouts/default.nix {};
};
in
  pkgs
