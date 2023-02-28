#!/usr/bin/env bash

set -euo pipefail

main() {
  target_package_name=$1

  user_name=$2
  user_email=$3

  ver_from=$4
  ver_to=$5

  branch=upgrade/$target_package_name-$ver_to

  git config --local user.name $user_name
  git config --local user.email $user_email

  git switch -c $branch
  git add -A
  git commit -m "Version upgrade  $ver_from -> $ver_to"
  git push --set-upstream origin $branch

  echo "head-branch=$branch" >>$GITHUB_OUTPUT
}

main "$1" "$2" "$3" "$4" "$5"