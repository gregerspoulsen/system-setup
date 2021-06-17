

# Introduction
Basic setup for Ubuntu based system with i3 window manger. 

# Purpose
The purpose of this project is two fold:
* To be able to take your preferred development environment with you whereever
  your journey takes you - you should be able to easily re-create it everywhere
* Make it really simple to share tricks that makes your life as developer more
  enjoyable.

# Principles
To the author that currently means:
* Create an environment based on recipes so it can be recreated everywhere
* Support both VM based and native setups.
* Create a base that is really useful on its own
* Make it possible to extend it with personal preferences with the same
  portability



Features:
* i3wm - tiling window manager
  - watch the first videos on https://i3wm.org/screenshots/ for an introduction.
  - i3wsr - automatically update workspace names from content
* espanso - text expansion
  - automatically creates symlinks to user supplied configs in /static/personal/espanso/
* chromium - base version of chrome
* vscode - Visual Studio Code
* msteams - Microsoft Teams
* thunderbird
  - requires manual configuration
  - install addon: owl
  - open settings for owl addon to add profile
* web app links
  - add scripts/* to /usr/bin for easy access from dmenu
  - standard includes webapps like asana, google calendar, miro, dynalist
* remmina - access Windows machines through RDP


Workspaces
* 1 - Productivity (Asana + Dynalist)
* 10 - Browsing. Can be accessed with $mod+0 or $mod+b


## Keyboard Shortcuts

Print-Screen: gnome-screenshot tool
ctrl+$mod+N: Setup workspace (ctrl+$mod+1 setups productivity workspace with apps)
$mod + Pause: System Monitor
$mod + F12: Control Center

# Creating a VM with Vagrant

1. Clone this repo to a local folder
2. [optional] Fork https://github.com/gregerspoulsen/sys-setup-gp.git and edit details in
   personal_vars.yaml as desired.
3. [optional] Create a .vagrantuser file, see .vagrantuser.example
5. `vagrant up`
6. Provision will now run and take quite some time, enjoy a break :)
8. Take it for a spin...