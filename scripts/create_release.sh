#!/usr/bin/env bash

set -euo pipefail

main() {
  release_url=$1
  ver_from=$2
  ver_to=$3

  base_branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')

  gh pr create \
    --title "Release: $ver_from -> $ver_to" \
    --base $base_branch --head release/$ver_to \
    --body "Version has been upgraded from $ver_from -> $ver_to. \n\
      Check the release page: $release_url"

  gh release create v$ver_to --draft --generate-notes --target release/$ver_to
}

main "$1" "$2" "$3"