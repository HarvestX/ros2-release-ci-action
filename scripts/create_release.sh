#!/usr/bin/env bash

set -euo pipefail

main() {
  branch=$1
  pr_url=$2
  ver_to=$3

  release_url=$(gh release create v$ver_to --draft --generate-notes --target $branch)
  gh pr edit $pr_url --body "Release has been created. Please check out the link below before marge this PR <br /> $release_url"
}

main "$1" "$2" "$3"