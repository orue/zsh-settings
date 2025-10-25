#!/usr/bin/env zsh

# AWS Configuration
export AWS_DEFAULT_REGION="us-east-2"

# Load zsh colors
autoload -U colors && colors

# Catppuccin Frappe Colors (RGB format for true color support)
RESET='\033[0m'
Black='\033[38;2;35;38;52m'      # Crust: #232634
Red='\033[38;2;231;130;132m'     # Red: #e78284
Green='\033[38;2;166;209;137m'   # Green: #a6d189
Yellow='\033[38;2;229;200;144m'  # Yellow: #e5c890
Blue='\033[38;2;140;170;238m'    # Blue: #8caaee
Purple='\033[38;2;202;158;230m'  # Mauve: #ca9ee6
Cyan='\033[38;2;129;200;190m'    # Teal: #81c8be
White='\033[38;2;198;208;245m'   # Text: #c6d0f5

# Tool-specific colors
node_color='\033[38;2;166;209;137m'   # Green: #a6d189
aws_color='\033[38;2;239;159;118m'    # Peach: #ef9f76
python_color='\033[38;2;229;200;144m' # Yellow: #e5c890
