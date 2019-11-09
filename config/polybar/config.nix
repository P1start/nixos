{ pkgs }:
with pkgs;
let
  python3 = python37Packages.python;
in
''
[colors]
background = ''${xrdb:colorscheme.background:#000000}
background-alt = ''${xrdb:colorscheme.highlight:#ffffff}
foreground = ''${xrdb:colorscheme.foreground:#dddddd}
foreground-alt = ''${xrdb:colorscheme.highlight:#ffffff}
primary = ''${xrdb:colorscheme.background:#ffffff}
secondary = #e60053
alert = ''${xrdb:colorscheme.alert:#ff0000}

[bar/main]
enable-ipc = true

bottom = false
monitor =
width = 100%
height = 35
radius = 0.0
fixed-center = true

background = ''${colors.background}
foreground = ''${colors.foreground}

line-size = 3
line-color = #f00

border-top-size = 0
border-left-size = 0
border-right-size = 0
border-color = #00000000

padding-left = 1
padding-right = 3

module-margin-left = 2
module-margin-right = 2

font-0 = "scientifica:pixelsize=10;1"
font-1 = "Unifont upper:size=12:antialias=false;1"
font-2 = "Unifont:size=12:antialias=false;0"
font-3 = "Unifont upper:size=12:antialias=false;1"
font-4 = "Unifont:size=12:antialias=false;1"
font-5 = "Unifont:size=12:antialias=false;-1"
font-6 = "Symbola:pixelsize=10;1"
font-7 = "FontAwesome:pixelsize=11;2"
font-8 = "Droid Sans Mono Slashed for Powerline:pixelsize=10;1"
font-9 = "Terminus:pixelsize=12;0"
font-10 = "scientifica:pixelsize=10;0"

modules-left = i3
modules-center = custom-date
modules-right = mpd reminder wlan xkeyboard volume battery tray

tray-position = right
tray-padding = 2
;tray-transparent = true
;tray-background = #0063ff

;wm-restack = bspwm
;wm-restack = i3

;override-redirect = true

;scroll-up = bspwm-desknext
;scroll-down = bspwm-deskprev

;scroll-up = i3wm-wsnext
;scroll-down = i3wm-wsprev

[module/custom-date]
type = custom/script
exec = ${python3}/bin/python3 ${polybarModules}/date.py
click-left = ${python3}/bin/python3 ${polybarModules}/date.py toggle
interval = 1

[module/reminder]
type = custom/script
exec = ${python3}/bin/python3 ${polybarModules}/reminders.py
exec-if = ${python3}/bin/python3 ${polybarModules}/reminders.py
click-left = ${python3}/bin/python3 ${polybarModules}/reminders.py dismiss
interval = 1
; The underline colour is actually set by the script - however, we need this line for the underline
; to show up at all
;format-underline = ''${colors.alert}

[module/xwindow]
type = internal/xwindow
label = %title:0:30:...%

[module/xkeyboard]
type = internal/xkeyboard
blacklist-0 = num lock

#format-prefix = " "
format-prefix =
format-prefix-foreground = ''${colors.foreground}
format-prefix-underline = ''${colors.primary}

label-layout = %layout%
label-layout-underline = ''${colors.primary}

label-indicator-padding = 2
label-indicator-margin = 1
label-indicator-background = ''${colors.secondary}
label-indicator-underline = ''${colors.secondary}

[module/filesystem]
type = internal/fs
interval = 25

mount-0 = /

format-unmounted-underline = ''${colors.primary}
format-mounted-underline = ''${colors.primary}
label-mounted = %{F#0a81f5}%mountpoint%%{F-}: %percentage_used%%
label-unmounted = %mountpoint% not mounted
label-unmounted-foreground = ''${colors.foreground}

[module/bspwm]
type = internal/bspwm

label-focused = %index%
label-focused-background = ''${colors.background}
#''${colors.background-alt}
label-focused-foreground = ''${colors.foreground-alt}
label-focused-underline= ''${colors.background}
label-focused-padding = 2

label-occupied = %index%
label-occupied-padding = 2

label-urgent = %index%!
label-urgent-background = ''${colors.alert}
label-urgent-foreground = #fff
label-urgent-underline = ''${colors.alert}
label-urgent-padding = 2

label-empty = %index%
label-empty-foreground = ''${colors.foreground-alt}
label-empty-padding = 2

[module/i3]
ws-icon-0 = 1;web
ws-icon-1 = 2;code
ws-icon-2 = 3;talk
ws-icon-11 = 9;music
ws-icon-3 = 10;notes
ws-icon-4 = 11;chars
ws-icon-5 = 12;email

ws-icon-6 = 4;misc 0
ws-icon-7 = 5;misc 1
ws-icon-8 = 6;misc 2
ws-icon-9 = 7;misc 3
ws-icon-10 = 8;misc 4

type = internal/i3
format = <label-state> <label-mode>
index-sort = true
wrapping-scroll = false

; Only show workspaces on the same output as the bar
;pin-workspaces = true

label-mode-padding = 2
label-mode-foreground = #fff
label-mode-background = ''${colors.primary}

; focused = Active workspace on focused monitor
label-focused = %icon%
label-focused-background = ''${module/bspwm.label-focused-background}
label-focused-foreground = ''${module/bspwm.label-focused-foreground}
label-focused-underline = ''${module/bspwm.label-focused-underline}
label-focused-padding = ''${module/bspwm.label-focused-padding}

; unfocused = Inactive workspace on any monitor
label-unfocused = %icon%
label-unfocused-padding = ''${module/bspwm.label-occupied-padding}

; visible = Active workspace on unfocused monitor
label-visible = %icon%
label-visible-background = ''${self.label-focused-background}
label-visible-underline = ''${self.label-focused-underline}
label-visible-padding = ''${self.label-focused-padding}

; urgent = Workspace with urgency hint set
label-urgent = %icon%
label-urgent-background = ''${module/bspwm.label-urgent-background}
label-urgent-foreground = ''${module/bspwm.label-urgent-foreground}
label-urgent-underline = ''${module/bspwm.label-urgent-underline}
label-urgent-padding = ''${module/bspwm.label-urgent-padding}

[module/mpd]
type = internal/mpd
format-online = <label-song>  <icon-prev> <icon-stop> <toggle> <icon-next>

host = "/tmp/mpd.sock"

icon-prev = "%{T11}⏪%{T1} "
icon-stop = "⏹ "
icon-play = "⏴ "
icon-pause = "⏸ "
icon-next = %{T11}⏩

label-song = %artist% - %title%
label-song-maxlen = 60
label-song-ellipsis = true

[module/xbacklight]
type = internal/xbacklight

format = <label> <bar>
label = BL

bar-width = 10
bar-indicator = |
bar-indicator-foreground = #ff
bar-indicator-font = 2
bar-fill = ─
bar-fill-font = 2
bar-fill-foreground = #9f78e1
bar-empty = ─
bar-empty-font = 2
bar-empty-foreground = ''${colors.foreground-alt}

[module/backlight-acpi]
inherit = module/xbacklight
type = internal/backlight
card = intel_backlight

[module/cpu]
type = internal/cpu
interval = 2
format-prefix = " "
format-prefix-foreground = ''${colors.foreground}
format-underline = ''${colors.primary}
label = %percentage%%

[module/memory]
type = internal/memory
interval = 2
format-prefix = "%{T7} "
format-prefix-foreground = ''${colors.foreground}
format-underline = ''${colors.primary}
label = %percentage_used%%

[module/wlan]
type = internal/network
interface = wlp3s0
interval = 3.0

;format-connected = <label-connected>
format-connected = <label-connected>
; No idea why this works or is necessary...
format-connected-prefix = %{F''${colors.foreground
format-connected-underline = ''${colors.primary}
label-connected = %essid%

format-disconnected = %{F''${colors.foreground}no wifi
; See above
;format-disconnected-underline = ''${colors.alert}
;format-disconnected = <label-disconnected>
;format-disconnected-underline = ''${self.format-connected-underline}
;label-disconnected = %ifname% disconnected
;label-disconnected-foreground = ''${colors.foreground-alt}

ramp-signal-0 = 
ramp-signal-1 = 
ramp-signal-2 = 
ramp-signal-3 = 
ramp-signal-4 = 
ramp-signal-foreground = ''${colors.foreground}

[module/eth]
type = internal/network
interface = 
interval = 3.0

format-connected-underline = #55aa55
format-connected-prefix = " "
format-connected-prefix-foreground = ''${colors.foreground-alt}
label-connected = %local_ip%

format-disconnected =
;format-disconnected = <label-disconnected>
;format-disconnected-underline = ''${self.format-connected-underline}
;label-disconnected = %ifname% disconnected
;label-disconnected-foreground = ''${colors.foreground-alt}

[module/date]
type = internal/date
interval = 1

date = "%Y-%m-%d"
date-alt = "%A %d %B"

time = "%H:%M"
time-alt = %H:%M

#format-prefix = " "
format-prefix =
format-prefix-foreground = ''${colors.foreground-alt}
format-underline = ''${colors.primary}

label = %date% %time%

[module/volume]
type = internal/pulseaudio
sink = alsa_output.pci-0000_00_1b.0.analog-stereo

format-volume = <label-volume>
format-volume-underline = ''${colors.primary}
label-volume = "%percentage%%"
label-volume-foreground = ''${colors.foreground}

#format-muted-prefix = " "
format-muted-prefix =
format-muted-foreground = ''${colors.foreground}
format-muted-underline = ''${colors.primary}
label-muted = "mut"

;bar-volume-width = 11
;bar-volume-foreground-0 = #55aa55
;bar-volume-foreground-1 = #55aa55
;bar-volume-foreground-2 = #55aa55
;bar-volume-foreground-3 = #55aa55
;bar-volume-foreground-4 = #55aa55
;bar-volume-foreground-5 = #f5a70a
;bar-volume-foreground-6 = #ff5555
;bar-volume-gradient = false
;bar-volume-indicator = |
;bar-volume-indicator-font = 2
;bar-volume-fill = ─
;bar-volume-fill-font = 2
;bar-volume-empty = ─
;bar-volume-empty-font = 2
;bar-volume-empty-foreground = ''${colors.foreground-alt}

[module/battery]
type = internal/battery
battery = BAT0
adapter = AC0
full-at = 96

format-charging = <animation-charging><label-charging>
format-charging-underline = ''${colors.primary}

format-discharging = <ramp-capacity><label-discharging>
#format-discharging-underline = ''${colors.alert}

#format-full-prefix = " "
format-full = "100%"
#format-full-prefix = "CHG "
#format-full-prefix-foreground = ''${colors.foreground}
#format-full-underline = ''${self.format-charging-underline}

ramp-capacity-0 = "↓"
ramp-capacity-foreground = ''${colors.foreground}

animation-charging-0 = "↑"
animation-charging-foreground = ''${colors.foreground}
animation-charging-framerate = 750

[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 60

format = <ramp> <label>
format-underline = #f50a4d
format-warn = <ramp> <label-warn>
format-warn-underline = ''${self.format-underline}

label = %temperature%
label-warn = %temperature%
label-warn-foreground = ''${colors.secondary}

ramp-0 = 
ramp-1 = 
ramp-2 = 
ramp-foreground = ''${colors.foreground-alt}

[module/powermenu]
type = custom/menu

format-spacing = 1

label-open = 
label-open-foreground = ''${colors.secondary}
label-close =  cancel
label-close-foreground = ''${colors.secondary}
label-separator = |
label-separator-foreground = ''${colors.foreground-alt}

menu-0-0 = reboot
menu-0-0-exec = menu-open-1
menu-0-1 = power off
menu-0-1-exec = menu-open-2

menu-1-0 = cancel
menu-1-0-exec = menu-open-0
menu-1-1 = reboot
menu-1-1-exec = sudo reboot

menu-2-0 = power off
menu-2-0-exec = sudo poweroff
menu-2-1 = cancel
menu-2-1-exec = menu-open-0

[settings]
screenchange-reload = true
;compositing-background = xor
;compositing-background = screen
;compositing-foreground = source
;compositing-border = over

[global/wm]
margin-top = 5
margin-bottom = 0
; vim:ft=dosini
''
