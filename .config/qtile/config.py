# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Match, Key, Screen
from libqtile.lazy import lazy
from Xlib import display as xdisplay
from libqtile.dgroups import simple_key_binder
import os
import subprocess

mod = "mod4"
terminal = "alacritty"

keys = [
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod], "h", lazy.layout.grow()),
    Key([mod], "l", lazy.layout.shrink()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
    Key([mod, "shift"], "f",lazy.window.toggle_floating()),
    Key([mod], "f",lazy.window.toggle_fullscreen()),
    Key([mod], "period",lazy.next_screen()),
    Key([mod], "comma",lazy.prev_screen()),
    Key([mod], "b",lazy.hide_show_bar()),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "x", lazy.window.kill()),
    Key([mod], "Return", lazy.spawn("%s -e zsh" % terminal)),
    Key([mod], "p", lazy.spawn("rofi -show run")),
    Key([mod], "w", lazy.spawn("firefox")),
    Key([mod], "i", lazy.spawn("firefox --private-window")),
    Key([mod], "c", lazy.spawn("%s -e cmus" % terminal)),
    Key([mod], "t", lazy.spawn("teams")),
    Key([mod], "d", lazy.spawn("discord")),
    Key([mod], "z", lazy.spawn("zathura")),
    Key([mod], "e", lazy.spawn("eclipse")),
    Key([mod], "s", lazy.spawn("steam")),
    Key([mod], "m", lazy.spawn("multimc")),
    Key([mod], "n", lazy.spawn("neovide --multiGrid")),
    Key([mod], "y", lazy.spawn("firefox --new-window https://youtube.com/")),
    Key([mod], "space", lazy.spawn("picom -b --experimental-backends")),
    Key([mod, "shift"], "space", lazy.spawn("pkill picom")),
    Key([mod, "shift"], "x", lazy.spawn("xkill")),
    Key([mod, "shift"], "p", lazy.spawn("flameshot gui")),
    Key([mod, "shift"], "r", lazy.spawn("systemctl reboot")),
    Key([mod, "shift"], "s", lazy.spawn("systemctl poweroff")),
    Key([mod, "shift"], "h", lazy.spawn("systemctl hibernate")),
    Key([mod, "shift"], "l", lazy.spawn("systemctl suspend")),
    Key([mod], "q", lazy.restart()),
    Key([mod, "shift"], "q", lazy.shutdown()),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pulsemixer --change-volume +2")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pulsemixer --change-volume -2")),
    Key([], "XF86AudioMute", lazy.spawn("pulsemixer --toggle-mute")),
]

groups = [
        Group(""),
        Group(""),
        Group(""),
        Group("拾"),
        Group(""),
        Group(""),
        Group("漣"),
        Group(""),
        Group("ﱘ"),
        Group(""),
]

layout_theme = {"border_width": 1,
                "margin": 5,
                "border_focus": "0000ff",
                "border_normal": "222222",
                "single_border_width": 0,
                "single_margin": 0
                }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Floating(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Max(),
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='Iosevka Custom',
    fontsize=12,
    padding=2,
)
extension_defaults = widget_defaults.copy()

colors = [["#000000", "#000000"], # black
          ["#0000ff", "#0000ff"], # blue
          ["#ffffff", "#ffffff"], # white
          ["#222222", "#222222"], # dark gray
          ]

screens = []

def get_num_monitors():
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        return 1
    else:
        return num_monitors

num_monitors = get_num_monitors()

for m in range(num_monitors):
    screens.append(
        Screen(
            top=bar.Bar(
                [
                    widget.GroupBox(
                        highlight_method="text", 
                        center_aligned=False,
                        rounded=False,
                        active=colors[2],
                        inactive=colors[3],
                        this_current_screen_border = colors[1],
                        this_screen_border = colors [0],
                        other_current_screen_border = colors[3],
                        other_screen_border = colors[0],
                        font='Symbols Nerd Font',
                        fontsize = 14,
                        ),
                    widget.TaskList(
                        borderwidth = 1,
                        highlight_method = "block",
                        border = "#0000ff",
                        unfocused_borders = "#222222",
                        ),
                    widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[1],
                       padding = 0,
                       ),
#                      widget.TextBox(
                       #  text = "墳",
                       #  background = colors[1],
                       #  foreground = colors[0],
                       #  fontsize = 20,
                       #  padding = 0,
                       #  ),
                    widget.PulseVolume(
                       background = colors[1],
                       foreground = colors[0],
                       volume_app = "%s -e pulsemixer" % terminal,
                        ),
                    widget.TextBox(
                       text = '',
                       background = colors[1],
                       foreground = colors[3],
                       fontsize = 20,
                       padding = 0,
                       ),
                    widget.CheckUpdates(
                       background = colors[3],
                       foreground = colors[2],
                       distro = "Arch_checkupdates",
                       display_format = "ﮮ {updates}",
                       no_update_string = "ﮮ 0",
                       update_interval = 600,
                       execute = "%s -e paru" % terminal,
                       fontsize = 14,
                    ),
                    widget.TextBox(
                       text = '',
                       background = colors[3],
                       foreground = colors[1],
                       fontsize = 20,
                       padding = 0,
                       ),
                  widget.Memory(
                       background=colors[1],
                       foreground=colors[0],
                       format = '{MemUsed}M/{MemTotal}M'
                       ),
                   widget.TextBox(
                       text = '',
                       background = colors[1],
                       foreground = colors[3],
                       fontsize = 20,
                       padding = 0,
                       ),
                  widget.CPU(
                       background=colors[3],
                       foreground=colors[2],
                       format = ' {freq_current}GHz {load_percent}%'
                       ),
                  widget.TextBox(
                       text = '',
                       background = colors[3],
                       foreground = colors[1],
                       fontsize = 20,
                       padding = 0,
                       ),
                  widget.Battery(
                       format = {"percent:2.0%"},
                       background = colors[1],
                       foreground = colors[0],
                       ),
                  widget.TextBox(
                       text = '',
                       background = colors[1],
                       foreground = colors[3],
                       fontsize = 20,
                       padding = 0
                       ),
                    widget.Clock(
                       format=' %b %_d, %a %_m %l:%M %p',
                       background=colors[3],
                       foreground=colors[2],
                       ),
                ],
                24,
            ),
        )
    )

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = simple_key_binder("mod4")
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
   *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])

auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
