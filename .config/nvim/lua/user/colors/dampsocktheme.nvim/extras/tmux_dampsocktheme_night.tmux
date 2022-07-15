#!/usr/bin/env bash

# DampSockTheme colors for Tmux

set -g mode-style "fg=#75a2f7,bg=#2a3150"

set -g message-style "fg=#75a2f7,bg=#2a3150"
set -g message-command-style "fg=#75a2f7,bg=#2a3150"

set -g pane-border-style "fg=#2a3150"
set -g pane-active-border-style "fg=#75a2f7"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#75a2f7,bg=#16161e"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#15161E,bg=#75a2f7,bold] #S #[fg=#75a2f7,bg=#16161e,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#75a2f7,bg=#16161e] #{prefix_highlight} #[fg=#2a3150,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#75a2f7,bg=#2a3150] %Y-%m-%d  %I:%M %p #[fg=#75a2f7,bg=#2a3150,nobold,nounderscore,noitalics]#[fg=#15161E,bg=#75a2f7,bold] #h "

setw -g window-status-activity-style "underscore,fg=#98a0c5,bg=#16161e"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#98a0c5,bg=#16161e"
setw -g window-status-format "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#16161e,bg=#2a3150,nobold,nounderscore,noitalics]#[fg=#75a2f7,bg=#2a3150,bold] #I  #W #F #[fg=#2a3150,bg=#16161e,nobold,nounderscore,noitalics]"
  