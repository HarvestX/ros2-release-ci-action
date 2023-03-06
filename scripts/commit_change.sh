#!/usr/bin/env bash

set -euo pipefail

main() {
  user_name=$1
  user_email=$2

  echo "User is: $user_name"
  echo "Email is: $user_email"

  ver_from=$3
  ver_to=$4

  git config --local user.name $user_name
  git config --local user.email $user_email

  git switch -c release/$ver_to
  git add -A
  git commit -m "Version upgrade  $ver_from -> $ver_to"
  git push --set-upstream origin release/$ver_to
}

main "$1" "$2" "$3" "$4"