{ config, pkgs, ... }:

let
  oldPkgs = pkgs;
in
let
  pkgs = import ./pkgs.nix { inherit oldPkgs; };
  ## Per-program configuration
  gitConfig = import ./config/git/config.nix { nvim = pkgs.nvim; };
  htopConfig = ./config/htop/htoprc;
  bashPrompt = pkgs.writeShellScriptBin "bash-prompt" (import ./config/bash/prompt.nix { git = pkgs.git; grep = pkgs.gnugrep; sed = pkgs.gnused; });
  promptCommand = "${bashPrompt}/bin/bash-prompt";
  fishGreeting = import ./config/fish/fish_greeting.nix { bsdgames = pkgs.bsdgames; };
  fishPrompt = import ./config/fish/fish_prompt.nix { inherit pkgs; };
  gtk2Config = ''
    gtk-icon-theme-name="Arc"
    gtk-cursor-theme-name="Numix-Cursor"
  '';
  themeEnv = ''
    # GTK: remove local user overrides (for determinisim, causes hard to find bugs)
    rm -f ~/.config/gtk-3.0/settings.ini
    rm -f ~/.config/.gtkrc-2.0

    export XDG_DATA_DIRS="${pkgs.arc-theme}/share:$XDG_DATA_DIRS"
    export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_DIRS"
    export GTK2_RC_FILES=${pkgs.writeText "iconrc" gtk2Config}:${pkgs.arc-theme}/share/themes/Arc-Darker/gtk-2.0/gtkrc:$GTK2_RC_FILES
  '';
in
{
  ## System packages

  # Packages to be installed in system profile
  environment.systemPackages = with pkgs; [
    # Command-line tools
    wget w3m git killall xlibs.xmodmap file brightnessctl scrot neofetch lsof xorg.xrdb mpc_cli htop gnugrep gnused aria2
    gnumake pkgconfig pwgen bsdgames highlight manpages unixtools.xxd
    # TUI applications
    nvim ncmpcpp
    # Background processes
    mpd burp
    # Desktop features
    termite polybar rofi i3lock-color
    arc-theme arc-icon-theme numix-cursor-theme
    # Desktop applications
    firefox thunderbird pidgin anki feh mpv gucharmap mplayer evince
    steam steam-run-native
    # Programming
    python3
    python2
    jre
    gcc
    rustup
    # My packages
    my-icons
    (texlive.combine {
      inherit (texlive) scheme-medium pgfplots enumitem;
    })
  ];

  ## Per-program configuration

  # fish
  programs.fish = {
    enable = true;
  };
  users.defaultUserShell = pkgs.fish;

  environment.shellAliases = {
    ll = "ls -alFh";
    la = "ls -A";
    l = "ls -CF";
    ltr = "ls -ltr";
    latr = "ls -lAtr";

    psgrep = "ps auxww|grep -v grep|egrep";
    lsgrep = "ls|egrep -i";

    g = "git";

    c = "cargo";
    cr = "cargo run";
    crr = "cargo run --release";
    cb = "cargo build";
    ct = "cargo test";

    v = "nvim";
  };
  programs.fish.interactiveShellInit = fishGreeting;
  programs.fish.promptInit = fishPrompt;

  # bash
  programs.bash.interactiveShellInit = ''
    HISTCONTROL=ignoredups:ignorespace
    HISTSIZE=1000
    HISTFILESIZE=2000

    shopt -s histappend
    shopt -s checkwinsize
  '';
  programs.bash.promptInit = ''
    if [ "$TERM" != "dumb" -o -n "$INSIDE_EMACS" ]; then
      PROMPT_COMMAND='export PS1=$(${promptCommand} $(jobs|grep Stopped|wc -l) $(jobs|grep Running|wc -l))'
    fi
  '';

  # Wireshark
  programs.wireshark.enable = true;

  # Git
  environment.etc."gitconfig" = {
    text = gitConfig;
    mode = "444";
  };

  ## Misc

  # Environment variables
  environment.extraInit = ''
    ${themeEnv}
    export MOZ_USE_XINPUT2=1
    export HTOPRC=${htopConfig}
    export EDITOR=${pkgs.nvim}/bin/nvim
  '';
}
