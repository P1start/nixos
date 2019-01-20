{ pkgs }:
''
set $mod Mod4

# These aren't used any more
set $active_colour 686868
set $inactive_colour 424242
set $urgent_colour d63131 

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below. ISO 10646 = Unicode

#font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
#font -*-terminus-medium-*-*-*-12-*-*-*-*-*-*-u
font pango:scientifica 8

# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, if you need a lot of unicode glyphs or
# right-to-left text rendering, you should instead use pango for rendering and
# chose a FreeType font, such as:
# font pango:DejaVu Sans Mono 10
#font pango:Roboto Bold 10

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec --no-startup-id ${pkgs.terminalCommand}

# kill focused window
bindsym $mod+Shift+q kill

# start rofi
bindsym $mod+d exec --no-startup-id ${pkgs.rofi}/bin/rofi -show run -theme ${pkgs.rofiTheme}
bindsym $mod+Shift+d exec --no-startup-id ${pkgs.rofi}/bin/rofi -show drun -theme ${pkgs.rofiTheme}

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# alternatively, you can also use mod+tab:
bindsym $mod+Tab focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+y split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
bindsym $mod+c focus child

# switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10
bindsym $mod+minus workspace 11
bindsym $mod+equal workspace 12

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5
bindsym $mod+Shift+6 move container to workspace number 6
bindsym $mod+Shift+7 move container to workspace number 7
bindsym $mod+Shift+8 move container to workspace number 8
bindsym $mod+Shift+9 move container to workspace number 9
bindsym $mod+Shift+0 move container to workspace number 10
bindsym $mod+Shift+minus move container to workspace number 11
bindsym $mod+Shift+equal move container to workspace number 12

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec --no-startup-id "${pkgs.i3}/bin/i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' '${pkgs.i3}/bin/i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
    # These bindings trigger as soon as you enter the resize mode

    # Pressing left will shrink the window’s width.
    # Pressing right will grow the window’s width.
    # Pressing up will shrink the window’s height.
    # Pressing down will grow the window’s height.
    bindsym h resize shrink width 10 px or 10 ppt
    bindsym j resize grow height 10 px or 10 ppt
    bindsym k resize shrink height 10 px or 10 ppt
    bindsym l resize grow width 10 px or 10 ppt

    # same bindings, but for the arrow keys
    bindsym Left resize shrink width 10 px or 10 ppt
    bindsym Down resize grow height 10 px or 10 ppt
    bindsym Up resize shrink height 10 px or 10 ppt
    bindsym Right resize grow width 10 px or 10 ppt

    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# Start polybar
exec_always --no-startup-id sh -c "${pkgs.killall}/bin/killall -9 -r '.*polybar' -u `whoami`; ${pkgs.polybar}/bin/polybar main -c ${pkgs.polybarConfig}"

# Start up a few applications
exec --no-startup-id ${pkgs.firefox}/bin/firefox
exec --no-startup-id sh -c '${pkgs.thunderbird}/bin/thunderbird'
exec --no-startup-id ${pkgs.pidgin}/bin/pidgin
exec --no-startup-id ${pkgs.gucharmap}/bin/gucharmap
exec --no-startup-id ${pkgs.terminalCommand} -e "${pkgs.nvim}/bin/nvim $HOME/org/main.org" --name=termite-notes
exec --no-startup-id ${pkgs.anki}/bin/anki
exec --no-startup-id ${pkgs.terminalCommand} -e ${pkgs.ncmpcpp}/bin/ncmpcpp --name=termite-music

# Hide borders
hide_edge_borders both

# Gaps!!!
gaps inner 10

# Smart borders
smart_borders no_gaps

# Application workspace assignments
assign [class="Firefox-trunk"] 1
assign [class="Firefox"] 1
assign [class="X-www-browser"] 1

assign [class="Sublime-text"] 2
assign [class="Code"] 2

assign [class="Pidgin"] 3

assign [instance="termite-music"] 9

assign [instance="termite-notes"] 10
assign [class="Anki"] 10

assign [class="Gucharmap"] 11

assign [class="Daily"] 12
assign [class="Thunderbird"] 12

# Hide titlebars, set window borders
for_window [class="^.*"] border pixel 5
for_window [class="Termite"] border none

# Title bar format
for_window [class=".*"] title_format "  %title  "

# Colours
#set $active_window_colour #7487d7
set_from_resource $active_window_colour colorscheme.background #000000
set_from_resource $inactive_window_colour colorscheme.window-unfocused #000000
#set $inactive_window_colour #eeeeee
#set $urgent_window_colour #d63131
set_from_resource $active_text_colour colorscheme.highlight #dddddd
set_from_resource $inactive_text_colour colorscheme.foreground #bbbbbb
set_from_resource $urgent_window_colour colorscheme.alert #000000
client.focused          $active_window_colour $active_window_colour $active_text_colour $active_window_colour
client.unfocused        $inactive_window_colour $inactive_window_colour $inactive_text_colour $inactive_window_colour
client.focused_inactive $inactive_window_colour $inactive_window_colour $inactive_text_colour $inactive_window_colour
client.urgent           $urgent_window_colour $urgent_window_colour $active_text_colour $urgent_window_colour

# Custom keyboard shortcuts
bindsym $mod+F1 exec --no-startup-id ${pkgs.xorg.setxkbmap}/bin/setxkbmap us
bindsym $mod+F2 exec --no-startup-id "${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout us,us -variant dvp,dvp"

bindsym XF86AudioPrev exec --no-startup-id ${pkgs.mpc_cli}/bin/mpc --host=/tmp/mpd.sock prev
bindsym XF86AudioPlay exec --no-startup-id ${pkgs.mpc_cli}/bin/mpc --host=/tmp/mpd.sock toggle
bindsym XF86AudioStop exec --no-startup-id ${pkgs.mpc_cli}/bin/mpc --host=/tmp/mpd.sock stop
bindsym XF86AudioNext exec --no-startup-id ${pkgs.mpc_cli}/bin/mpc --host=/tmp/mpd.sock next

bindsym $mod+ctrl+l exec --no-startup-id ${pkgs.lockCommand}

# Brightness
bindsym XF86MonBrightnessDown exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%-
bindsym XF86MonBrightnessUp exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set +5%

# Volume
bindsym XF86AudioMute exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl -- set-sink-mute 0 toggle
bindsym XF86AudioRaiseVolume exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl -- set-sink-volume 0 +3277
bindsym XF86AudioLowerVolume exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl -- set-sink-volume 0 -3277

# Shortcuts
bindsym $mod+Mod1+p exec --no-startup-id ${pkgs.terminalCommand} -e ${pkgs.python37Packages.ipython}/bin/ipython3
bindsym $mod+Mod1+Shift+p exec --no-startup-id ${pkgs.terminalCommand} -e ${pkgs.python27Packages.ipython}/bin/ipython2
bindsym $mod+Mod1+t exec --no-startup-id ${pkgs.terminalCommand} -e ${pkgs.htop}/bin/htop

focus_follows_mouse no
''
