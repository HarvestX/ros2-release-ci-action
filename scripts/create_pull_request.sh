#!/usr/bin/env bash

set -euo pipefail

main() {
  target_package_name=$1
  ver_from=$2
  ver_to=$3

  base_branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')

  pr_url=$(gh pr create \
    --title "Upgrade: $target_package_name $ver_from -> $ver_to" \
    --base $base_branch \
    --body "Version has been upgraded from $ver_from -> $ver_to.")

  ## Need to parser URL and get PR number
  if [ -z $pr_url ]; then
    echo "PR didn't successfully created."
    exit 1
  fi
  echo "pr-url=$pr_url" >> $GITHUB_OUTPUT
}

main "$1" "$2" "$3"
