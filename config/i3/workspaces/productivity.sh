!#/bin/bash
# Setup Productivity Workspace

i3-msg "workspace 1; append_layout /static/config/i3/workspaces/productivity.json"
asana &
dynalist &