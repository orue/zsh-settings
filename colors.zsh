#!/usr/bin/env zsh

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
python_color='\033[38;2;229;200;144m' # Yellow: #e5c890
