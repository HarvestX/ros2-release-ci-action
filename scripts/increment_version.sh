#!/usr/bin/env bash

set -euo pipefail

main() {
  current_version=$1
  fragment=$2

  regex="([0-9]+).([0-9]+).([0-9]+)"
  major=0
  feature=0
  bug=0
  if [[ $current_version =~ $regex ]]; then
    major="${BASH_REMATCH[1]}"
    feature="${BASH_REMATCH[2]}"
    bug="${BASH_REMATCH[3]}"
  else
    echo "Given version [$current_version] is invalid format"
    exit 1
  fi

  case $fragment in
  "major")
    ((++major))
    feature=0
    bug=0
    ;;
  "feature")
    ((++feature))
    bug=0
    ;;
  "bug")
    ((++bug))
    ;;
  *)
    echo "Invalid fragment [$fragment] given"
    exit 1
    ;;
  esac

  echo "next-version=$major.$feature.$bug" >>$GITHUB_OUTPUT
}

main $1 $2
