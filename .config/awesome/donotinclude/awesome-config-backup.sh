#!/bin/bash

### --- Define Config File Path/Names --- ###

## Current Date and Time
NOW=$(date +"%Y-%m-%d_%H:%M:%S")
currentDate=$(date +"%Y-%m-%d")
currentTime=$(date +"%H-%M-%S")

UserName=$(whoami)

# Config Directory Path
awesomeconfigdir="$HOME/.config/awesome/"

### --- Define Backup Location --- ###
backupdirname="$HOME/backup/awesomewm/awesomewm-config-backups/"
#/home/dampsock

### --- Define Backup Extension --- ###
awesome_backup_extension=".BAK"

## Config File Names
awesome_themes_config_file="theme.lua"
awesome_rc_config_file="rc.lua"

### --- Combine Path and File Strings --- ###
## Full Config File Path
awesome_config_themes_path="$awesomeconfigdir$awesome_themes_config_file"
awesome_config_rc_path="$awesomeconfigdir$awesome_rc_config_file"
awesome_backup_dir_path="$backupdirname$currentDate"
awesome_backup_themes_path="$awesome_backup_dir_path/$currentTime-$currentDate-$awesome_themes_config_file$awesome_backup_extension"
awesome_backup_rc_path="$awesome_backup_dir_path/$currentTime-$currentDate-$awesome_rc_config_file$awesome_backup_extension"
### ---   --- ###

mkdir $awesome_backup_dir_path -v
cp $awesome_config_rc_path -T $awesome_backup_rc_path -v
cp $awesome_config_themes_path -T $awesome_backup_themes_path -v

echo "DONE"




#######


# Create backup directory if it does not currently exist
#if [ ! -d /home/mlzboy/b2c2/shared/db ]; then
#  mkdir -p /home/mlzboy/b2c2/shared/db;
#fi
