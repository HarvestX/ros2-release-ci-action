#!/usr/bin/env bash

set -euo pipefail

main() {
  target_package_name=$1

  current_version=""
  for package_file in $(find . -name 'package.xml'); do
    if ! grep -q "<name>$target_package_name</name>" $package_file; then
      continue
    fi

    current_version=$(grep -oP '(?<=<version>).*?(?=</version>)' $package_file)
  done
  if [ -z "$current_version" ]; then
    echo "package [$target_package_name] does not exit"
    exit 1
  fi

  echo "current_version=$current_version" >>$GITHUB_OUTPUT
}

main "$1"
