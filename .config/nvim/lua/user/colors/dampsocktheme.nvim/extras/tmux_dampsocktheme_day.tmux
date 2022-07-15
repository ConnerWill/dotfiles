#!/usr/bin/env bash

# DampSockTheme colors for Tmux

set -g mode-style "fg=#2d7fe5,bg=#bec2dd"

set -g message-style "fg=#2d7fe5,bg=#bec2dd"
set -g message-command-style "fg=#2d7fe5,bg=#bec2dd"

set -g pane-border-style "fg=#bec2dd"
set -g pane-active-border-style "fg=#2d7fe5"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#2d7fe5,bg=#e9e9ec"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#e9e9ed,bg=#2d7fe5,bold] #S #[fg=#2d7fe5,bg=#e9e9ec,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#e9e9ec,bg=#e9e9ec,nobold,nounderscore,noitalics]#[fg=#2d7fe5,bg=#e9e9ec] #{prefix_highlight} #[fg=#bec2dd,bg=#e9e9ec,nobold,nounderscore,noitalics]#[fg=#2d7fe5,bg=#bec2dd] %Y-%m-%d  %I:%M %p #[fg=#2d7fe5,bg=#bec2dd,nobold,nounderscore,noitalics]#[fg=#e9e9ed,bg=#2d7fe5,bold] #h "

setw -g window-status-activity-style "underscore,fg=#727eaf,bg=#e9e9ec"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#727eaf,bg=#e9e9ec"
setw -g window-status-format "#[fg=#e9e9ec,bg=#e9e9ec,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#e9e9ec,bg=#e9e9ec,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#e9e9ec,bg=#bec2dd,nobold,nounderscore,noitalics]#[fg=#2d7fe5,bg=#bec2dd,bold] #I  #W #F #[fg=#bec2dd,bg=#e9e9ec,nobold,nounderscore,noitalics]"
  