#!/usr/bin/env zsh

# AWS Configuration
export AWS_DEFAULT_REGION="us-east-2"

# AWS Profiles
export CO_DEV_PROFILE="default"    # Default AWS profile

# Load zsh colors
autoload -U colors && colors

# Regular Colors
RESET='\033[0m'
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'

# Tool-specific colors
node_color='\033[0;32m'       # Green
aws_color='\033[38;5;216m'    # Orange
python_color='\033[38;5;223m' # Light yellow
