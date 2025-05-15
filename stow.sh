#!/bin/bash
set -euo pipefail

## Stow Management Script
### Version: 1.0 (2025-05-15)

main() {
  local action="${1:-}"
  case "$action" in
  stow | delete)
    shift
    validate_packages "$@"
    run_stow_action "$action" "$@"
    ;;
  all | clean)
    run_stow_action "$action"
    ;;
  -h | --help | "")
    show_help
    ;;
  *)
    echo "Error: Invalid action '$action'"
    show_help
    exit 1
    ;;
  esac
}

run_stow_action() {
  local action="$1"
  shift
  local packages="${*:-*/}"

  case "$action" in
  stow) stow --verbose --target="$HOME" --restow $packages ;;
  delete) stow --verbose --target="$HOME" --delete $packages ;;
  all) stow --verbose --target="$HOME" --restow */ ;;
  clean) stow --verbose --target="$HOME" --delete */ ;;
  esac
}

validate_packages() {
  if [ $# -eq 0 ]; then
    echo "Error: No packages specified"
    show_help
    exit 1
  fi
}

show_help() {
  cat <<EOF
Stow Management Script

Usage:
  $(basename "$0") [ACTION] [PACKAGES...]

Actions:
  stow <packages>  - Restow specified packages
  delete <packages> - Delete specified packages
  all              - Restow all packages (default action)
  clean            - Delete all packages
  -h, --help       - Show this help message

Examples:
  $(basename "$0") stow zsh nvim
  $(basename "$0") delete tmux
  $(basename "$0") all
  $(basename "$0") clean
EOF
}

main "$@"
