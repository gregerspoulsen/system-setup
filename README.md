# Ansible Collection - gregerspoulsen.fluidspace


# Introduction
Basic setup for Ubuntu based system with i3 window manager. 

# Getting Started

Start by installing vagrant and virtualbox. To allow resizing of disk-images add this environment variable:
`VAGRANT_EXPERIMENTAL="disks"`

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
* Create a base that is useful on its own
* Make it possible to extend it with personal preferences with the same
  portability



Features:
* i3wm - tiling window manager
  - watch the first videos on https://i3wm.org/screenshots/ for an introduction.
  - i3wsr - automatically update workspace names from content
* espanso - text expansion
  - automatically creates symlinks to user supplied configs in user/espanso/
* chromium - base version of chrome
* vscode - Visual Studio Code
* msteams - Microsoft Teams
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

1. git clone https://github.com/gregerspoulsen/system-setup.git
2. [optional] If you want your customizations to be available from multiple
   machines, fork https://github.com/gregerspoulsen/sys-setup-gp.git and edit
   details in user_vars.yaml as desired. Be aware that the user set in this
   repo is overridden when using vagrant (either .vagrantuser or as default:
   airborne).
3. [optional] Create a .vagrantuser file, see .vagrantuser.example
5. `vagrant up`
6. Provision will now run. It takes quite some time - enjoy a break :)
8. Take it for a spin...

# Developing

To iterate quicker when developing the vagrant code you can create a folder
with the two folders base and user and set host_mount = true in
.vagrantuser. Instead of cloning from github vagrant will then mount the the
parent folder of base on the host at ~/sytup.

You should also be aware of the vagrants snapshot function as this enables
creating and restoring a box to avoid building everything from scratch each
time.

# Structure
Currently this just consist of bunch of playbooks that are importer in basic.yaml. Variables are passed forward using set_fact - this is not a beautiful way to do it, in the future this should be converted to a role instead.
